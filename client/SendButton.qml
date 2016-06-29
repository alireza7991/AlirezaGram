import QtQuick 2.5

Item {
    id: root
    width: 50
    height: 40

    property color color: "#c0c0c0"
    property color hightlightColor: "#0b86e4"
    property color bgColor: "#ffffff"
    property variant itemFocus

    signal clicked()

    Rectangle {
        id: btn
        anchors.fill: parent
        color: root.bgColor
        clip: true

        Text {
            id: icon
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Material-Design-Iconic-Font"
            font.pointSize: 20
            color: (itemFocus.isEmpty) ? root.color : root.hightlightColor
            text: mi_send
            rotation: 45

            Behavior on scale {
                NumberAnimation { duration: 50 }
            }
            Behavior on color {
                ColorAnimation { duration: 50 }
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
        onEntered: {
            root.bgColor = "#f0f0f0"
        }
        onExited: {
            root.bgColor = "#ffffff"
        }
        onPressed: icon.scale = 0.9
        onReleased: icon.scale = 1
        onClicked: root.clicked()
    }
}

