import { Gtk } from "ags/gtk4"
import Pango from "gi://Pango?version=1.0"
import { Accessor } from "gnim"

type ItemProps = {
    title: string | Accessor<string>
    index?: Accessor<number>
    single?: boolean
    children?: any
} & JSX.IntrinsicElements["button"]

export default function Item({
    title,
    children,
    index,
    single = false,
    ...props
}: ItemProps) {
    return (
        <button
            $={(self) => {
                self.add_css_class("item")
                if (single) {
                    self.add_css_class("single")
                } else {
                    self.add_css_class("list")
                }
            }}
            {...props}
        >
            <box>
                <box class={"icon"}>{children}</box>
                <box valign={Gtk.Align.CENTER} orientation={Gtk.Orientation.VERTICAL}>
                    <label
                        class={"title"}
                        label={title}
                        ellipsize={Pango.EllipsizeMode.END}
                        hexpand={false}
                        xalign={0}
                    />
                </box>
                {index != undefined && (
                    <box halign={Gtk.Align.END} valign={Gtk.Align.CENTER} hexpand>
                        <label label={`Alt`} class={"hotkey"} />
                        <label label={index((i) => `${i + 1}`)} class={"hotkey"} />
                    </box>
                )}
            </box>
        </button>
    )
}
