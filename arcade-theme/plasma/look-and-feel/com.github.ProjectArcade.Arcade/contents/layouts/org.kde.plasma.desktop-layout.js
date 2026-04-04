// Arcade Linux - iOS-inspired Desktop Layout

// ─── TOP MENU BAR ───────────────────────────────────────────────
var topPanel = new Panel
topPanel.location = "top"
topPanel.height = Math.round(gridUnit * 1.8)
topPanel.floating = true
topPanel.hiding = "none"
topPanel.lengthMode = "fill"

// LEFT SIDE
topPanel.addWidget("AndromedaLauncher")
topPanel.addWidget("org.kde.plasma.appmenu")

// CENTER - clock pinned to center
topPanel.addWidget("org.kde.plasma.panelspacer")

var clock = topPanel.addWidget("org.kde.plasma.digitalclock")
clock.currentConfigGroup = ["Appearance"]
clock.writeConfig("showDate", "true")
clock.writeConfig("showSeconds", "false")
clock.writeConfig("dateFormat", "shortDate")
clock.writeConfig("fixedFont", "true")
clock.writeConfig("fontSize", "11")

topPanel.addWidget("org.kde.plasma.panelspacer")

// RIGHT SIDE
var media = topPanel.addWidget("org.kde.plasma.mediacontroller")

topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.systemtray")
topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.showdesktop")

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
    "applications:org.kde.dolphin.desktop",
    "applications:org.kde.konsole.desktop",
    "preferred://browser",
    "applications:org.kde.plasma-systemmonitor.desktop",
    "applications:systemsettings.desktop",
])
tasks.writeConfig("iconSize", "3")
tasks.writeConfig("fill", "false")

dock.addWidget("org.kde.plasma.marginsseparator")
// dock.addWidget("org.kde.plasma.trash")
