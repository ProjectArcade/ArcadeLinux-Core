// ─── TOP MENU BAR ───────────────────────────────────────────────
var topPanel = new Panel
topPanel.location = "top"
topPanel.height = Math.round(gridUnit * 1.8)
topPanel.floating = true
topPanel.hiding = "none"
topPanel.lengthMode = "fill"

// ── App launcher ─────────────────────────────────────────────────
topPanel.addWidget("org.kde.plasma.arcade-launcher")

// ── Global app menu ──────────────────────────────────────────────
topPanel.addWidget("org.kde.plasma.appmenu")

// ── Spacer ────────────────────────────────────────────────────────
topPanel.addWidget("org.kde.plasma.panelspacer")

// ── Media controller — vanishes when nothing playing ─────────────
var media = topPanel.addWidget("org.kde.plasma.mediacontroller")
media.currentConfigGroup = ["General"]
media.writeConfig("displayWhenNoPlayer", "false")

topPanel.addWidget("org.kde.plasma.marginsseparator")

// ── System tray — ONLY screen recording + VPN when active ────────
// bluetooth is standalone below, so hide it here to avoid duplicate
var tray = topPanel.addWidget("org.kde.plasma.systemtray")
tray.currentConfigGroup = ["General"]

tray.writeConfig("knownItems", [
    "org.kde.plasma.screenrecording",
    "org.kde.plasma.vpn",
    "org.kde.plasma.battery",
    "org.kde.plasma.volume",
    "org.kde.plasma.brightness",
    "org.kde.plasma.networkmanagement",
    "org.kde.plasma.bluetooth",
    "org.kde.kscreen",
    "org.kde.plasma.clipboard",
    "org.kde.plasma.notifications",
    "org.kde.plasma.mediacontroller",
])

tray.writeConfig("hiddenItems", [
    "org.kde.plasma.battery",
    "org.kde.plasma.volume",
    "org.kde.plasma.brightness",
    "org.kde.plasma.networkmanagement",
    "org.kde.plasma.bluetooth",        // hidden here — standalone below
    "org.kde.kscreen",
    "org.kde.plasma.clipboard",
    "org.kde.plasma.notifications",
    "org.kde.plasma.mediacontroller",
])

tray.writeConfig("shownItems", [
    "org.kde.plasma.screenrecording",  // red dot when recording
    "org.kde.plasma.vpn",              // only when VPN on
])

topPanel.addWidget("org.kde.plasma.marginsseparator")

// ── Bluetooth — standalone KDE default (tray one is hidden above) ─
topPanel.addWidget("org.kde.plasma.bluetooth")

topPanel.addWidget("org.kde.plasma.marginsseparator")

// ── Wifi — KDE default networkmanagement ─────────────────────────
topPanel.addWidget("org.kde.plasma.networkmanagement")

topPanel.addWidget("org.kde.plasma.marginsseparator")

// ── Battery — your arcade battery indicator ───────────────────────
topPanel.addWidget("org.kde.plasma.arcadebatteryindicator")

topPanel.addWidget("org.kde.plasma.marginsseparator")

// ── Clock — KDE default, precise date + 12h time ─────────────────
var clock = topPanel.addWidget("org.kde.plasma.digitalclock")
clock.currentConfigGroup = ["Appearance"]
clock.writeConfig("showDate", "true")
clock.writeConfig("dateFormat", "custom")
clock.writeConfig("customDateFormat", "ddd, d MMM ")
clock.writeConfig("showSeconds", "false")
clock.writeConfig("use24hFormat", "0")
clock.writeConfig("showTimezone", "false")

topPanel.opacity = "translucent"

// ─── BOTTOM FLOATING DOCK ────────────────────────────────────────
var dock = new Panel
dock.location = "bottom"
dock.height = 64
dock.floating = true
dock.hiding = "none"
dock.lengthMode = "fit"
dock.alignment = "center"

var tasks = dock.addWidget("org.kde.plasma.icontasks")
tasks.currentConfigGroup = ["General"]
tasks.writeConfig("launchers", [
    "preferred://filemanager",
    "applications:org.kde.konsole.desktop",
    "preferred://browser",
    "applications:org.kde.plasma-systemmonitor.desktop",
    "applications:systemsettings.desktop",
])

dock.opacity = "translucent"

// ─── BOTTOM FLOATING DOCK ────────────────────────────────────────
var dock = new Panel
dock.location = "bottom"
dock.height = 64
dock.floating = true
dock.hiding = "none"
dock.lengthMode = "fit"
dock.alignment = "center"

var tasks = dock.addWidget("org.kde.plasma.icontasks")
tasks.currentConfigGroup = ["General"]
tasks.writeConfig("launchers", [
    "preferred://filemanager",
    "applications:org.kde.konsole.desktop",
    "preferred://browser",
    "applications:org.kde.plasma-systemmonitor.desktop",
    "applications:systemsettings.desktop",
])

dock.opacity = "translucent"

// ─── BOTTOM FLOATING DOCK ───────────────────────────────────────
var dock = new Panel
dock.location = "bottom"
dock.height = 64
dock.floating = true
dock.hiding = "none"
dock.lengthMode = "fit"
dock.alignment = "center"

var tasks = dock.addWidget("org.kde.plasma.icontasks")
tasks.currentConfigGroup = ["General"]
tasks.writeConfig("launchers", [
    "preferred://filemanager",
    "applications:org.kde.konsole.desktop",
    "preferred://browser",
    "applications:org.kde.plasma-systemmonitor.desktop",
    "applications:systemsettings.desktop",
])

dock.opacity = "translucent"

