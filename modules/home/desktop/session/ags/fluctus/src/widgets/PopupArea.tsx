import app from "ags/gtk4/app"
import { activePopupWindow, toggleAppWindow } from "../lib/utils"
import { Astal, Gtk } from "ags/gtk4"

export default function PopupArea() {
    const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

    return (
        <window
            application={app}
            visible={activePopupWindow.as((a) => a !== undefined)}
            anchor={TOP | BOTTOM | LEFT | RIGHT}
            layer={Astal.Layer.TOP}
            keymode={Astal.Keymode.NONE}
            css={"background-color: rgba(0, 0, 0, 0.005);"}
        >
            <Gtk.GestureClick
                onPressed={() => {
                    const active = activePopupWindow()
                    if (active) {
                        toggleAppWindow(active)
                    }
                }}
            />
            <box />
        </window>
    )
}
