import { createPoll } from "ags/time"
import GLib from "gi://GLib"

export default function Clock() {
    const clock = createPoll(
        "",
        1000,
        () => GLib.DateTime.new_now_local().format("%a %d %b  %R")!,
    )

    return (
        <button>
            <label cssClasses={["time"]} label={clock} />
        </button>
    )
}
