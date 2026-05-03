import { instanceName, windowNames } from "@/windows"
import { toggleWindow } from "ags/app"
import { Gdk, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import AstalApps from "gi://AstalApps?version=0.1"
import GLib from "gi://GLib?version=2.0"
import { createState } from "gnim"

export function mod(a: number, b: number) {
    return ((a % b) + b) % b
}

export function range(length: number, start = 1) {
    return Array.from({ length }, (_, i) => i + start)
}

export function capitalize(str: string) {
    return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
}

export function hideWindows() {
    const ignore = [windowNames.bar, windowNames.osd]

    app.get_windows()
        .filter((w) => !ignore.includes(w.name))
        .forEach((w) => app.get_window(w.name)?.hide())
}

export const [activePopupWindow, setActivePopupWindow] = createState<string | undefined>(
    undefined,
)

export function toggleAppWindow(windowName: string) {
    const win = app.get_window(windowName)
    if (!win) {
        console.warn(`Window ${windowName} not found`)
        return
    }

    if (win.visible) {
        win.hide()
        setActivePopupWindow(undefined)
    } else {
        hideWindows()
        win.show()
        setActivePopupWindow(windowName)
    }
}

export function fileExists(path: string) {
    return GLib.file_test(path, GLib.FileTest.EXISTS)
}

export function isIcon(icon?: string) {
    const iconTheme = Gtk.IconTheme.get_for_display(Gdk.Display.get_default()!)
    return icon && iconTheme.has_icon(icon)
}

export function lengthStr(length: number): string {
    if (length < 0) return "0:00"
    const hours = Math.floor(length / 3600)
    if (hours > 24) return "0:00"

    const minutes = Math.floor((length % 3600) / 60)
    const seconds = Math.floor(length % 60)

    const formatTime = (value: number): string => (value < 10 ? `0${value}` : `${value}`)

    if (hours > 0) {
        return `${hours}:${formatTime(minutes)}:${formatTime(seconds)}`
    }

    return `${minutes}:${formatTime(seconds)}`
}
