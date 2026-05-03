import { Gtk } from "ags/gtk4"
import { Accessor } from "gnim"

type CategoryProps = {
    name: string
    children: any
    action: () => void
    hotkey?: (key: number) => void
}

function Category({ name, children, action, hotkey }: CategoryProps) {
    const category = (
        <box orientation={Gtk.Orientation.VERTICAL} name={name}>
            <label label={name} halign={Gtk.Align.START} class={"category"} />
            {children}
        </box>
    )

    return Object.assign(category, { action: action, hotkey: hotkey })
}

type Category = {
    action: () => void
    hotkey?: (key: number) => void
} & Gtk.Widget

export default Category
