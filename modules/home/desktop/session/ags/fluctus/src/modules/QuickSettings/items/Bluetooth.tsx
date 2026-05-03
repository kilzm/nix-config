import AstalBluetooth from "gi://AstalBluetooth?version=0.1"
import QsButton from "../QsButton"
import { createBinding } from "gnim"
import Icons from "@/src/lib/icons"

export default function BluetoothButton() {
    const bluetooth = AstalBluetooth.get_default()

    const powered = createBinding(bluetooth, "isPowered")
    const connected = createBinding(bluetooth, "isConnected")

    const subtitle = connected.as((c) => {
        if (!c) {
            return "n/a"
        }
        const devices = bluetooth.get_devices()
        const connectedDevices = devices.filter((d) => d.connected)
        return connectedDevices.at(0)?.alias || "n/a"
    })

    return (
        <QsButton
            showArrow={false}
            icon={powered.as((p) => Icons.bluetooth[p ? "enabled" : "disabled"])}
            title={"Bluetooth"}
            subtitle={subtitle}
            tooltipText={"Toggle Bluetooth"}
            onClicked={() => bluetooth.toggle()}
            onArrowClicked={() => {}}
            active={powered}
        />
    )
}
