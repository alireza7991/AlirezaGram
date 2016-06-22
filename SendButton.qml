import QtQuick 2.5

Item {
    id: root
    width: 100
    height: 40

    property color color: "#0b86e4"
    property color bgColor: "#ffffff"
    property string text: "Send"

    signal clicked()

    Rectangle {
        id: btn
        anchors.fill: parent
        color: root.bgColor
        clip: true

        Text {
            id: txtBtn
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Open Sans"
            font.pointSize: 12
            color: root.color
            text: root.text

            Behavior on scale {
                NumberAnimation { duration: 50 }
            }
        }

        Behavior on color {
            ColorAnimation { duration: 50 }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: "PointingHandCursor"
        onEntered: root.bgColor = "#f0f0f0"
        onExited: root.bgColor = "#ffffff"
        onPressed: txtBtn.scale = 0.9
        onReleased: txtBtn.scale = 1
        onClicked: root.clicked()
    }
}

