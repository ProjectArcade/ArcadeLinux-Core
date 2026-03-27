import QtQuick 2.0
import calamares.slideshow 1.0

Presentation {
    id: presentation

    Timer {
        interval: 5000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#f8fafc"

            // Subtle blue blob top-right
            Rectangle {
                width: 320; height: 320
                radius: 160
                color: "#dbeafe"
                opacity: 0.6
                anchors { top: parent.top; right: parent.right; topMargin: -60; rightMargin: -60 }
            }

            Column {
                anchors.centerIn: parent
                spacing: 16

                Image {
                    source: "logo.png"
                    width: 80; height: 80
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "ARCADE LINUX"
                    font.pixelSize: 28
                    font.bold: true
                    font.letterSpacing: 4
                    color: "#0f172a"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Fast. Clean. Powerful."
                    font.pixelSize: 14
                    color: "#3b82f6"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.letterSpacing: 1
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#f8fafc"

            Rectangle {
                width: 280; height: 280
                radius: 140
                color: "#bfdbfe"
                opacity: 0.5
                anchors { bottom: parent.bottom; left: parent.left; bottomMargin: -40; leftMargin: -40 }
            }

            Column {
                anchors.centerIn: parent
                spacing: 16

                Text {
                    text: "Built on Arch Linux"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#0f172a"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Minimal and fully customizable"
                    font.pixelSize: 14
                    color: "#64748b"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#f8fafc"

            Column {
                anchors.centerIn: parent
                spacing: 16

                Text {
                    text: "Designed for Performance"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#0f172a"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Smooth experience, every time"
                    font.pixelSize: 14
                    color: "#64748b"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
