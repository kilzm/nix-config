import Icons from "@/src/lib/icons"
import { Gtk } from "ags/gtk4"
import NetworkButton from "./items/Network"
import BluetoothButton from "./items/Bluetooth"
import { createPoll } from "ags/time"
import PowerMenuService, { PowerMenuAction } from "@/src/services/powermenu"
import { toggleAppWindow } from "@/src/lib/utils"
import { windowNames } from "@/windows"
import { readFile } from "ags/file"
import MicrophoneButton from "./items/Microphone"
import DNDButton from "./items/DND"
import { BrightnessSlider, VolumeSlider } from "./items/Sliders"
import MediaWidget from "../MediaWidget"

export default function Content() {
    const Header = () => {
        const uptime = createPoll("n/a", 1000, () => {
            const totalSeconds = parseInt(readFile("/proc/uptime").split(".").at(0)!)
            const hours = Math.floor(totalSeconds / 3600)
            const minutes = Math.floor((totalSeconds % 3600) / 60)
            const seconds = Math.floor(totalSeconds % 60)

            return `${String(hours).padStart(2, "0")}:${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`
        })

        const powermenu = PowerMenuService.get_default()

        const PowerButton = ({
            action,
            iconName,
        }: {
            action: PowerMenuAction
            iconName: string
        }) => (
            <button
                iconName={iconName}
                halign={Gtk.Align.END}
                onClicked={() => {
                    powermenu.action(action)
                    toggleAppWindow(windowNames.verification)
                }}
            />
        )

        return (
            <box class={"header"}>
                <box class={"uptime"}>
                    <image iconName={Icons.ui.hourglass} />
                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        hexpand
                        halign={Gtk.Align.START}
                    >
                        <label label={"Uptime"} class={"title"} xalign={0} />
                        <label label={uptime} class={"amount"} xalign={0} />
                    </box>
                </box>
                <box halign={Gtk.Align.END} hexpand>
                    <PowerButton action={"Logout"} iconName={Icons.powermenu.logout} />
                    <PowerButton action={"Reboot"} iconName={Icons.powermenu.reboot} />
                    <PowerButton
                        action={"Shutdown"}
                        iconName={Icons.powermenu.shutdown}
                    />
                </box>
            </box>
        )
    }

    const Body = () => (
        <box orientation={Gtk.Orientation.VERTICAL} class={"body"}>
            <box homogeneous class={"row"}>
                <NetworkButton />
                <BluetoothButton />
            </box>
            <box homogeneous class={"row"}>
                <MicrophoneButton />
                <DNDButton />
            </box>
            <box class={"qs-sliders"} orientation={Gtk.Orientation.VERTICAL}>
                <VolumeSlider />
                <BrightnessSlider />
            </box>
            <MediaWidget />
        </box>
    )

    return (
        <box
            $type={"named"}
            name={"main"}
            cssClasses={["page", "main-page"]}
            orientation={Gtk.Orientation.VERTICAL}
        >
            <Header />
            <Body />
        </box>
    )
}
