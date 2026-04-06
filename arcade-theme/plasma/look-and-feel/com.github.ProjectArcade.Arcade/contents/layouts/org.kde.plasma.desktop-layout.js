// Arcade Linux - iOS-inspired Desktop Layout

// ─── TOP MENU BAR ───────────────────────────────────────────────
var topPanel = new Panel
topPanel.location = "top"
topPanel.height = Math.round(gridUnit * 1.8)
topPanel.floating = true
topPanel.hiding = "none"
topPanel.lengthMode = "fill"

// Left section: app launcher and global app menu.
topPanel.addWidget("org.kde.plasma.kickoff")
topPanel.addWidget("org.kde.plasma.appmenu")

// Push utility widgets to the right side.
topPanel.addWidget("org.kde.plasma.panelspacer")

// Right section: media, audio, brightness, network, and battery widgets.
var media = topPanel.addWidget("org.kde.plasma.mediacontroller")

// Spacing before audio controls.
topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.volume")

// Spacing between volume and brightness controls.
topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.marginsseparator")

// Screen brightness control.
topPanel.addWidget("org.kde.plasma.brightness")

// Spacing before network management.
topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.marginsseparator")

topPanel.addWidget("org.kde.plasma.networkmanagement")

// Spacing between network and battery indicator.
topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.marginsseparator")

// Battery status indicator (auto-hidden by the plasmoid when no battery exists).
topPanel.addWidget("org.kde.plasma.arcadebatteryindicator")

topPanel.addWidget("org.kde.plasma.marginsseparator")
topPanel.addWidget("org.kde.plasma.marginsseparator")
// Right-end date and time display (Plasma 6 compatible).
var clock = topPanel.addWidget("org.kde.plasma.digitalclock")
clock.currentConfigGroup = ["Appearance"]
clock.writeConfig("showDate", "true")
clock.writeConfig("dateFormat", "custom")
clock.writeConfig("customDateFormat", "d MMM")
clock.writeConfig("showSeconds", "false")
clock.writeConfig("use24hFormat", "0")

// topPanel.addWidget("org.kde.plasma.showdesktop")
topPanel.opacity = "translucent"

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

