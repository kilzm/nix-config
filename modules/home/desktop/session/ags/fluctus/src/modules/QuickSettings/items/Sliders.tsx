import Icons from "@/src/lib/icons"
import Brightness from "@/src/services/brightness"
import AstalWp from "gi://AstalWp?version=0.1"
import { createBinding } from "gnim"
import { setQsPage } from ".."

export function VolumeSlider() {
    const wp = AstalWp.get_default()
    const speaker = wp.get_default_speaker()
    const volume = createBinding(speaker, "volume")

    return (
        <box>
            <image iconName={createBinding(speaker, "volumeIcon")} hexpand={false} />
            <slider
                drawValue={false}
                hexpand
                onChangeValue={(self) => {
                    speaker.set_volume(self.get_value())
                    speaker.set_mute(false)
                }}
                value={volume}
            />
        </box>
    )
}

export function BrightnessSlider() {
    const brightness = Brightness.get_default()
    const brightnessValue = createBinding(brightness, "screen")
    return (
        <box>
            <image iconName={Icons.ui.brightness} hexpand={false} />
            <slider
                drawValue={false}
                hexpand
                onChangeValue={(self) => {
                    brightness.screen = self.value
                }}
                value={brightnessValue}
            />
        </box>
    )
}
