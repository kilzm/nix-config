import { Gtk } from "ags/gtk4"
import { timeout } from "ags/time"
import {
    Accessor,
    createComputed,
    createEffect,
    createState,
    For,
    onCleanup,
    With,
} from "gnim"

function mapToSortedEntries<K, V>(m: Map<K, V>, cmp?: (a: K, b: K) => number): [K, V][] {
    const entries = Array.from(m.entries())

    const defaultCmp = (a: K, b: K) => {
        if (typeof a === "number" && typeof b === "number") return a - b
        return String(a).localeCompare(String(b), undefined, {
            numeric: true,
            sensitivity: "base",
        })
    }

    entries.sort(([ka], [kb]) => (cmp ?? defaultCmp)(ka, kb))
    return entries
}

type AnimatedForProps<Item, El extends JSX.Element, Key> = {
    each: Accessor<Iterable<Item>>
    children: (item: Item, index: Accessor<number>) => El
    emptyState?: El
    reverse?: boolean
    id?: (item: Item) => Key
    transitionType?: Gtk.RevealerTransitionType
    transitionDuration?: number
    orientation?: Gtk.Orientation
}

export default function AnimatedFor<Item, El extends JSX.Element, Key>({
    each,
    children,
    emptyState,
    reverse = false,
    id = (item: any) => item as Key,
    transitionType = Gtk.RevealerTransitionType.SWING_DOWN,
    transitionDuration = 200,
    orientation = Gtk.Orientation.VERTICAL,
}: AnimatedForProps<Item, El, Key>) {
    const [rendered, setRendered] = createState<Map<Key, Item>>(new Map())
    const [exiting, setExiting] = createState<Map<Key, Item>>(new Map())

    const update = () => {
        const eachMap = new Map<Key, Item>()
        const newRendered = new Map<Key, Item>(rendered.peek())
        const newExiting = new Map<Key, Item>(exiting.peek())

        for (const item of each.peek()) {
            const k = id(item)
            eachMap.set(k, item)
            newRendered.set(k, item)
        }

        for (const [k, item] of newRendered) {
            if (!eachMap.has(k)) {
                newExiting.set(k, item)
            }
        }

        setRendered(newRendered)
        setExiting(newExiting)
    }

    const unsub = each.subscribe(() => {
        update()
    })
    update()

    onCleanup(unsub)

    const removeItem = (key: Key) => {
        const cur = new Map(rendered.peek())
        if (!cur.has(key)) return

        const exit = new Map(exiting.peek())

        exit.delete(key)
        cur.delete(key)

        setRendered(cur)
        setExiting(exit)
    }

    const innerList = createComputed(() => {
        const entries = mapToSortedEntries(rendered())
        if (reverse) {
            return entries.reverse()
        }
        return entries
    })

    return (
        <box orientation={orientation}>
            <For each={innerList} id={(pair) => pair[0]}>
                {(pair, idx) => {
                    const [key, item] = pair
                    const [revealed, setRevealed] = createState(false)

                    return (
                        <revealer
                            $={() => {
                                timeout(150, () => {
                                    setRevealed(true)
                                })
                                const isClosing = exiting((ex) => ex.has(key))

                                createEffect(() => {
                                    if (isClosing()) {
                                        setRevealed(false)
                                        timeout(600, () => removeItem(key))
                                    }
                                })
                            }}
                            revealChild={revealed}
                            transitionType={transitionType}
                            transitionDuration={transitionDuration}
                        >
                            {children(item, idx)}
                        </revealer>
                    )
                }}
            </For>
            <With value={rendered}>
                {(rendered) => {
                    if (rendered.size === 0) {
                        return emptyState
                    }
                    return <box />
                }}
            </With>
        </box>
    )
}
