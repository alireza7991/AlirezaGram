import QtQuick 2.7

Item {
    id: root
    width: 100
    height: 40

    property color color: "#c0c0c0"
    property color highlightColor: "#2f7fFf"
    property color bgColor: "#ffffff"
    property string icon: mi_camera

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
            color: root.color
            text: root.icon

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
            icon.color = root.highlightColor
            root.bgColor = "#f0f0f0"
        }
        onExited: {
            icon.color = root.color
            root.bgColor = "#ffffff"
        }
        onPressed: icon.scale = 0.9
        onReleased: icon.scale = 1
        onClicked: root.clicked()
    }
}
