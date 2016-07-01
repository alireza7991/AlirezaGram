import QtQuick 2.0

Item {
    id: root
    width: (sticker) ? maxWidth : (maxWidth > appWindow.width/3) ? appWindow.width/3 : maxWidth
    height: (sticker) ? txtMessageBubble.implicitHeight + 50 : txtMessageBubble.implicitHeight + 15

    property string pmText: ""
    property color selfColor:  "#d3edff"
    property color otherColor: "#ffffff"
    property bool self: true
    property color bgColor: root.sticker ? "transparent" : root.self ? root.selfColor : root.otherColor
    property int maxWidth: txtMessageBubble.implicitWidth + 30
    property string pmTime: Qt.formatDateTime(new Date(), "hh:mm")
    property bool sticker: false

    Rectangle {
        id: rectMessageBubble
        anchors.fill: parent
        color: root.bgColor
        radius: 5

        Text {
            id: iconCaret
            anchors {
                left: root.self ? parent.right : parent.left
                top: parent.top
                topMargin: -5
                leftMargin: root.self ? -3 : -6
            }
            font.family: "Material-Design-Iconic-Font"
            font.pointSize: 30
            color: root.bgColor
            text: root.self ? mi_caret_right : mi_caret_left
        }

        TextEdit {
            id: txtMessageBubble
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            font.family: "Open Sans"
            font.pointSize: 9.5
            verticalAlignment: Text.AlignVCenter
            wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
            clip:true
            cursorVisible: false
            readOnly: true
            selectByMouse: !sticker
            selectionColor: "#569bdb"
            text: root.pmText
            textFormat: TextEdit.RichText
            z:1
        }
    }
}

