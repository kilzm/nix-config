import { Gtk } from "ags/gtk4"
import AstalBattery from "gi://AstalBattery?version=0.1"
import { createBinding, createState } from "gnim"

export default function Battery() {
    const battery = AstalBattery.get_default()
    const [revealed, setRevealed] = createState(true)

    return (
        <button
            visible={createBinding(battery, "isPresent")}
            class={"battery"}
            onClicked={() => {
                setRevealed(!revealed())
            }}
        >
            <box>
                <image iconName={createBinding(battery, "batteryIconName")} />
                <revealer
                    revealChild={revealed}
                    focusable={false}
                    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
                >
                    <label
                        label={createBinding(battery, "percentage").as(
                            (p) => `${Math.floor(p * 100)}%`,
                        )}
                    />
                </revealer>
            </box>
        </button>
    )
}
