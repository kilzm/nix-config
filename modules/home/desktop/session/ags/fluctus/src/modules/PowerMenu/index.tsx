import Icons from "@/src/lib/icons"
import { toggleAppWindow } from "@/src/lib/utils"
import PowerMenuService, {
    PowerMenuAction,
    powerMenuActions,
} from "@/src/services/powermenu"
import Popup from "@/src/widgets/Popup"
import { windowNames } from "@/windows"
import { Gdk, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"

type PowerMenuButtonProps = {
    action: PowerMenuAction
    iconName: string
}

export default function PowerMenu() {
    const power = PowerMenuService.get_default()

    function PowerMenuButton({ action, iconName }: PowerMenuButtonProps) {
        return (
            <button
                cssClasses={["powermenu-button"]}
                onClicked={() => {
                    power.action(action)
                    toggleAppWindow(windowNames.powermenu)
                    toggleAppWindow(windowNames.verification)
                }}
            >
                <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
                    <image iconName={iconName} />
                    <label class={"title"} label={action} />
                </box>
            </button>
        )
    }

    return (
        <Popup
            application={app}
            name={windowNames.powermenu}
            namespace={"ags:powermenu"}
            onKeyPressed={(_, kv) => {
                const i = kv - Gdk.KEY_1
                if (0 <= i && i < 4) {
                    power.action(powerMenuActions[i])
                    toggleAppWindow(windowNames.verification)
                }
            }}
        >
            <box class={"powermenu"}>
                <PowerMenuButton
                    action={"Shutdown"}
                    iconName={Icons.powermenu.shutdown}
                />
                <PowerMenuButton action={"Reboot"} iconName={Icons.powermenu.reboot} />
                <PowerMenuButton action={"Logout"} iconName={Icons.powermenu.logout} />
                <PowerMenuButton action={"Sleep"} iconName={Icons.powermenu.sleep} />
            </box>
        </Popup>
    )
}
