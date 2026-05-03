import { exec } from "ags/process"
import GObject, { getter, register } from "gnim/gobject"

export type PowerMenuAction = "Shutdown" | "Reboot" | "Logout" | "Sleep"

export const powerMenuActions: PowerMenuAction[] = [
    "Shutdown",
    "Reboot",
    "Logout",
    "Sleep",
]

@register({ GTypeName: "PowerMenu" })
export default class PowerMenuService extends GObject.Object {
    static instance: PowerMenuService

    static get_default() {
        if (!this.instance) {
            this.instance = new PowerMenuService()
        }
        return this.instance
    }

    constructor() {
        super()
    }

    #title = ""
    #cmd = ""

    @getter(String)
    get title() {
        return this.#title
    }

    @getter(String)
    get cmd() {
        return this.#cmd
    }

    exec() {
        exec(this.#cmd)
    }

    action(action: PowerMenuAction) {
        ;[this.#cmd, this.#title] = {
            Shutdown: ["shutdown now", "Shutdown"],
            Reboot: ["systemctl reboot", "Reboot"],
            Logout: ["pkill Hyprland", "Logout"],
            Sleep: ["bash -c 'loginctl lock-session && systemctl suspend'", "Sleep"],
        }[action]

        this.notify("cmd")
        this.notify("title")
    }
}
