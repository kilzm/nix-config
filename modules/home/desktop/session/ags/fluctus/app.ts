import app from "ags/gtk4/app"
import Bar from "@/src/modules/Bar"
import style from "./src/styles/style.scss"
import Osd from "@/src/modules/OSD"
import PowerMenu from "@/src/modules/PowerMenu"
import { toggleAppWindow } from "@/src/lib/utils"
import Verification from "@/src/modules/PowerMenu/Verification"
import Launcher from "@/src/modules/Launcher"
import NotificationPopups from "@/src/modules/Notifications/NotificationPopups"
import QuickSettings from "@/src/modules/QuickSettings"
import PopupArea from "@/src/widgets/PopupArea"

app.start({
    icons: `${ASSETS}/icons`,
    instanceName: "fluctus-shell",
    css: style,
    main: () => {
        const mainMonitor = app.get_monitors()[0]
        PopupArea()
        Bar(mainMonitor)
        Osd(mainMonitor)
        PowerMenu()
        Verification()
        Launcher()
        NotificationPopups()
        QuickSettings(mainMonitor)
    },
    requestHandler: (argv, res) => {
        if (argv.at(0) == "toggle") {
            toggleAppWindow(argv.at(1)!)
            res("ok")
        }
        res("unknown command")
    },
})
