import QtQuick 2.7
import QtQuick.Controls 1.4 as Quick1
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: appWindow
    visible: true

    width: 800
    height: 600

    minimumHeight: 500
    minimumWidth: 600

    background: BorderImage {
        id: bgImage
        source: "qrc:/images/images/blurred.jpg"
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
    }


    flags: Qt.FramelessWindowHint || Qt.Window
    visibility: "Maximized"

    onVisibilityChanged: appWindowButtons.max_min = (appWindow.visibility==4) ? mi_restore : mi_maximize


    Rectangle {
        id: rectTitle
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: 39
        color: "#1955a4"

        Rectangle {
            id: icon
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 10
            }
            width: 20
            color: "#153a88"
            radius: 20
        }

        Row {
            id: titleBtnsRow
            anchors{
                left: icon.right
                right: rectTitle.right
                top: rectTitle.top
                bottom: rectTitle.bottom
                rightMargin: 5
                leftMargin: 5
            }
            z:2

            TButton {
                id: tbtnSettings
                height: parent.height
                caption: "Settings"
            }
            TButton {
                id: tbtnAbout
                height: parent.height
                caption: "About"

                onClicked: {
                    stkViewMain.push(pageSettings)
                }
            }
        }

        WindowButtons {
            id: appWindowButtons
            anchors {
                right: rectTitle.right
                top: rectTitle.top
                bottom: rectTitle.bottom
                margins: 10
                rightMargin: 15
            }
            z:3
        }

        MouseArea {
            id: mouseRegion
            anchors.fill: parent;
            property variant clickPos: "1,1"

            onPressed: {
                clickPos  = Qt.point(mouse.x,mouse.y)
            }

            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                appWindow.x += delta.x;
                appWindow.y += delta.y;
            }
        }
    }

    StackView {
        id: stkViewMain
        anchors {
            left: parent.left
            right: parent.right
            top: rectTitle.bottom
            bottom: parent.bottom
        }
        initialItem: pageMain
    }

    Rectangle {
        id: pageMain
        color: "transparent"
        visible: false

        property int listWidth: appWindow.width / 2.8

        Rectangle {
            id: rectSearchBox
            anchors {
                left: parent.left
                top: parent.top
            }
            width: pageMain.listWidth
            height: 54

            property color borderColor: editSearch.bgColor

            Rectangle {
                anchors.fill: parent
                anchors.margins: 10
                border.color: rectSearchBox.borderColor
                border.width: 2

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: "IBeamCursor"
                    onClicked:
                        editSearch.forceActiveFocus()
                }
            }

            Rectangle {
                id: iconSearch
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 12
                    rightMargin: 0
                }
                width: 40
                color: editSearch.bgColor

                Text {
                    anchors.fill: parent
                    font.family: "Material-Design-Iconic-Font"
                    font.pointSize: 15
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: editSearch.focus ? "#2991d1" : "#a0a0a0"
                    text: mi_search

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }
            }

            Quick1.TextField {
                id: editSearch
                anchors {
                    left: iconSearch.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 12
                    leftMargin:0
                }
                placeholderText: "Search"
                font.family: "Open Sans"
                font.pointSize: 10
                property color bgColor: "#f0f0f0"
                clip: true

                style: TextFieldStyle {
                    background: Rectangle {
                        id: rectEditSearchStyle
                        color: editSearch.bgColor
                    }
                    placeholderTextColor: "#a0a0a0"
                }

                onFocusChanged: {
                    if(editSearch.focus){
                        editSearch.bgColor = "#ffffff"
                        rectSearchBox.borderColor = "#4ab7ee"
                    } else {
                        editSearch.bgColor = "#f0f0f0"
                        rectSearchBox.borderColor = editSearch.bgColor
                    }
                }

                Behavior on bgColor {
                    ColorAnimation { duration: 50 }
                }
            }

            Behavior on borderColor {
                ColorAnimation { duration: 50 }
            }
        }

        Rectangle {
            anchors {
                left: parent.left
                right: rectSearchBox.right
                top: rectSearchBox.bottom
                bottom: parent.bottom
            }
            color: "#ffffff"

            Flickable {
                id: flickListChat
                anchors.fill: parent
                contentWidth: columnListChat.implicitWidth
                contentHeight: columnListChat.implicitHeight
                clip: true



                contentY: verticalScrollListChat.contentY

                states: State {
                    name: "ShowBars"
                    when: flickListChat.movingVertically
                    PropertyChanges { target: verticalScrollListChat; opacity: 1 }
                }

                transitions: Transition {
                    NumberAnimation { properties: "opacity"; duration: 200 }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.visible = false
                }

                Rectangle {
                    id: rectList
                    width: pageMain.listWidth
                    height: columnListChat.implicitHeight
                    color: "#ffffff"

                    property ListButton lastButton;
                    property bool checked: false

                    ListModel {
                        id: listModelChatList
                    }

                    Column {
                        id: columnListChat
                        anchors.fill: parent

                        Repeater {
                            id: listViewChatList
                            model: listModelChatList
                            delegate: ListButton {
                                width: parent.width
                                caption: title
                                lastText: text
                                lastTime: (listModelMessages.count) ? listViewMessages.itemAt(0).pmTime : "00:00"
                                newMessage: index+1
                                bgPicColor: Qt.rgba(Math.random(250),Math.random(250),Math.random(250))

                                onPressed: {
                                    if(!rectList.checked){
                                        rectList.lastButton = this;
                                        rectList.checked = true;
                                        this.checked = true;
                                    } else {
                                        rectList.lastButton.checked = false;
                                        rectList.lastButton = this;
                                        this.checked = true;
                                    }
                                }
                            } // ListButton
                        } // Repeater
                    } // Column
                } // rectList
            } // ScrollView
            MScrollBar {
                id: verticalScrollListChat
                width: 6; height: flickListChat.height-12
                anchors.right: flickListChat.right
                flickableItem: flickListChat
                anchors.rightMargin: 2
                bgColor: "#1955a4"
                bgOpacity: 0.3
                handleOpacity: 0.7
                opacity: 0
                orientation: Qt.Vertical
                position: flickListChat.visibleArea.yPosition
                pageSize: flickListChat.visibleArea.heightRatio
                clip: true
                visible: (flickListChat.height < rectList.height) ? true : false
                z:5
            }
        }


        Rectangle {
            id: rectProfileTitle
            anchors {
                left: rectSearchBox.right
                right: parent.right
                top: parent.top
                leftMargin: 0.5
            }
            height: 54.5

            Rectangle {
                // Border Left
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 0.5
                color: "#e9e9e9"
            }

            Rectangle {
                // Border Bottom
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                height: 0.5
                color: "#e9e9e9"
            }

            Text {
                id: txtProfileTitle
                anchors {
                    left: parent.left
                    top: parent.top
                    margins: 8.5
                    leftMargin: 16
                }
                font.family: "Open Sans"
                font.pointSize: 9.25
                font.weight: Font.DemiBold
                text: "[M]ohammad [R]eza"
            }

            Text {
                id: txtProfileStatus
                anchors {
                    left: parent.left
                    top: txtProfileTitle.bottom
                    margins: 2
                    leftMargin: 16
                }
                font.family: "Open Sans"
                font.pointSize: 9.25
                color: "#959595"
                text: "last seen recently"
            }

            ChevronButton {
                id: btnCRight
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 28
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: "PointingHandCursor"
                onEntered: btnCRight.opacity = 1
                onExited: btnCRight.opacity = 0.5
            }
        }

        Rectangle {
            id: rectMessageBox
            anchors {
                left: rectSearchBox.right
                right: parent.right
                bottom: parent.bottom
                leftMargin: 0.5
            }
            height: 46

            Rectangle {
                // Border Left
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 0.5
                color: "#e9e9e9"
            }

            Rectangle {
                // Border Top
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: 0.5
                color: "#e9e9e9"
            }

            SendButton {
                id: btnSend
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    topMargin: 1
                }
                width: 50
                itemFocus: editMessageBox

                onClicked: {
                    while(editMessageBox.getText(0,1)==" ")
                        editMessageBox.remove(0,1)
                    if(editMessageBox.text!="") {
                        listModelMessages.insert(listViewMessages.count,{text:editMessageBox.text, anchor:"Right", time: Qt.formatDateTime(new Date(), "hh:mm")})
                        editMessageBox.text = ""
                        if(listModelChatList.count) listViewChatList.itemAt(0).lastTime = Qt.formatDateTime(new Date(), "hh:mm")
                        if (scrollViewMessages.contentY < flickListMessages.maxContentY){
                            scrollViewMessages.contentY = flickListMessages.maxContentY
                        }
                    }
                }
            }

            SFaceButton {
                id: btnFaceSticker
                anchors {
                    right: btnSend.left
                    top: parent.top
                    bottom: parent.bottom
                    topMargin: 1
                }
                width: 40
            }

            WebCamButton {
                id: webCameraButton
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 50
            }

            Rectangle {
                id: rectEditMessageBox
                anchors {
                    left: webCameraButton.right
                    right: btnFaceSticker.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 10
                    leftMargin: 5
                    rightMargin: 5
                }

                Quick1.TextField {
                    id: editMessageBox
                    anchors.fill: parent
                    font.family: "Open Sans"
                    font.pointSize: 9.5
                    placeholderText: " Write a message..."

                    z:1

                    Keys.onReturnPressed: {
                        while(editMessageBox.getText(0,1)==" ")
                            editMessageBox.remove(0,1)
                        if(editMessageBox.text!="") {
                            listModelMessages.insert(listViewMessages.count,{text:editMessageBox.text, anchor:"Right", time: Qt.formatDateTime(new Date(), "hh:mm")})
                            editMessageBox.text = ""
                            if (scrollViewMessages.contentY < flickListMessages.maxContentY){
                                scrollViewMessages.contentY = flickListMessages.maxContentY
                            }
                        }
                    }

                    style: TextFieldStyle {
                        background: Rectangle {
                            anchors.fill: parent
                            color: "#ffffff"
                        }
                        renderType: Text.QtRendering
                    }
                }
            }
        }

        Rectangle {
            id: rectMessagePage
            anchors {
                left: rectSearchBox.right
                right: parent.right
                top: rectProfileTitle.bottom
                bottom: rectMessageBox.top
            }
            color: "transparent"
            clip: true

            ListModel {
                id: listModelMessages
            }

            Flickable {
                id: flickListMessages
                anchors.fill: parent
                contentWidth: columnListMessages.implicitWidth
                contentHeight: columnListMessages.implicitHeight
                clip: true

                property real maxContentY: (listViewMessages.count!=0) ? ((flickListMessages.contentHeight - flickListMessages.height) +
                                            (listViewMessages.itemAt(listViewMessages.count-1).height + listMessagesFooter.implicitHeight)) : 0

                contentY: scrollViewMessages.contentY

                states: State {
                    name: "ShowBars"
                    when: flickListMessages.movingVertically
                    PropertyChanges { target: scrollViewMessages; opacity: 1 }
                }

                transitions: Transition {
                    NumberAnimation { properties: "opacity"; duration: 200 }
                }

                Column {
                    id: columnListMessages
                    spacing: 15

                    Text {
                        id: listMessagesHeader
                        width: 1
                        height: 1
                    }

                    Repeater {
                        id: listViewMessages
                        width: rectMessagePage.width
                        model: listModelMessages
                        delegate: MessageBubble {
                            anchors {
                                left: if(anchor=="Left") listViewMessages.left
                                right: if(anchor=="Right") listViewMessages.right
                                margins: 15
                                bottomMargin: 10
                            }
                            self: (anchor=="Right")? true : false
                            pmText: text
                        }
                    }

                    Text {
                        id: listMessagesFooter
                        width: 1
                        height: 5
                    }
                }
            }

            MScrollBar {
                id: scrollViewMessages
                width: 7;
                height: flickListMessages.height-12
                anchors.right: flickListMessages.right
                flickableItem: flickListMessages
                anchors.rightMargin: 2
                bgColor: "#ffffff"
                bgOpacity: 0.3
                handleOpacity: 0.7
                opacity: 0
                orientation: Qt.Vertical
                position: flickListMessages.visibleArea.yPosition
                pageSize: flickListMessages.visibleArea.heightRatio
                clip: true
                visible: (flickListMessages.contentHeight > rectMessagePage.height) ? true : false
            }
        }
    }

    Rectangle {
        id: pageSettings
        color: "transparent"
        visible: false

        Text {
            anchors.centerIn: pageSettings
            font.pointSize: 20
            text: "About us."
            font.family: "Open Sans"
        }
    }
}

