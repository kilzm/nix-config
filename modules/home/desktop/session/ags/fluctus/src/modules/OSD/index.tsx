import Icons from "@/src/lib/icons"
import Brightness from "@/src/services/brightness"
import { windowNames } from "@/windows"
import { Astal, Gdk, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import { timeout } from "ags/time"
import AstalWp from "gi://AstalWp?version=0.1"
import { Accessor, createState, onCleanup, Setter } from "gnim"

function OnScreenProgress({ setVisible }: { setVisible: Setter<boolean> }) {
    const wp = AstalWp.get_default()
    const speaker = wp.get_default_speaker()
    const brightness = Brightness.get_default()

    const [iconName, setIconName] = createState("")
    const [value, setValue] = createState(0)

    let count = 0
    function show(v: number, icon: string) {
        setVisible(true)
        setValue(v)
        setIconName(icon)
        count += 1
        timeout(1500, () => {
            count -= 1
            if (count === 0) {
                setVisible(false)
            }
        })
    }

    const conns = [
        speaker.connect("notify::volume", () => {
            show(
                speaker.volume,
                speaker.mute ? Icons.audio.volume.muted : speaker.volumeIcon,
            )
        }),
        speaker.connect("notify::mute", () => {
            show(
                speaker.volume,
                speaker.mute ? Icons.audio.volume.muted : speaker.volumeIcon,
            )
        }),
        brightness.connect("notify::screen", () => {
            show(brightness.screen, Icons.ui.brightness)
        }),
    ]
    onCleanup(() => {
        conns.map((id) => speaker.disconnect(id))
    })

    return (
        <box class={"main"}>
            <image iconName={iconName} />
            <levelbar valign={Gtk.Align.CENTER} value={value} />
            <label label={value((v) => `${Math.floor(v * 100)}%`)} />
        </box>
    )
}

export default function OSD(monitor: Gdk.Monitor) {
    const [visible, setVisible] = createState(false)

    const { BOTTOM } = Astal.WindowAnchor

    return (
        <window
            visible={visible}
            name={windowNames.osd}
            namespace={"ags:osd"}
            gdkmonitor={monitor}
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.NONE}
            anchor={BOTTOM}
            application={app}
        >
            <OnScreenProgress setVisible={setVisible} />
        </window>
    )
}
