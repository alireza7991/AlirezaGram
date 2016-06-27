import QtQuick 2.0
import QtQuick.Controls 1.4

TextEdit {
    id: editBox

    // Properties
    property color  bgColor: "#ffffff"
    property string placeholderText: ""

    width: 150
    height: 50

    anchors.leftMargin: 5
    font.family: "Gidole"
    font.pointSize: 9.5
    verticalAlignment: TextEdit.AlignVCenter
    clip: true
    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
    selectByMouse: true
    selectionColor: "#569bdb"
    renderType: Text.QtRendering

    Text {
        anchors.fill: parent
        verticalAlignment: editBox.verticalAlignment
        horizontalAlignment: editBox.horizontalAlignment
        font.family: editBox.font.family
        font.pointSize: editBox.font.pointSize
        text: editBox.placeholderText
        clip: true
        opacity: 0.4
        visible: (editBox.text != "") ? false : true
        z:1
    }
}
