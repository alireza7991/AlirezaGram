import QtQuick 2.0
import QtQuick.Controls 1.4

TextEdit {
    id: editBox

    // Properties
    property string placeholderText: ""
    property bool   isEmpty: txtPlaceHolder.visible

    width: 150
    height: 50

    anchors.leftMargin: 5
    font.family: "Gidole"
    font.pointSize: 9.5
    verticalAlignment: TextEdit.AlignVCenter
    clip: true
    wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
    text:""
    selectByMouse: true
    selectionColor: "#569bdb"
    renderType: Text.QtRendering
    textFormat: Text.RichText

    onTextChanged: if(getText(0,1) == "")
                       txtPlaceHolder.visible = true
                   else
                       txtPlaceHolder.visible = false


    Text {
        id: txtPlaceHolder
        anchors.fill: parent
        verticalAlignment: editBox.verticalAlignment
        horizontalAlignment: editBox.horizontalAlignment
        font.family: editBox.font.family
        font.pointSize: editBox.font.pointSize
        text: editBox.placeholderText
        clip: true
        opacity: 0.4
        visible: (editBox.text != "") ? false : true
        z:2
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: "IBeamCursor"
        onClicked: parent.forceActiveFocus()
    }
}
