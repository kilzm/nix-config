import Icons from "@/src/lib/icons"
import { toggleAppWindow } from "@/src/lib/utils"
import { windowNames } from "@/windows"

export default function PowerMenu() {
    return (
        <button
            class={"powermenu"}
            onClicked={() => {
                toggleAppWindow(windowNames.powermenu)
            }}
        >
            <image iconName={Icons.powermenu.shutdown} />
        </button>
    )
}
