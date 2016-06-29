import QtQuick 2.7

Item {
    id: root
    width: 150
    height: 40

    property string text: "Button"
    property string fontName: "Open Snas"
    property real   fontSize: 10
    property color  color: "#2196F3"
    property color  bgColor: "#eeeeee"
    property color  hlColor: "#2196F3"

    signal entered()
    signal exited()
    signal pressed()
    signal released()
    signal clicked()

    Rectangle {
        id: rectBtn
        anchors.fill: parent
        color: root.bgColor
        clip: true
        radius: 5

        Text {
            id: txtBtn
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: root.fontName
            font.pointSize: root.fontSize
            color: root.color
            text: root.text

            Behavior on scale {
                NumberAnimation { duration: 50 }
            }
            Behavior on color {
                ColorAnimation { duration: 50 }
            }
        }

        Behavior on color {
            ColorAnimation { duration: 100 }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: "PointingHandCursor"

        onEntered: {
            root.entered()
            rectBtn.color = root.hlColor
            txtBtn.color = "#ffffff"
        }
        onExited: {
            root.exited()
            rectBtn.color = root.bgColor
            txtBtn.color = root.color
        }
        onPressed: {
            root.pressed()
            txtBtn.scale = 0.9
        }
        onReleased: {
            root.released()
            txtBtn.scale = 1
        }
        onClicked: root.clicked()
    }
}
