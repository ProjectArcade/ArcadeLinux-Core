import QtQuick 2.0
import calamares.slideshow 1.0

Presentation {
    id: presentation

    function nextSlide() {
        presentation.goToNextSlide()
    }

    Timer {
        id: advanceTimer
        interval: 4000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    Slide {
        Image {
            id: bg1
            source: "background.png"
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectCrop
        }
        Text {
            anchors.centerIn: parent
            text: "Welcome to Arcade Linux"
            color: "#cdd6f4"
            font.pixelSize: 28
            font.bold: true
        }
    }

    Slide {
        Image {
            source: "background.png"
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectCrop
        }
        Text {
            anchors.centerIn: parent
            text: "Fast. Lightweight. Beautiful."
            color: "#89b4fa"
            font.pixelSize: 26
            font.bold: true
        }
    }

    Slide {
        Image {
            source: "background.png"
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectCrop
        }
        Text {
            anchors.centerIn: parent
            text: "Built on Arch. Designed for everyone."
            color: "#a6e3a1"
            font.pixelSize: 26
            font.bold: true
        }
    }
}
