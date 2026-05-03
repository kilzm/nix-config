import AstalNetwork from "gi://AstalNetwork?version=0.1"

const Icons = {
    nix: {
        flake: "nix-snowflake-symbolic",
    },
    media: {
        spotify: "spotify-client-symbolic",
        play: "media-playback-start-symbolic",
        pause: "media-playback-pause-symbolic",
        stop: "media-playback-stop-symbolic",
        next: "media-skip-forward-symbolic",
        previous: "media-skip-backward-symbolic",
    },
    powermenu: {
        sleep: "weather-clear-night-symbolic",
        reboot: "system-reboot-symbolic",
        logout: "system-log-out-symbolic",
        shutdown: "system-shutdown-symbolic",
    },
    ui: {
        tick: "object-select-symbolic",
        search: "system-search-symbolic",
        menu: "open-menu-symbolic",
        refresh: "view-refresh-symbolic",
        brightness: "display-brightness-symbolic",
        up: "pan-up-symbolic",
        down: "pan-down-symbolic",
        left: "pan-start-symbolic",
        right: "pan-end-symbolic",
        apps: "preferences-desktop-apps-symbolic",
        calculator: "org.gnome.Calculator-symbolic",
        terminal: "utilities-terminal-symbolic",
        info: "help-about-symbolic",
        websearch: "search-global-symbolic",
        file: "folder-documents-symbolic",
        directory: "document-open-symbolic",
        starred: "starred-symbolic",
        duckduckgo: "duckduckgo-symbolic",
        color: "preferences-color-symbolic",
        colorpicker: "color-select-symbolic",
        grid: "view-grid-symbolic",
        hdots: "view-more-horizontal",
        vdots: "view-more-vertical",
        hourglass: "hourglass-symbolic",
    },
    audio: {
        mic: {
            muted: "microphone-disabled-symbolic",
            low: "microphone-sensitivity-low-symbolic",
            medium: "microphone-sensitivity-medium-symbolic",
            high: "microphone-sensitivity-high-symbolic",
        },
        volume: {
            muted: "audio-volume-muted-symbolic",
            low: "audio-volume-low-symbolic",
            medium: "audio-volume-medium-symbolic",
            high: "audio-volume-high-symbolic",
            overamplified: "audio-volume-overamplified-symbolic",
        },
    },
    network: {
        wired: "network-wired-symbolic",
    },
    bluetooth: {
        enabled: "bluetooth-active-symbolic",
        disabled: "bluetooth-disabled-symbolic",
    },
    notifications: {
        noisy: "preferences-system-notifications-symbolic",
        silent: "notifications-disabled-symbolic",
    },
}

export default Icons

export function getNetworkIcon(network: AstalNetwork.Network) {
    const { connectivity, wifi, wired } = network
}
