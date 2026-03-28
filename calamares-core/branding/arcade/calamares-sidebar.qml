import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import io.calamares.ui 1.0

Rectangle {
    id: sidebar
    color: "#F5F5F5"

    // Step icons mapping
    property var stepIcons: [
        "icons/web.svg",
        "icons/language.svg",
        "icons/notes.svg",
        "icons/about.svg",
        "icons/notes.svg",
        "icons/go-next.svg"
    ]

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Logo area
        Rectangle {
            color: "#F5F5F5"
            Layout.fillWidth: true
            height: 120

            Column {
                anchors.centerIn: parent
                spacing: 10

                // Logo with subtle shadow effect
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 60
                    height: 60
                    radius: 14
                    color: "#FFFFFF"

                    layer.enabled: true
                    layer.effect: null

                    // Drop shadow simulation
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -1
                        radius: parent.radius + 1
                        color: "transparent"
                        border.color: "#E0E0E0"
                        border.width: 1
                        z: -1
                    }

                    Image {
                        anchors.centerIn: parent
                        source: "logo.png"
                        width: 40
                        height: 40
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Arcade Linux"
                    color: "#1A1A1A"
                    font.pixelSize: 12
                    font.bold: true
                    font.family: "JetBrains Mono"
                }
            }
        }

        // Divider
        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            height: 1
            color: "#E0E0E0"
        }

        // Spacing
        Item { Layout.fillWidth: true; height: 8 }

        // Steps
        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            model: ViewManager
            clip: true
            spacing: 2

            delegate: Rectangle {
                width: ListView.view.width
                height: 42
                radius: 8
                color: index === ViewManager.currentStepIndex ? "#FFFFFF" : "transparent"

                // Subtle border for active item
                Rectangle {
                    visible: index === ViewManager.currentStepIndex
                    anchors.fill: parent
                    radius: 8
                    color: "transparent"
                    border.color: "#E8E8E8"
                    border.width: 1
                }

                // Active left accent
                Rectangle {
                    visible: index === ViewManager.currentStepIndex
                    width: 3
                    height: 22
                    radius: 2
                    color: "#00CC00"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                }

                // Step icon
                Image {
                    id: stepIcon
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    width: 16
                    height: 16
                    source: index < stepIcons.length ? stepIcons[index] : ""
                    fillMode: Image.PreserveAspectFit
                    opacity: index === ViewManager.currentStepIndex ? 1.0 : 0.4
                }

                // Step name
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: stepIcon.right
                    anchors.leftMargin: 10
                    text: display
                    color: index === ViewManager.currentStepIndex
                        ? "#00AA00"
                        : index < ViewManager.currentStepIndex
                            ? "#AAAAAA"
                            : "#444444"
                    font.pixelSize: 12
                    font.bold: index === ViewManager.currentStepIndex
                    font.family: "JetBrains Mono"
                }

                // Completed dot
                Rectangle {
                    visible: index < ViewManager.currentStepIndex
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 14
                    width: 6
                    height: 6
                    radius: 3
                    color: "#00CC00"
                    opacity: 0.5
                }
            }
        }

        // Bottom version
        Rectangle {
            color: "#F5F5F5"
            Layout.fillWidth: true
            height: 44

            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                height: 1
                color: "#E0E0E0"
            }

            Text {
                anchors.centerIn: parent
                text: "v1.0.0"
                color: "#BBBBBB"
                font.pixelSize: 10
                font.family: "JetBrains Mono"
            }
        }
    }
}
