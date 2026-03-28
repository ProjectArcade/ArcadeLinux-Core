import QtQuick 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3

Rectangle {
    id: sidebar
    color: "#1A1A1A"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            color: "#1A1A1A"
            Layout.fillWidth: true
            height: 100

            Image {
                anchors.centerIn: parent
                source: "logo.png"
                width: 64
                height: 64
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#333333"
        }

        // Hardcoded steps for now since model API unknown
        Column {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Repeater {
                model: ["Welcome", "Location", "Keyboard", "Users", "Summary"]
                delegate: Rectangle {
                    width: parent.width
                    height: 44
                    color: "#1A1A1A"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        text: modelData
                        color: "#AAAAAA"
                        font.pixelSize: 12
                    }
                }
            }
        }
    }
}
