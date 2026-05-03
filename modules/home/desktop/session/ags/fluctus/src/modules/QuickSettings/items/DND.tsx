import AstalNotifd from "gi://AstalNotifd?version=0.1"
import QsButton from "../QsButton"
import { createBinding } from "gnim"
import Icons from "@/src/lib/icons"

export default function DNDButton() {
    const notifications = AstalNotifd.get_default()

    const dnd = createBinding(notifications, "dontDisturb")

    return (
        <QsButton
            title={"Don't Disturb"}
            icon={dnd.as((dnd) => Icons.notifications[dnd ? "silent" : "noisy"])}
            onClicked={() => notifications.set_dont_disturb(!notifications.dontDisturb)}
            active={dnd}
        />
    )
}
