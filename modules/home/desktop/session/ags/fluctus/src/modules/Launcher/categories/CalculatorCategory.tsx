import Category from "./Category"
import Item from "../Item"
import Icons from "../../../lib/icons"
import { Accessor, createEffect, createState } from "gnim"
import { execAsync } from "ags/process"

export default function CalculatorCategory(query: Accessor<string>) {
    const [result, setResult] = createState("")
    createEffect(() => {
        const q = query()
        if (q.startsWith("=")) {
            const expr = q.slice(1).trim()
            if (expr === "") {
                setResult("")
            } else {
                execAsync(`qalc --terse ${expr}`)
                    .then((res) => setResult(res))
                    .catch(() => setResult(""))
            }
        }
    })

    function copy() {
        execAsync(`wl-copy ${result.peek()}`)
    }

    const item = (
        <Item
            single
            class={"calculator"}
            title={result}
            onClicked={copy}
            canFocus={false}
            tooltipText={"Copy to clipboard"}
        >
            <image iconName={Icons.ui.calculator} />
        </Item>
    )

    return (
        <Category name={"Calculator"} action={copy}>
            {item}
        </Category>
    ) as Category
}
