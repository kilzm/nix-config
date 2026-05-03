import Icons from "@/src/lib/icons"
import { toggleAppWindow } from "@/src/lib/utils"
import { windowNames } from "@/windows"

export default function Launcher() {
    return (
        <button
            class={"launcher"}
            onClicked={() => {
                toggleAppWindow(windowNames.launcher)
            }}
        >
            <box>
                <image class={"nix-icon"} iconName={Icons.nix.flake} />
                <label label={"Applications"} />
            </box>
        </button>
    )
}
