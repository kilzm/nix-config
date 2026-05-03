import { Astal, Gtk } from "ags/gtk4"
import AstalNotifd from "gi://AstalNotifd?version=0.1"
import { createBinding, createComputed, createState, For, onCleanup } from "gnim"
import Notification from "./Notification"
import GLib from "gi://GLib?version=2.0"
import app from "ags/gtk4/app"

function NotificationItem({
    notification,
    onRemove,
}: {
    notification: AstalNotifd.Notification
    onRemove: (id: number) => void
}) {
    let hideTimeout: GLib.Source | null = null

    const clearHideTimeout = () => {
        if (hideTimeout !== null) {
            hideTimeout.destroy()
            hideTimeout = null
        }
    }

    const scheduleHide = () => {
        clearHideTimeout()
        hideTimeout = setTimeout(() => {
            onRemove(notification.id)
            hideTimeout = null
        }, 4000)
    }

    return (
        <Notification
            notification={notification}
            setup={(self) => {
                scheduleHide()
                const motion = new Gtk.EventControllerMotion()
                const onEnter = motion.connect("enter", () => {
                    clearHideTimeout()
                })
                const onLeave = motion.connect("leave", () => {
                    scheduleHide()
                })
                self.add_controller(motion)

                onCleanup(() => {
                    clearHideTimeout()
                    motion.disconnect(onEnter)
                    motion.disconnect(onLeave)
                    self.remove_controller(motion)
                })
            }}
        />
    )
}

export default function NotificationPopups() {
    const notifd = AstalNotifd.get_default()
    const [notifications, setNotifications] = createState(
        new Array<AstalNotifd.Notification>(),
    )

    const removeNotification = (id: number) => {
        setNotifications((ns) => ns.filter((it) => it.id !== id))
    }

    const notifiedHandler = notifd.connect("notified", (_, id, replaced) => {
        const notification = notifd.get_notification(id)
        if (replaced && notifications.peek().some((n) => n.id === id)) {
            setNotifications((ns) => ns.map((n) => (n.id === id ? notification : n)))
        } else {
            setNotifications((ns) => [notification, ...ns])
        }
    })

    const resolveHandler = notifd.connect("resolved", (_, id) => {
        removeNotification(id)
    })

    onCleanup(() => {
        notifd.disconnect(notifiedHandler)
        notifd.disconnect(resolveHandler)
    })

    const dnd = createBinding(notifd, "dontDisturb")
    const visible = createComputed(() => notifications().length !== 0 && !dnd())

    return (
        <window
            application={app}
            name={"notification-popups"}
            namespace={"ags:notification-popups"}
            visible={visible}
            layer={Astal.Layer.TOP}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            keymode={Astal.Keymode.NONE}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
        >
            <box orientation={Gtk.Orientation.VERTICAL}>
                <For each={notifications}>
                    {(notification) => (
                        <NotificationItem
                            notification={notification}
                            onRemove={removeNotification}
                        />
                    )}
                </For>
            </box>
        </window>
    )
}
