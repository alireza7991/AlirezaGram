import QtQuick 2.0

Item {
    id: root
    width: (maxWidth > appWindow.width/3) ? appWindow.width/3 : maxWidth
    height: txtMessageBubble.implicitHeight + 20

    property string pmText: ""
    property color selfColor:  "#d3edff" //"#a6ddff"
    property color otherColor: "#ffffff"
    property bool self: true
    property color bgColor: root.self ? root.selfColor : root.otherColor
    property int maxWidth: (txtMessageBubble.implicitWidth < rectTime_Check.width-10 ) ? txtMessageBubble.implicitWidth + (rectTime_Check.width - txtMessageBubble.implicitWidth) + 10 : txtMessageBubble.implicitWidth + 30
    property string pmTime: Qt.formatDateTime(new Date(), "hh:mm")

    Rectangle {
        id: rectMessageBubble
        color: root.bgColor
        anchors.fill: parent
        radius: 5


        Text {
            id: iconCaret
            anchors {
                left: root.self ? parent.right : parent.left
                bottom: parent.bottom
                bottomMargin: -5
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
            selectByMouse: true
            selectionColor: "#569bdb"
            text: root.pmText
            z:1
        }


        Rectangle {
            id: rectTime_Check
            anchors {
                left: if(self) parent.left
                right: if(!self) parent.right
                bottom: parent.bottom
                bottomMargin: -10
            }
            width: rowState.implicitWidth+10
            height: txtMessageTime.implicitHeight
            color: root.bgColor
            radius: 5
            Row {
                id: rowState
                anchors.fill: parent
                anchors.leftMargin: 5
                spacing: 5
                Text {
                    id: txtMessageTime
                    color: root.self ? "#2f7fFf" : "#a0a0a0"
                    font.family: "Open Sans"
                    font.pointSize: 9
                    text: root.pmTime
                }

                Text {
                    id: iconCheck
                    font.pointSize: 14
                    font.family: "Material-Design-Iconic-Font"
                    color: txtMessageTime.color
                    text: mi_check
                    visible: root.self ? true : false
                }
            }
        }
    }
}

