import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.0 as Kirigami

Rectangle {
    id: sidebar
    color: "#1A1A1A"
    width: 200

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Logo area
        Rectangle {
            color: "#1A1A1A"
            Layout.fillWidth: true
            height: 100

            Image {
                anchors.centerIn: parent
                source: "file:///etc/calamares/branding/arcade/logo.png"
                width: 64
                height: 64
                fillMode: Image.PreserveAspectFit
            }
        }

        // Divider
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#333333"
        }

        // Steps list
        ListView {
            id: stepsList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: globalPaletteModel
            clip: true

            delegate: Rectangle {
                width: parent.width
                height: 44
                color: index === currentStepIndex ? "#252525" : "#1A1A1A"

                Rectangle {
                    visible: index === currentStepIndex
                    width: 3
                    height: parent.height
                    color: "#00FF00"
                    anchors.left: parent.left
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    text: display
                    color: index === currentStepIndex ? "#00FF00" : "#AAAAAA"
                    font.pixelSize: 12
                    font.family: "JetBrains Mono"
                    font.bold: index === currentStepIndex
                }
            }
        }
    }
}
