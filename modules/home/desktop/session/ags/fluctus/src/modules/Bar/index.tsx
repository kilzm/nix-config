import app from "ags/gtk4/app"
import Gtk from "gi://Gtk"
import Clock from "./Clock"
import Workspaces from "./Workspaces"
import Launcher from "./Launcher"
import SysTray from "./SysTray"
import Indicators from "./Indicators"
import PowerMenu from "./PowerMenu"
import { windowNames } from "@/windows"
import Media from "./Media"
import { Astal, Gdk } from "ags/gtk4"
import Battery from "./Battery"

export default function Bar(monitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return (
        <window
            visible
            name={windowNames.bar}
            class={"bar"}
            namespace={"ags:bar"}
            gdkmonitor={monitor}
            layer={Astal.Layer.OVERLAY}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={app}
        >
            <centerbox class={"main"}>
                <box $type={"start"}>
                    <Launcher />
                    <Gtk.Separator />
                    <Workspaces />
                </box>
                <box $type={"center"}>
                    <Clock />
                </box>
                <box $type={"end"}>
                    <Media />
                    <SysTray />
                    <Battery />
                    <Indicators />
                    <Gtk.Separator />
                    <PowerMenu />
                </box>
            </centerbox>
        </window>
    )
}
