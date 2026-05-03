import Icons from "@/src/lib/icons"
import { Gtk } from "ags/gtk4"
import Pango from "gi://Pango?version=1.0"
import { Accessor, onCleanup, With } from "gnim"

type QsButtonProps = {
    icon: string | Accessor<string>
    title: string
    active: Accessor<boolean>
    subtitle?: Accessor<string>
    tooltipText?: string | Accessor<string>
    showArrow?: boolean
    onClicked: () => void
    onArrowClicked?: () => void
}

export default function QsButton({
    icon,
    title,
    subtitle,
    tooltipText,
    active,
    showArrow,
    onClicked,
    onArrowClicked = () => {},
}: QsButtonProps) {
    return (
        <box
            class={"qs-button"}
            $={(self) => {
                const update = () => {
                    if (active.peek()) {
                        self.add_css_class("active")
                    } else {
                        self.remove_css_class("active")
                    }
                }
                const unsub = active.subscribe(update)
                update()
                onCleanup(unsub)
            }}
        >
            <button
                $={(self) => {
                    self.add_css_class("main")
                    if (showArrow) {
                        self.add_css_class("with-arrow")
                    }
                }}
                onClicked={onClicked}
                tooltipText={tooltipText}
                hexpand
                focusOnClick={false}
            >
                <box halign={Gtk.Align.START} valign={Gtk.Align.CENTER}>
                    <image iconName={icon} />
                    <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
                        <label
                            class={"qs-label"}
                            label={title}
                            maxWidthChars={subtitle ? 12 : 14}
                            ellipsize={Pango.EllipsizeMode.END}
                            halign={Gtk.Align.START}
                            valign={Gtk.Align.CENTER}
                        />
                        {subtitle && (
                            <label
                                class={"qs-subtitle"}
                                label={subtitle}
                                ellipsize={Pango.EllipsizeMode.END}
                                maxWidthChars={18}
                                halign={Gtk.Align.START}
                                valign={Gtk.Align.CENTER}
                                visible={subtitle((s) => s !== "n/a")}
                            />
                        )}
                    </box>
                </box>
            </button>
            {showArrow && (
                <button
                    $={(self) => self.add_css_class("arrow")}
                    canFocus={false}
                    onClicked={onArrowClicked}
                    iconName={Icons.ui.right}
                />
            )}
        </box>
    )
}
