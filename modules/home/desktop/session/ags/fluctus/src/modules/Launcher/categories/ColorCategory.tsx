import Category from "./Category"
import Item from "../Item"
import Icons from "../../../lib/icons"
import { Accessor, createComputed, For } from "gnim"
import { execAsync } from "ags/process"
import { Gdk } from "ags/gtk4"

type ColorItemProps = {
    color: string
    index: Accessor<number>
}

function copy(color: string) {
    execAsync(`wl-copy "${color}"`)
}

function ColorItem({ color, index }: ColorItemProps) {
    return (
        <Item
            title={color}
            index={color === "" ? undefined : index}
            onClicked={() => {
                copy(color)
            }}
            focusOnClick={false}
            tooltipText={"Copy to clipboard"}
        >
            <image iconName={Icons.ui.color} />
        </Item>
    )
}

export default function ColorCategory(query: Accessor<string>) {
    const color = query((q) => {
        if (q.length > 0 && q.at(0) == "#") {
            return parseColor(query().slice(1).trim())
        }
        return null
    })

    const conversions = color((c) => {
        if (c) {
            return [toHex(c), toRgb(c), toHsl(c)]
        }
        return [""]
    })

    return (
        <Category
            name={"Color"}
            action={() => {
                if (conversions().length > 0) {
                    copy(conversions()[0])
                }
            }}
            hotkey={(key) => {
                const index = key - Gdk.KEY_1
                if (0 <= index && index <= conversions().length) {
                    copy(conversions()[index])
                }
            }}
        >
            <For each={conversions}>{(c, i) => <ColorItem color={c} index={i} />}</For>
        </Category>
    ) as Category
}

interface RGB {
    r: number
    g: number
    b: number
    a?: number
}

interface HSL {
    h: number
    s: number
    l: number
    a?: number
}

type Color = RGB

function parseColor(input: string): Color | null {
    const trimmed = input.trim()

    const hexMatch = trimmed.match(/^#?([0-9a-f]{6}|[0-9a-f]{8})$/i)
    if (hexMatch) {
        let r = 0,
            g = 0,
            b = 0,
            a: number | undefined

        if (input.length === 6) {
            r = parseInt(input.slice(0, 2), 16)
            g = parseInt(input.slice(2, 4), 16)
            b = parseInt(input.slice(4, 6), 16)
        } else if (input.length === 8) {
            r = parseInt(input.slice(0, 2), 16)
            g = parseInt(input.slice(2, 4), 16)
            b = parseInt(input.slice(4, 6), 16)
            a = parseInt(input.slice(6, 8), 16) / 255
        }

        return a !== undefined ? { r, g, b, a } : { r, g, b }
    }

    const rgbaMatch = trimmed.match(
        /^rgba?\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*([\d.]+)\s*)?\)$/i,
    )
    if (rgbaMatch) {
        const result: Color = {
            r: clamp(parseInt(rgbaMatch[1]), 0, 255),
            g: clamp(parseInt(rgbaMatch[2]), 0, 255),
            b: clamp(parseInt(rgbaMatch[3]), 0, 255),
        }
        if (rgbaMatch[4]) {
            result.a = clamp(parseFloat(rgbaMatch[4]), 0, 1)
        }
        return result
    }

    const hslaMatch = trimmed.match(
        /^hsla?\s*\(\s*([\d.]+)\s*,\s*([\d.]+)%\s*,\s*([\d.]+)%\s*(?:,\s*([\d.]+)\s*)?\)$/i,
    )
    if (hslaMatch) {
        const hsl: HSL = {
            h: parseFloat(hslaMatch[1]) % 360,
            s: clamp(parseFloat(hslaMatch[2]), 0, 100),
            l: clamp(parseFloat(hslaMatch[3]), 0, 100),
        }
        if (hslaMatch[4]) {
            hsl.a = clamp(parseFloat(hslaMatch[4]), 0, 1)
        }
        return hslToRgba(hsl)
    }

    return null
}

function toHex(color: Color): string {
    const r = color.r.toString(16).padStart(2, "0")
    const g = color.g.toString(16).padStart(2, "0")
    const b = color.b.toString(16).padStart(2, "0")

    if (color.a !== undefined) {
        const a = Math.round(color.a * 255)
            .toString(16)
            .padStart(2, "0")
        return `#${r}${g}${b}${a}`
    }

    return `#${r}${g}${b}`
}

export function toRgb(color: Color): string {
    if (color.a !== undefined) {
        return `rgba(${color.r}, ${color.g}, ${color.b}, ${formatDecimal(color.a)})`
    }
    return `rgb(${color.r}, ${color.g}, ${color.b})`
}

function rgbaToHsl(color: Color): HSL {
    const r = color.r / 255
    const g = color.g / 255
    const b = color.b / 255

    const max = Math.max(r, g, b)
    const min = Math.min(r, g, b)
    const delta = max - min

    let h = 0
    let s = 0
    const l = (max + min) / 2

    if (delta !== 0) {
        s = l > 0.5 ? delta / (2 - max - min) : delta / (max + min)

        if (max === r) {
            h = ((g - b) / delta + (g < b ? 6 : 0)) / 6
        } else if (max === g) {
            h = ((b - r) / delta + 2) / 6
        } else {
            h = ((r - g) / delta + 4) / 6
        }
    }

    const result: HSL = {
        h: Math.round(h * 360),
        s: Math.round(s * 100),
        l: Math.round(l * 100),
    }

    if (color.a !== undefined) {
        result.a = color.a
    }

    return result
}

function hslToRgba(hsl: HSL): Color {
    const h = hsl.h / 360
    const s = hsl.s / 100
    const l = hsl.l / 100

    let r, g, b

    if (s === 0) {
        r = g = b = l
    } else {
        const hue2rgb = (p: number, q: number, t: number) => {
            if (t < 0) t += 1
            if (t > 1) t -= 1
            if (t < 1 / 6) return p + (q - p) * 6 * t
            if (t < 1 / 2) return q
            if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6
            return p
        }

        const q = l < 0.5 ? l * (1 + s) : l + s - l * s
        const p = 2 * l - q

        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    }

    const result: Color = {
        r: Math.round(r * 255),
        g: Math.round(g * 255),
        b: Math.round(b * 255),
    }

    if (hsl.a !== undefined) {
        result.a = hsl.a
    }

    return result
}

function toHsl(color: Color): string {
    const hsl = rgbaToHsl(color)

    if (hsl.a !== undefined) {
        return `hsla(${hsl.h}, ${hsl.s}%, ${hsl.l}%, ${formatDecimal(hsl.a)})`
    }
    return `hsl(${hsl.h}, ${hsl.s}%, ${hsl.l}%)`
}

function clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max)
}

function formatDecimal(num: number, decimals: number = 3): string {
    return Number(num.toFixed(decimals)).toString()
}
