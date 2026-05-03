import AstalApps from "gi://AstalApps?version=0.1"
import { Accessor, For } from "gnim"
import Category from "./Category"
import { Gdk } from "ags/gtk4"
import Item from "../Item"
import { toggleAppWindow } from "@/src/lib/utils"
import { windowNames } from "@/windows"

type AppItemProps = {
    app: AstalApps.Application
    index: Accessor<number>
}

function AppItem({ app, index }: AppItemProps) {
    const icon = app.iconName?.startsWith("/") ? (
        <image file={app.iconName} />
    ) : (
        <image iconName={app.iconName} />
    )

    return (
        <Item
            title={app.name}
            index={index}
            tooltipText={app.description}
            onClicked={() => {
                app.launch()
                toggleAppWindow(windowNames.launcher)
            }}
        >
            {icon}
        </Item>
    )
}

export default function AppCategory(query: Accessor<string>) {
    const apps = new AstalApps.Apps()
    const appList = query.as((q) =>
        q !== "" && /^[a-zA-Z0-9]+$/.test(q[0])
            ? apps
                  .fuzzy_query(q)
                  .sort((a, b) => apps.fuzzy_score(q, b) - apps.fuzzy_score(q, a))
                  .slice(0, 5)
            : [],
    )

    return (
        <Category
            name={"Applications"}
            action={() => appList().at(0)?.launch()}
            hotkey={(key) => {
                const index = key - Gdk.KEY_1
                if (0 <= index && index <= appList().length) appList()[index].launch()
            }}
        >
            <For each={appList}>{(app, i) => <AppItem app={app} index={i} />}</For>
        </Category>
    ) as Category
}
