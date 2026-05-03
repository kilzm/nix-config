import { fileExists, isIcon } from "@/src/lib/utils"
import { Gdk, Gtk } from "ags/gtk4"
import Adw from "gi://Adw?version=1"
import AstalNotifd from "gi://AstalNotifd?version=0.1"
import Gio from "gi://Gio?version=2.0"
import GLib from "gi://GLib?version=2.0"
import Pango from "gi://Pango?version=1.0"
import { CCProps, createState } from "gnim"

const makeTimestamp = (time: number, format = "%H:%M") =>
    GLib.DateTime.new_from_unix_local(time).format(format)!

type NotificationProps = {
    notification: AstalNotifd.Notification
    setup: (self: Gtk.Box) => void
} & Partial<CCProps<Adw.Clamp, Adw.Clamp.ConstructorProps>>

export default function Notification({
    notification: n,
    setup,
    ...props
}: NotificationProps) {
    const Header = () => (
        <box class={"header"}>
            {(n.appIcon || isIcon(n.desktopEntry)) && (
                <image
                    class={"app-icon"}
                    visible={Boolean(n.appIcon || n.desktopEntry)}
                    iconName={n.appIcon || n.desktopEntry}
                />
            )}
            <label
                class={"app-name"}
                halign={Gtk.Align.START}
                ellipsize={Pango.EllipsizeMode.END}
                label={n.appName || "Unknown"}
            />
            <label
                class={"timestamp"}
                hexpand
                halign={Gtk.Align.END}
                label={makeTimestamp(n.time)}
            />
        </box>
    )

    const Content = () => (
        <box class={"content"}>
            {n.image && fileExists(n.image) && (
                <Adw.Clamp
                    valign={Gtk.Align.START}
                    maximumSize={90}
                    widthRequest={90}
                    heightRequest={90}
                >
                    <Adw.Clamp orientation={Gtk.Orientation.VERTICAL} maximumSize={90}>
                        <Gtk.Picture
                            class={"image"}
                            file={Gio.file_new_for_path(n.image)}
                            contentFit={Gtk.ContentFit.COVER}
                        />
                    </Adw.Clamp>
                </Adw.Clamp>
            )}
            {n.image && isIcon(n.image) && (
                <box valign={Gtk.Align.START} class={"icon-image"}>
                    <image
                        iconName={n.image}
                        halign={Gtk.Align.CENTER}
                        valign={Gtk.Align.CENTER}
                    />
                </box>
            )}
            <box orientation={Gtk.Orientation.VERTICAL}>
                <label
                    class={"summary"}
                    halign={Gtk.Align.START}
                    xalign={0}
                    label={n.summary}
                    ellipsize={Pango.EllipsizeMode.END}
                />
                {n.body && (
                    <label
                        class={"body"}
                        wrap
                        useMarkup
                        halign={Gtk.Align.START}
                        xalign={0}
                        justify={Gtk.Justification.FILL}
                        label={n.body}
                    />
                )}
            </box>
        </box>
    )

    const Actions = () => (
        <box class={"actions"}>
            {n.actions.map(({ label, id }) => (
                <button hexpand onClicked={() => n.invoke(id)}>
                    <label label={label} halign={Gtk.Align.CENTER} hexpand />
                </button>
            ))}
        </box>
    )

    const entered = createState(false)
    let motion: Gtk.EventControllerMotion

    return (
        <Adw.Clamp maximumSize={450} {...props}>
            <box
                $={setup}
                widthRequest={450}
                class={"notification"}
                orientation={Gtk.Orientation.VERTICAL}
            >
                <Gtk.EventControllerMotion $={(self) => (motion = self)} />
                <Gtk.GestureClick
                    button={Gdk.BUTTON_PRIMARY}
                    onReleased={() => {
                        if (motion.containsPointer) {
                            n.dismiss()
                        }
                    }}
                />
                <Header />
                <Gtk.Separator />
                <Content />
                {n.actions.length > 0 && <Actions />}
            </box>
        </Adw.Clamp>
    )
}
