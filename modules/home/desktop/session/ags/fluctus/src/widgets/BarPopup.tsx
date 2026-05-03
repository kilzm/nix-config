import { Astal, Gdk, Gtk } from "ags/gtk4"
import Popup from "./Popup"

type BarPopupProps = JSX.IntrinsicElements["window"] & {
    children?: any
    align: Gtk.Align
    width?: number
    height?: number
    gdkmonitor?: Gdk.Monitor
    onKeyPressed?: (source: Gtk.EventControllerKey, keyval: number) => void
}

export function BarPopup({
    children,
    name,
    align,
    width,
    height,
    gdkmonitor,
    onKeyPressed,
    ...props
}: BarPopupProps) {
    return (
        <Popup
            name={name}
            valign={Gtk.Align.START}
            halign={align}
            width={width}
            height={height}
            onKeyPressed={onKeyPressed}
            {...props}
        >
            {children}
        </Popup>
    )
}
