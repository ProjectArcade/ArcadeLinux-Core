import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.kirigami as Kirigami

Item {
    id: root
    height: 40

    signal searchTextChanged(string text)

    function clear() {
        input.text = ""
    }

    function forceActiveFocus() {
        input.forceActiveFocus()
    }

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: Qt.rgba(1, 1, 1, 0.08)
        border.color: Qt.rgba(1, 1, 1, 0.12)
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 10
            spacing: 8

            Kirigami.Icon {
                source: "search"
                width: 16
                height: 16
                color: Qt.rgba(1, 1, 1, 0.45)
                Layout.alignment: Qt.AlignVCenter
            }

            TextField {
                id: input
                Layout.fillWidth: true
                placeholderText: "Search apps..."
                color: "white"
                font.pixelSize: 13

                background: Rectangle { color: "transparent" }

                onTextChanged: root.searchTextChanged(text)

                Keys.onEscapePressed: {
                    if (text !== "") {
                        text = ""
                    } else {
                        var dialog = root.parent
                        while (dialog && !dialog.hasOwnProperty("visible")) {
                            dialog = dialog.parent
                        }
                        if (dialog) {
                            dialog.visible = false
                        }
                    }
                }
            }
        }
    }
}
