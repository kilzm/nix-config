import Icons from "@/src/lib/icons"
import { lengthStr, mod } from "@/src/lib/utils"
import { Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import AstalMpris from "gi://AstalMpris?version=0.1"
import Pango from "gi://Pango?version=1.0"
import {
    Accessor,
    createBinding,
    createComputed,
    createEffect,
    createState,
    For,
    onCleanup,
} from "gnim"

function Player({ player }: { player: AstalMpris.Player }) {
    const Title = () => (
        <label
            label={createBinding(player, "title")}
            ellipsize={Pango.EllipsizeMode.END}
            maxWidthChars={25}
            xalign={0}
            class={"title"}
            halign={Gtk.Align.START}
        />
    )

    const Artist = () => (
        <label
            label={createBinding(player, "artist")}
            maxWidthChars={30}
            xalign={0}
            class={"artist"}
            halign={Gtk.Align.START}
        />
    )

    const Time = () => {
        const pos = createBinding(player, "position").as((p) => lengthStr(p))
        const len = createBinding(player, "length").as((l) => lengthStr(l))
        return (
            <label
                class={"time"}
                label={createComputed(() => `${pos()} / ${len()}`)}
                xalign={1}
            />
        )
    }

    const Controls = () => (
        <box halign={Gtk.Align.CENTER}>
            <button
                visible={createBinding(player, "canGoPrevious")}
                iconName={Icons.media.previous}
                onClicked={() => player.previous()}
            />
            <button
                iconName={createBinding(player, "playbackStatus").as(
                    (s) =>
                        Icons.media[
                            s == AstalMpris.PlaybackStatus.PLAYING ? "pause" : "play"
                        ],
                )}
                onClicked={() => player.play_pause()}
            />
            <button
                visible={createBinding(player, "canGoNext")}
                iconName={Icons.media.next}
                onClicked={() => player.next()}
            />
        </box>
    )

    const setCoverCss = () => {
        if (player.coverArt) {
            app.apply_css(`
                .media .player-${player.busName.replaceAll(".", "-")} {
                    background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url("file://${player.coverArt}");
                    background-size: cover;
                    background-position: center;
            }`)
        }
    }

    return (
        <box
            $type={"named"}
            name={player.busName}
            cssClasses={["player", `player-${player.busName.replaceAll(".", "-")}`]}
            orientation={Gtk.Orientation.VERTICAL}
            $={() => {
                setCoverCss()
                const conn = player.connect("notify::cover-art", setCoverCss)
                onCleanup(() => player.disconnect(conn))
            }}
        >
            <box vexpand valign={Gtk.Align.START}>
                {" "}
            </box>
            <box vexpand valign={Gtk.Align.CENTER}>
                <box orientation={Gtk.Orientation.HORIZONTAL} valign={Gtk.Align.CENTER}>
                    <box
                        class={"title-box"}
                        orientation={Gtk.Orientation.VERTICAL}
                        halign={Gtk.Align.START}
                        valign={Gtk.Align.CENTER}
                        vexpand
                    >
                        <Title />
                        <Artist />
                    </box>
                    <box hexpand />
                    <Time />
                </box>
            </box>
            <Controls />
        </box>
    ) as Gtk.Widget
}

function PlayerSwitcher({ mpris }: { mpris: AstalMpris.Mpris }) {
    const players = createBinding(mpris, "players")
    const [selectedPlayer, setSelectedPlayer] = createState<string>("")

    createEffect(() => {
        const playerList = players()
        if (playerList.length > 0 && !selectedPlayer()) {
            setSelectedPlayer(playerList[0].busName)
        }
        if (selectedPlayer() && !playerList.find((p) => p.busName === selectedPlayer())) {
            setSelectedPlayer(playerList[0]?.busName || "")
        }
    })

    function changePlayer(direction: number) {
        const allPlayers = players.peek()
        if (allPlayers.length === 0) return

        const index = allPlayers.findIndex((p) => p.busName === selectedPlayer())
        const newIndex = mod(index + direction, allPlayers.length)
        setSelectedPlayer(allPlayers[newIndex].busName)
    }

    return (
        <box class={"media"} visible={players.as((p) => p.length > 0)}>
            <Gtk.EventControllerScroll
                flags={Gtk.EventControllerScrollFlags.VERTICAL}
                onScroll={(_, _dx, dy) => {
                    if (dy > 0.125) {
                        changePlayer(1)
                    } else if (dy < -0.125) {
                        changePlayer(-1)
                    }
                }}
            />
            <stack
                transitionType={Gtk.StackTransitionType.SLIDE_UP_DOWN}
                transitionDuration={300}
                interpolateSize
                visibleChildName={selectedPlayer}
            >
                <For each={players}>{(player) => <Player player={player} />}</For>
            </stack>
        </box>
    )
}

export default function MediaWidget() {
    const mpris = AstalMpris.get_default()
    return <PlayerSwitcher mpris={mpris} />
}
