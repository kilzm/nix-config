import { range } from "@/src/lib/utils"
import AstalHyprland from "gi://AstalHyprland?version=0.1"
import { createBinding, onCleanup } from "gnim"

export default function Workspaces() {
    const NUM_WORKSPACES = 8

    const hyprland = AstalHyprland.get_default()

    const focused = createBinding(hyprland, "focusedWorkspace")

    const indicators = range(NUM_WORKSPACES).map((i: number) => (
        <label
            $={(self) => {
                const update = () => {
                    if (focused.peek() && focused.peek().get_id() === i) {
                        self.set_css_classes(["focused"])
                    } else {
                        const ws = hyprland.get_workspace(i)
                        self.set_css_classes(
                            ws && ws.get_clients().length > 0 ? ["used"] : ["unused"],
                        )
                    }
                }
                const conn = hyprland.connect("event", update)
                onCleanup(() => hyprland.disconnect(conn))
            }}
        />
    ))

    return (
        <button class={"workspaces"}>
            <box>{indicators}</box>
        </button>
    )
}
