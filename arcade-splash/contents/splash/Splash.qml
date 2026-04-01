import QtQuick
import QtQuick.Window

Rectangle {
    id: root
    color: "#000000"
    property int stage

    // Current hour
    property int hour: new Date().getHours()

    // Greeting
    property string greeting: {
        if (hour < 12)
            return "Good morning"
        else if (hour < 17)
            return "Good afternoon"
        else if (hour < 21)
            return "Good evening"
        else
            return "It's late"
    }

    // Quote pools
    property var morningQuotes: [
        "A new day. A new chance to level up.",
        "Wake up. Your future is waiting.",
        "Sunlight means it's time to rise stronger.",
        "Start sharp. Stay unstoppable.",
        "Every morning is a fresh respawn.",
        "Discipline begins before the world wakes.",
        "Today is yours—claim it.",
        "No delays. Begin now.",
        "The early grind builds empires.",
        "Reset. Refocus. Rise."
    ]

    property var afternoonQuotes: [
        "Stay locked in. You're halfway there.",
        "Focus beats talent every time.",
        "Keep pushing. Momentum matters.",
        "No distractions. Just execution.",
        "This is where most people quit. Don’t.",
        "Stay consistent. Stay dangerous.",
        "Progress is built right now.",
        "One step more. Then another.",
        "You’re in the middle—keep moving.",
        "Pressure creates precision."
    ]

    property var eveningQuotes: [
        "The day isn’t over yet.",
        "Finish strong. Always.",
        "Evenings decide winners.",
        "Push a little more before rest.",
        "Consistency beats intensity.",
        "Close the day with progress.",
        "What you do now matters tomorrow.",
        "Stay focused. No wasted hours.",
        "Refine. Improve. Repeat.",
        "End the day better than you started."
    ]

    property var nightQuotes: [
        "Welcome back. The grind never left you.",
        "It's late… but legends are built now.",
        "The moon is watching. Don’t waste the night.",
        "Silence the world. Focus on your path.",
        "Night mode: discipline only.",
        "While others sleep, you build.",
        "Dark hours. Bright future.",
        "No shortcuts. Only progress.",
        "Tonight decides tomorrow.",
        "Stay relentless."
    ]

    // Select active quote pool
    property var activeQuotes: {
        if (hour < 12)
            return morningQuotes
        else if (hour < 17)
            return afternoonQuotes
        else if (hour < 21)
            return eveningQuotes
        else
            return nightQuotes
    }

    // Random quote
    property string selectedQuote: activeQuotes[Math.floor(Math.random() * activeQuotes.length)]

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Rectangle {
            id: imageSource
            width: 800
            height: 600
            color: "transparent"
            anchors.centerIn: parent
            clip: true

            AnimatedImage {
                id: face
                source: "images/arcade.gif"
                anchors.centerIn: parent
                width: 798
                height: 598
                smooth: true
            }
        }

        Image {
            id: busyIndicator
            y: parent.height - 200
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/loading.svgz"
            sourceSize.height: units.gridUnit * 2
            sourceSize.width: units.gridUnit * 2

            RotationAnimator on rotation {
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }

        // Bottom text block
        Column {
            spacing: units.smallSpacing
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gridUnit * 2

            Text {
                text: root.greeting
                color: "#ffffff"
                font.pixelSize: units.gridUnit * 1.4
                font.bold: true
                opacity: 0.9
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: root.selectedQuote
                color: "#aaaaaa"
                font.pixelSize: units.gridUnit * 1.1
                font.italic: true
                opacity: 0.85
                wrapMode: Text.Wrap
                width: root.width * 0.8
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}