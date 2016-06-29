import QtQuick 2.7

Item {
    id: root
    width: txtLink.implicitWidth
    height: txtLink.implicitHeight

    property string text: "Button"
    property string fontName: "Open Snas"
    property real   fontSize: 10
    property color  color: "#2196F3"
    property color  hlColor: "#2196F3"
    property color  downColor: "#2100F3"
    property bool   hovered: false

    signal entered()
    signal exited()
    signal pressed()
    signal released()
    signal clicked()

    Text {
        id: txtLink
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: root.fontName
        font.pointSize: root.fontSize
        color: root.color
        text: root.text
        textFormat: Text.RichText

        Behavior on color {
            ColorAnimation { duration: 50 }
        }
    }

    MouseArea {
        id: musArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: "PointingHandCursor"

        onEntered: {
            root.entered()
            txtLink.color = root.hlColor
            root.hovered = true
        }
        onExited: {
            root.exited()
            txtLink.color = root.color
            root.hovered = false
        }
        onPressed: {
            root.pressed()
            txtLink.color = root.downColor
        }
        onReleased: {
            root.released()
            txtLink.color = (root.hovered) ? root.hlColor : root.color
        }
        onClicked: root.clicked()
    }
}
