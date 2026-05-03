import Icons from "@/src/lib/icons"
import { toggleAppWindow } from "@/src/lib/utils"
import { windowNames } from "@/windows"
import AstalBluetooth from "gi://AstalBluetooth?version=0.1"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import AstalNotifd from "gi://AstalNotifd?version=0.1"
import AstalWp from "gi://AstalWp?version=0.1"
import { createBinding, createComputed } from "gnim"

function NetworkIndicator() {
    const network = AstalNetwork.get_default()

    const primary = createBinding(network, "primary")
    const wifiIcon = createBinding(network.wifi, "iconName")
    const wiredIcon = createBinding(network.wired, "iconName")

    const icon = createComputed(() =>
        primary() === AstalNetwork.Primary.WIFI ? wifiIcon() : wiredIcon(),
    )

    return (
        <image
            tooltipText={createBinding(network.wifi, "ssid").as(String)}
            iconName={icon}
        />
    )
}

function BluetoothIndicator() {
    const bluetooth = AstalBluetooth.get_default()
    const isPowered = createBinding(bluetooth, "isPowered")
    return (
        <image
            visible={isPowered}
            iconName={isPowered((p) => Icons.bluetooth[p ? "enabled" : "disabled"])}
        />
    )
}

function MicrophoneIndicator() {
    const wp = AstalWp.get_default()
    const mic = wp.get_default_microphone()
    return (
        <image
            iconName={createBinding(mic, "mute").as(
                (m) => Icons.audio.mic[m ? "muted" : "high"],
            )}
        />
    )
}

function DNDIndicator() {
    const notifications = AstalNotifd.get_default()
    return (
        <image
            visible={createBinding(notifications, "dontDisturb")}
            iconName={createBinding(notifications, "dontDisturb").as(
                (d) => Icons.notifications[d ? "silent" : "noisy"],
            )}
        />
    )
}

export default function Indicators() {
    return (
        <button
            class={"indicators"}
            onClicked={() => toggleAppWindow(windowNames.quicksettings)}
        >
            <box>
                <NetworkIndicator />
                <BluetoothIndicator />
                <DNDIndicator />
                <MicrophoneIndicator />
            </box>
        </button>
    )
}
