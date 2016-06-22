import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: root
    width: 100
    height: editBox.implicitHeight+10

    property color bgColor: "#ffffff"
    property string text: ""
    property color color: "#000000"

    Rectangle {
        id: rectBackground
        anchors.fill: parent
        color: root.bgColor
        clip:true

        TextEdit {
            id: editBox
            anchors.fill: parent
            font.family: "Gidole"
            verticalAlignment: Text.AlignVCenter
            text: (root.text=="") ? "Write a message..." : root.text
            clip: true
            cursorVisible: true
            wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
            selectByMouse: true
            selectionColor: "#569bdb"
            z:1
        }
    }
}

