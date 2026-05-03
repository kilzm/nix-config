import Category from "./Category"
import Item from "../Item"
import Icons from "@/src/lib/icons"
import { execAsync } from "ags/process"
import { Accessor } from "gnim"
import GLib from "gi://GLib?version=2.0"

export default function ShellCategory(query: Accessor<string>) {
    const trimmed = query.as((q) => (q.startsWith(">") ? q.slice(1).trim() : ""))
    function execute() {
        const term = GLib.getenv("TERMINAL")
        if (!term) {
            console.warn("$TERMINAL is not set")
            return
        }
        const shell = GLib.getenv("SHELL")
        if (!shell) {
            console.warn("$SHELL is not set")
            return
        }
        execAsync(
            `${term} -e ${shell} -i -c 'cd $HOME && clear; ${trimmed()}; exec ${shell}'`,
        )
    }

    const item = (
        <Item single class={"shell"} title={trimmed} onClicked={execute} canFocus={false}>
            <image iconName={Icons.ui.terminal} />
        </Item>
    )

    return (
        <Category name={"Shell"} action={execute}>
            {item}
        </Category>
    ) as Category
}
