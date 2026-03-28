import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import io.calamares.ui 1.0

Rectangle {
    id: sidebar
    color: "#111111"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Logo area
        Rectangle {
            color: "#111111"
            Layout.fillWidth: true
            height: 110

            Column {
                anchors.centerIn: parent
                spacing: 8

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "logo.png"
                    width: 52
                    height: 52
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Arcade Linux"
                    color: "#FFFFFF"
                    font.pixelSize: 11
                    font.bold: true
                    font.family: "JetBrains Mono"
                }
            }
        }

        // Divider
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#00FF00"
            opacity: 0.3
        }

        // Steps
        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: ViewManager
            clip: true

            delegate: Rectangle {
                width: ListView.view.width
                height: 48
                color: index === ViewManager.currentStepIndex ? "#1A2A1A" : "#111111"

                Rectangle {
                    visible: index === ViewManager.currentStepIndex
                    width: 3
                    height: parent.height
                    color: "#00FF00"
                    anchors.left: parent.left
                }

                Text {
                    id: stepNum
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    text: (index + 1) + ""
                    color: index === ViewManager.currentStepIndex ? "#00FF00" : "#444444"
                    font.pixelSize: 10
                    font.family: "JetBrains Mono"
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: stepNum.right
                    anchors.leftMargin: 10
                    text: display
                    color: index === ViewManager.currentStepIndex ? "#00FF00" : index < ViewManager.currentStepIndex ? "#666666" : "#AAAAAA"
                    font.pixelSize: 12
                    font.bold: index === ViewManager.currentStepIndex
                    font.family: "JetBrains Mono"
                }

                Text {
                    visible: index < ViewManager.currentStepIndex
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 16
                    text: "✓"
                    color: "#00FF00"
                    font.pixelSize: 12
                    opacity: 0.6
                }
            }
        }

        // Bottom
        Rectangle {
            color: "#111111"
            Layout.fillWidth: true
            height: 40

            Text {
                anchors.centerIn: parent
                text: "v1.0.0"
                color: "#333333"
                font.pixelSize: 10
                font.family: "JetBrains Mono"
            }
        }
    }
}
