import Popup from "@/src/widgets/Popup"
import { Gdk, Gtk } from "ags/gtk4"
import { windowNames } from "@/windows"
import Content from "./Content"

export default function QuickSettings(monitor: Gdk.Monitor) {
    return (
        <Popup
            name={windowNames.quicksettings}
            namespace={"ags:quicksettings"}
            gdkmonitor={monitor}
            halign={Gtk.Align.END}
            valign={Gtk.Align.START}
        >
            <box
                class={"quicksettings"}
                orientation={Gtk.Orientation.VERTICAL}
                valign={Gtk.Align.START}
            >
                <box
                    class={"container"}
                    valign={Gtk.Align.START}
                    halign={Gtk.Align.CENTER}
                >
                    <Content />
                </box>
            </box>
        </Popup>
    )
}
