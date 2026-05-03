import { Gdk, Gtk } from "ags/gtk4"
import Icons from "../../lib/icons"
import Mpris from "gi://AstalMpris?version=0.1"
import Pango from "gi://Pango?version=1.0"
import { createBinding, createState } from "gnim"

export default function Media() {
    const spotify = Mpris.Player.new("spotify")

    const [revealed, setRevealed] = createState(false)
    const [toggled, setToggled] = createState(false)

    const Content = () => (
        <box>
            <revealer
                revealChild={revealed}
                focusable={false}
                transitionType={Gtk.RevealerTransitionType.SWING_LEFT}
                transitionDuration={150}
            >
                <label
                    label={createBinding(spotify, "metadata").as(
                        () => `${spotify.artist} - ${spotify.title}`,
                    )}
                    maxWidthChars={40}
                    ellipsize={Pango.EllipsizeMode.END}
                    valign={Gtk.Align.CENTER}
                />
            </revealer>
            <image iconName={Icons.media.spotify} />
        </box>
    )

    return (
        <revealer
            revealChild={createBinding(spotify, "available")}
            transitionType={Gtk.RevealerTransitionType.SWING_LEFT}
        >
            <box>
                <button
                    class={"media"}
                    canFocus={false}
                    onClicked={() => spotify.play_pause()}
                    tooltipText={
                        "Left Click: Play/Pause\nScroll: Previous/Next\nRight Click: Toggle Info"
                    }
                >
                    <Gtk.GestureClick
                        button={Gdk.BUTTON_SECONDARY}
                        onPressed={() => setToggled(!toggled())}
                    />
                    <Gtk.EventControllerMotion
                        onEnter={() => setRevealed(true)}
                        onLeave={() => setRevealed(toggled())}
                    />
                    <Gtk.EventControllerScroll
                        flags={Gtk.EventControllerScrollFlags.BOTH_AXES}
                        onScroll={(_self, dx, dy) => {
                            if (dy > 0.125 || dx < -0.125) spotify.next()
                            else if (dy < -0.125 || dx > 0.125) spotify.previous()
                        }}
                    />
                    <Content />
                </button>
                <Gtk.Separator />
            </box>
        </revealer>
    )
}
