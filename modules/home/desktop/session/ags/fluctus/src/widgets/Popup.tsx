import { Astal, Gdk, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import Graphene from "gi://Graphene?version=1.0"
import { createState } from "gnim"
import { toggleAppWindow } from "../lib/utils"
import Adw from "gi://Adw?version=1"

export type PopupProps = JSX.IntrinsicElements["window"] & {
    children?: any
    width?: number
    height?: number
    onKeyPressed?: (source: Gtk.EventControllerKey, keyval: number) => void
}

export default function Popup({
    children,
    name = "",
    width,
    height,
    gdkmonitor,
    halign = Gtk.Align.CENTER,
    valign = Gtk.Align.CENTER,
    marginTop = 10,
    marginBottom = 10,
    marginStart = 10,
    marginEnd = 10,
    onKeyPressed,
    ...props
}: PopupProps) {
    const { TOP, BOTTOM, RIGHT, LEFT } = Astal.WindowAnchor
    const [visible, setVisible] = createState(false)

    const show = () => {
        setVisible(true)
    }

    const hide = () => {
        setVisible(false)
    }

    let content: Adw.Clamp

    let anchor = 0
    if (valign === Gtk.Align.START) anchor |= TOP
    if (valign === Gtk.Align.END) anchor |= BOTTOM
    if (halign === Gtk.Align.START) anchor |= LEFT
    if (halign === Gtk.Align.END) anchor |= RIGHT

    if (anchor === 0) {
        anchor = TOP | BOTTOM | LEFT | RIGHT
    }

    return (
        <window
            application={app}
            visible={visible}
            name={name}
            namespace={`ags:${name}`}
            keymode={Astal.Keymode.ON_DEMAND}
            layer={Astal.Layer.OVERLAY}
            anchor={anchor}
            onNotifyVisible={({ visible }) => {
                if (visible) {
                    content.grab_focus()
                }
            }}
            $={(self) => {
                Object.assign(self, { show, hide })
            }}
            {...props}
        >
            <Gtk.EventControllerKey
                onKeyPressed={(self, keyval: number) => {
                    if (keyval === Gdk.KEY_Escape) {
                        toggleAppWindow(name.toString())
                    }
                    onKeyPressed?.(self, keyval)
                }}
            />
            <Gtk.GestureClick
                onPressed={({ widget }, _, x, y) => {
                    const [, rect] = content.compute_bounds(widget)
                    const position = new Graphene.Point({ x, y })
                    if (!rect.contains_point(position)) {
                        toggleAppWindow(name.toString())
                    }
                }}
            />
            <Adw.Clamp
                focusable
                valign={valign}
                halign={halign}
                marginTop={marginTop}
                marginBottom={marginBottom}
                marginStart={marginStart}
                marginEnd={marginEnd}
                $={(self) => {
                    content = self
                }}
                maximumSize={width}
                heightRequest={height}
            >
                <box class="main" css={visible((v) => (v ? "" : "opacity: 0;"))}>
                    {children}
                </box>
            </Adw.Clamp>
        </window>
    )
}
