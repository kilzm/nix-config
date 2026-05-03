import QsButton from "../QsButton"
import { createBinding } from "gnim"
import Icons from "@/src/lib/icons"
import AstalWp from "gi://AstalWp?version=0.1"

export default function MicrophoneButton() {
    const wp = AstalWp.get_default()
    const mic = wp.get_default_microphone()

    const muted = createBinding(mic, "mute")

    return (
        <QsButton
            title={"Microphone"}
            icon={muted.as((m) => Icons.audio.mic[m ? "muted" : "high"])}
            onClicked={() => mic.set_mute(!mic.mute)}
            active={muted}
        />
    )
}
