import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root

    property bool cameraActive: false
    property bool privacyMode: false
    property string cameraApps: ""
    readonly property color indicatorColor: privacyMode ? Qt.rgba(0.95, 0.28, 0.28, 1.0) : Qt.rgba(0.18, 0.86, 0.42, 1.0)
    readonly property string checkCommand: "sh -c 'pids=\"\"; for dev in /dev/video*; do [ -e \"$dev\" ] || continue; devpids=$(fuser \"$dev\" 2>/dev/null | sed \"s/[^0-9[:space:]]/ /g\"); [ -n \"$devpids\" ] && pids=\"$pids $devpids\"; done; if [ -n \"$pids\" ]; then uniqpids=$(printf \"%s\\n\" $pids | tr \" \" \"\\n\" | sed \"/^$/d\" | sort -u); pidcsv=$(echo \"$uniqpids\" | tr \"\\n\" \",\" | sed \"s/,$//\"); apps=$(ps -p \"$pidcsv\" -o comm= 2>/dev/null | sed \"/^$/d\" | sort -u | tr \"\\n\" \",\" | sed \"s/,$//\"); echo \"active|$apps\"; else echo \"idle|\"; fi'"
    readonly property string stopCommand: "sh -c 'for dev in /dev/video*; do [ -e \"$dev\" ] || continue; fuser -k \"$dev\" >/dev/null 2>&1 || true; done; echo stopped'"

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    Plasmoid.status: (cameraActive || privacyMode) ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.HiddenStatus

    toolTipMainText: i18n("Camera")
    toolTipSubText: privacyMode
        ? i18n("Camera paused · Click to resume")
        : (cameraActive ? (cameraApps.length > 0 ? i18n("In use by: %1", cameraApps) : i18n("Camera is in use")) : i18n("Camera is idle"))

    function stopCameraNow() {
        execSource.disconnectSource(stopCommand)
        execSource.connectSource(stopCommand)
    }

    function togglePrivacyMode() {
        privacyMode = !privacyMode
        if (privacyMode) {
            stopCameraNow()
        }
        refreshCameraState()
    }

    function refreshCameraState() {
        execSource.disconnectSource(checkCommand)
        execSource.connectSource(checkCommand)
    }

    Plasma5Support.DataSource {
        id: execSource
        engine: "executable"
        connectedSources: []

        onNewData: function(sourceName, data) {
            if (sourceName === root.stopCommand) {
                execSource.disconnectSource(sourceName)
                return
            }

            if (sourceName !== root.checkCommand) {
                return
            }

            const stdoutText = data["stdout"] ? data["stdout"].toString().trim() : ""
            const parts = stdoutText.split("|")
            root.cameraActive = parts.length > 0 && parts[0] === "active"
            root.cameraApps = parts.length > 1 ? parts[1] : ""

            if (root.privacyMode && root.cameraActive) {
                root.stopCameraNow()
            }

            execSource.disconnectSource(sourceName)
        }
    }

    Timer {
        id: pollTimer
        interval: 1200
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refreshCameraState()
    }

    fullRepresentation: Item {
        id: indicatorContainer

        readonly property real indicatorSize: parent ? Math.min(parent.height, 11) : 11

        Layout.preferredWidth: (root.cameraActive || root.privacyMode) ? indicatorSize : 0
        Layout.preferredHeight: indicatorSize
        Layout.minimumWidth: (root.cameraActive || root.privacyMode) ? indicatorSize : 0
        Layout.minimumHeight: indicatorSize

        visible: root.cameraActive || root.privacyMode

        Rectangle {
            id: dot
            anchors.centerIn: parent
            width: indicatorContainer.indicatorSize
            height: indicatorContainer.indicatorSize
            radius: width / 2
            color: root.indicatorColor
            opacity: 0.95
        }

        PlasmaCore.ToolTipArea {
            anchors.fill: parent
            active: root.cameraActive || root.privacyMode
            mainText: i18n("Camera")
            subText: root.privacyMode
                ? i18n("Camera paused · Click to resume")
                : (root.cameraApps.length > 0 ? i18n("In use by: %1", root.cameraApps) : i18n("Camera is in use"))
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            onClicked: root.togglePrivacyMode()
        }

        SequentialAnimation {
            running: root.cameraActive || root.privacyMode
            loops: Animation.Infinite

            NumberAnimation {
                target: dot
                property: "opacity"
                from: 0.95
                to: 0.35
                duration: 380
                easing.type: Easing.InOutSine
            }

            NumberAnimation {
                target: dot
                property: "opacity"
                from: 0.35
                to: 0.95
                duration: 380
                easing.type: Easing.InOutSine
            }
        }
    }
}
