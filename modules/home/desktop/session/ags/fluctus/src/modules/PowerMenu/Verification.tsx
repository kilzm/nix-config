import { toggleAppWindow } from "@/src/lib/utils"
import PowerMenuService from "@/src/services/powermenu"
import Popup from "@/src/widgets/Popup"
import { windowNames } from "@/windows"
import { Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import { createBinding } from "gnim"

export default function Verification() {
    const power = PowerMenuService.get_default()

    return (
        <Popup
            application={app}
            name={windowNames.verification}
            namespace={"ags:verification"}
            class={"verification"}
        >
            <box orientation={Gtk.Orientation.VERTICAL}>
                <box orientation={Gtk.Orientation.VERTICAL} class={"text"}>
                    <label
                        halign={Gtk.Align.CENTER}
                        class={"title"}
                        label={createBinding(power, "title")}
                    />
                    <label
                        halign={Gtk.Align.CENTER}
                        class={"description"}
                        label={"Are you sure?"}
                    />
                </box>
                <box homogeneous cssClasses={["buttons"]}>
                    <button
                        onClicked={() => {
                            toggleAppWindow(windowNames.verification)
                            power.exec()
                        }}
                        label={"Yes"}
                    />
                    <button
                        onClicked={() => toggleAppWindow(windowNames.verification)}
                        label={"No"}
                    />
                </box>
            </box>
        </Popup>
    )
}
