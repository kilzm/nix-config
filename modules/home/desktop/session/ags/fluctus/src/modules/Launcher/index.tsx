import app from "ags/gtk4/app"
import { createState } from "gnim"
import Icons from "@/src/lib/icons"
import { Gdk, Gtk } from "ags/gtk4"
import { toggleAppWindow } from "@/src/lib/utils"
import { windowNames } from "@/windows"
import { BarPopup } from "@/src/widgets/BarPopup"
import AppCategory from "./categories/AppCategory"
import HelpCategory from "./categories/HelpCategory"
import CalculatorCategory from "./categories/CalculatorCategory"
import WebsearchCategory from "./categories/WebsearchCategory"
import ShellCategory from "./categories/ShellCategory"
import ColorCategory from "./categories/ColorCategory"

export default function Launcher() {
    const [query, setQuery] = createState("")

    const help = HelpCategory()
    const apps = AppCategory(query)
    const calculator = CalculatorCategory(query)
    const websearch = WebsearchCategory(query)
    const shell = ShellCategory(query)
    const colors = ColorCategory(query)

    const qstate = query((q) => {
        if (q === "") {
            return { child: help, icon: Icons.ui.info }
        }
        switch (q[0]) {
            case ">":
                return { child: shell, icon: Icons.ui.terminal }
            case "=":
                return { child: calculator, icon: Icons.ui.calculator }
            case ".":
                return { child: websearch, icon: Icons.ui.websearch }
            case "#":
                return { child: colors, icon: Icons.ui.websearch }
            default:
                if (/^[a-zA-Z0-9]$/.test(q[0])) {
                    return { child: apps, icon: Icons.ui.apps }
                }
                return { child: help, icon: Icons.ui.info }
        }
    })

    const stack = (
        <stack
            class={"content"}
            visibleChild={qstate.as((a) => a.child)}
            transitionDuration={100}
            transitionType={Gtk.StackTransitionType.NONE}
            vhomogeneous={false}
        >
            {apps}
            {help}
            {calculator}
            {websearch}
            {shell}
            {colors}
        </stack>
    )

    const entry = (
        <entry
            cssClasses={["entry"]}
            placeholderText={"Type something..."}
            primaryIconName={Icons.ui.search}
            onNotifyText={(self) => {
                setQuery(self.text)
            }}
            onActivate={() => {
                qstate().child.action()
                toggleAppWindow(windowNames.launcher)
            }}
        />
    ) as Gtk.Entry

    return (
        <BarPopup
            name={windowNames.launcher}
            namespace={"ags:launcher"}
            application={app}
            marginTop={450}
            align={Gtk.Align.CENTER}
            $={(self) => {
                self.connect("notify::visible", () => {
                    entry.set_text("")
                    entry.grab_focus()
                })
            }}
            onKeyPressed={(source, keyval) => {
                const state = source.get_current_event_state()
                if (state && Gdk.KEY_Alt_L) {
                    const hk = qstate().child.hotkey
                    if (hk) {
                        hk(keyval)
                        toggleAppWindow(windowNames.launcher)
                    }
                }
            }}
        >
            <box orientation={Gtk.Orientation.VERTICAL} hexpand>
                <box orientation={Gtk.Orientation.VERTICAL}>
                    {entry}
                    <Gtk.Separator orientation={Gtk.Orientation.HORIZONTAL} />
                    {stack}
                </box>
            </box>
        </BarPopup>
    )
}
