import Category from "./Category"
import Item from "../Item"
import { Accessor } from "gnim"
import { execAsync } from "ags/process"
import Icons from "@/src/lib/icons"

export default function WebsearchCategory(query: Accessor<string>) {
    const trimmed = query.as((q) => (q.startsWith(".") ? q.slice(1).trim() : ""))
    function search() {
        execAsync([
            "xdg-open",
            `https://duckduckgo.com/?q=${encodeURIComponent(trimmed())}`,
        ])
    }

    const item = (
        <Item
            class={"websearch"}
            single
            title={trimmed}
            onClicked={search}
            canFocus={false}
        >
            <image iconName={Icons.ui.websearch} />
        </Item>
    )

    return (
        <Category name={"DuckDuckGo"} action={search}>
            {item}
        </Category>
    ) as Category
}
