import Icons from "@/src/lib/icons"
import AstalTray from "gi://AstalTray?version=0.1"
import Gtk from "gi://Gtk?version=4.0"
import { createBinding, createState, For, onCleanup } from "gnim"

export default function SysTray() {
    const tray = AstalTray.get_default()

    const [revealed, setRevealed] = createState(false)

    const items = createBinding(tray, "items").as((items) =>
        items.filter((item) => item.id !== null && !(item.title || "").match("spotify")),
    )

    const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
        btn.set_menu_model(item.menuModel)
        btn.insert_action_group("dbusmenu", item.actionGroup)
        const conn = item.connect("notify::action-group", () => {
            btn.insert_action_group("dbusmenu", item.actionGroup)
        })
        onCleanup(() => item.disconnect(conn))
    }

    return (
        <revealer
            revealChild={items((its) => its.length > 0)}
            transitionType={Gtk.RevealerTransitionType.SWING_LEFT}
        >
            <box class={"tray"}>
                <revealer
                    revealChild={revealed}
                    focusable={false}
                    transitionType={Gtk.RevealerTransitionType.SWING_LEFT}
                    transitionDuration={150}
                >
                    <box>
                        <For each={items}>
                            {(item) => (
                                <menubutton class={"icon"} $={(self) => init(self, item)}>
                                    <image gicon={createBinding(item, "gicon")} />
                                </menubutton>
                            )}
                        </For>
                    </box>
                </revealer>
                <button
                    iconName={revealed((r) => (!r ? Icons.ui.grid : Icons.ui.right))}
                    tooltipText={"Toggle System Tray"}
                    onClicked={() => {
                        setRevealed(!revealed())
                    }}
                ></button>
            </box>
        </revealer>
    )
}
