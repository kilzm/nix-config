import AstalNetwork from "gi://AstalNetwork?version=0.1"
import { createBinding, createComputed } from "gnim"
import QsButton from "../QsButton"
import { Gtk } from "ags/gtk4"

export default function NetworkButton() {
    const network = AstalNetwork.get_default()
    const { wifi, wired } = network

    const connectivity = createBinding(network, "connectivity")
    const primary = createBinding(network, "primary")
    const wiredIcon = createBinding(wired, "iconName")
    const wifiIcon = createBinding(wifi, "iconName")

    const subtitle = createComputed(() => {
        connectivity()
        if (primary() === AstalNetwork.Primary.WIRED) {
            if (wired.internet === AstalNetwork.Internet.CONNECTED) {
                return "Wired"
            }
        }
        if (primary() === AstalNetwork.Primary.WIFI) {
            return wifi.ssid
        }
        return "n/a"
    })

    const icon = createComputed(() => {
        connectivity()
        if (primary() === AstalNetwork.Primary.WIRED) {
            if (wired.internet === AstalNetwork.Internet.CONNECTED) {
                return wiredIcon()
            }
        }
        return wifiIcon()
    })

    return (
        <QsButton
            showArrow={false}
            icon={icon}
            title={"Network"}
            subtitle={subtitle}
            tooltipText={"Toggle Wi-Fi"}
            onClicked={() => {
                wifi.set_enabled(!wifi.get_enabled())
            }}
            onArrowClicked={() => {}}
            active={createBinding(wifi, "enabled")}
        />
    )
}

export function NetworkList() {
    const network = AstalNetwork.get_default()

    const networks = createComputed(
        [createBinding(network, "vfunc_dispatch_properties_changed")],
        (devices) => {
            return devices
        },
    )

    return <box orientation={Gtk.Orientation.VERTICAL}></box>
}
