import { Gtk } from "ags/gtk4"
import Category from "./Category"
import Item from "../Item"

function HelpItem({ symbol, description }: { symbol: string; description: string }) {
    return (
        <Item title={description} class={"help"} canFocus={false}>
            <label label={symbol} class={"hotkey"} />
        </Item>
    )
}

export default function HelpCategory() {
    const help = (
        <box orientation={Gtk.Orientation.VERTICAL}>
            <box orientation={Gtk.Orientation.VERTICAL} class={"help"}>
                <HelpItem symbol={"."} description={"Search with DuckDuckGo"} />
                <HelpItem symbol={"="} description={"Evaluate math expressions"} />
                <HelpItem symbol={">"} description={"Run a shell command"} />
                <HelpItem symbol={"#"} description={"Convert between colors formats"} />
            </box>
        </box>
    )

    return (
        <Category name={"Help"} action={() => {}}>
            {help}
        </Category>
    ) as Category
}
