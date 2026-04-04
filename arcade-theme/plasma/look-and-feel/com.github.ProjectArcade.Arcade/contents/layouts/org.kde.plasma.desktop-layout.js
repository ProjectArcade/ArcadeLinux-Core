// Arcade Linux - macOS-like Desktop Layout

// ─── TOP MENU BAR ───────────────────────────────────────────────
var topPanel = new Panel
topPanel.location = "top"
topPanel.height = Math.round(gridUnit * 1.8)
topPanel.floating = true
topPanel.hiding = "none"
topPanel.lengthMode = "fill"

// App launcher
var kickoff = topPanel.addWidget("org.kde.plasma.kickoff")
kickoff.currentConfigGroup = ["Shortcuts"]
kickoff.writeConfig("global", "Alt+F1")

// App menu
topPanel.addWidget("org.kde.plasma.appmenu")

// Spacer
topPanel.addWidget("org.kde.plasma.panelspacer")

// System tray
topPanel.addWidget("org.kde.plasma.systemtray")

topPanel.addWidget("org.kde.plasma.marginsseparator")

// Clock
var clock = topPanel.addWidget("org.kde.plasma.digitalclock")
clock.currentConfigGroup = ["Appearance"]
clock.writeConfig("showDate", "false")
clock.writeConfig("showSeconds", "false")

// Show desktop
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
    "applications:brave-browser.desktop",
    "applications:systemsettings.desktop",
])
tasks.writeConfig("iconSize", "3")
tasks.writeConfig("fill", "false")
