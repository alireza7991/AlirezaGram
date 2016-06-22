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

        Quick1.ScrollView {
            anchors {
                left: parent.left
                right: rectSearchBox.right
                top: rectSearchBox.bottom
            }
            height: columnListChat.implicitHeight
            horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

            __wheelAreaScrollSpeed: 60

            style: scrollStyle

            Rectangle {
                id: rectList
                width: pageMain.listWidth
                height: pageMain.height - parent.y
                color: "#ffffff"

                property ListButton lastButton;
                property bool checked: false

                //                    ListModel {
                //                        id: listModelChatList

                //                        ListElement { title: "Test Chat List Button 1"; text: "Test Chat List Button 1"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 2"; text: "Test Chat List Button 2"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 3"; text: "Test Chat List Button 3"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 4"; text: "Test Chat List Button 4"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 5"; text: "Test Chat List Button 5"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 6"; text: "Test Chat List Button 6"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 7"; text: "Test Chat List Button 7"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 8"; text: "Test Chat List Button 8"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 9"; text: "Test Chat List Button 9"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 10"; text: "Test Chat List Button 10"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 11"; text: "Test Chat List Button 11"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 12"; text: "Test Chat List Button 12"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 13"; text: "Test Chat List Button 13"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 14"; text: "Test Chat List Button 14"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 15"; text: "Test Chat List Button 15"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 16"; text: "Test Chat List Button 4"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 17"; text: "Test Chat List Button 5"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 18"; text: "Test Chat List Button 6"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 19"; text: "Test Chat List Button 7"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 20"; text: "Test Chat List Button 8"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 21"; text: "Test Chat List Button 9"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 22"; text: "Test Chat List Button 10"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 23"; text: "Test Chat List Button 11"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 24"; text: "Test Chat List Button 12"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 25"; text: "Test Chat List Button 13"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 26"; text: "Test Chat List Button 14"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 27"; text: "Test Chat List Button 15"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 28"; text: "Test Chat List Button 4"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 29"; text: "Test Chat List Button 5"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 30"; text: "Test Chat List Button 6"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 31"; text: "Test Chat List Button 7"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 32"; text: "Test Chat List Button 8"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 33"; text: "Test Chat List Button 9"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 34"; text: "Test Chat List Button 10"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 35"; text: "Test Chat List Button 11"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 36"; text: "Test Chat List Button 12"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 37"; text: "Test Chat List Button 13"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 38"; text: "Test Chat List Button 14"; time: "00:00" }
                //                        ListElement { title: "Test Chat List Button 39"; text: "Test Chat List Button 15"; time: "00:00" }
                //                    }

                Column {
                    id: columnListChat

                    Repeater {
                        id: listViewChatList
                        model: 100//listModelChatList
                        delegate: ListButton {
                            width: parent.width
                            caption: "test"//title
                            lastText: "test"//text
                            lastTime: "00:00"//listModelMessages.get(0).time
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
                width: 60
                text: "Send"

                onClicked: {
                    while(editMessageBox.getText(0,1)==" ")
                        editMessageBox.remove(0,1)
                    if(editMessageBox.text!="") {
                        listModelMessages.insert(listViewMessages.count,{text:editMessageBox.text, anchor:"Right", time: Qt.formatDateTime(new Date(), "hh:mm")})
                        editMessageBox.text = ""
                    }
                }
            }


            Rectangle {
                id: rectEmoji
                anchors {
                    right: btnSend.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 10
                    rightMargin: 0
                }
                width: 40
                color: "transparent"

                Text {
                    id: iconEmoji
                    anchors.centerIn: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    font.family: "Material-Design-Iconic-Font"
                    color: "#c0c0c0"
                    text: mi_emoji
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: "PointingHandCursor"
                }
            }

            Rectangle {
                id: rectEditMessageBox
                anchors {
                    left: parent.left
                    right: rectEmoji.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: 10
                }

                Rectangle {
                    id: rectComments
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: 40
                    color: "transparent"

                    Text {
                        id: iconComments
                        anchors.centerIn: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 20
                        font.family: "Material-Design-Iconic-Font"
                        color: editMessageBox.focus ? "#2991d1" : "#c0c0c0"
                        text: mi_comments

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }

                Quick1.TextField {
                    id: editMessageBox
                    anchors {
                        left: rectComments.right
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                    }
                    font.family: "Open Sans"
                    font.pointSize: 11
                    placeholderText: " Write a message..."

                    z:1

                    Keys.onReturnPressed: {
                        while(editMessageBox.getText(0,1)==" ")
                            editMessageBox.remove(0,1)
                        if(editMessageBox.text!="") {
                            listModelMessages.insert(0,{text:editMessageBox.text, anchor:"Right", time: Qt.formatDateTime(new Date(), "hh:mm")})
                            editMessageBox.text = ""
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

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: "IBeamCursor"
                    onClicked: editMessageBox.forceActiveFocus()
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

            //            EditPlain {
            //                anchors.centerIn: parent
            //            }

            ListModel {
                id: listModelMessages

                ListElement { text: "Send me a message..."; anchor: "Left"; time: "00:00"}
            }

            ListView {
                id: listViewMessages
                anchors.fill: parent
                model: listModelMessages
                spacing: 15
                keyNavigationWraps: true
                header: Text { height: 20 }
                footer: Text { height: 20 }
                verticalLayoutDirection: ItemView.BottomToTop


                delegate: MessageBubble {
                    anchors {
                        left: if(anchor=="Left") parent.left
                        right: if(anchor=="Right") parent.right
                        margins: 15
                        bottomMargin: 10
                    }
                    self: (anchor=="Right")? true : false
                    pmText: text
                }
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

    Component {
        id: scrollStyle
        ScrollViewStyle {
            transientScrollBars: true
            handle: Item {
                implicitWidth: 5
                implicitHeight: 5
                Rectangle {
                    id: rectScrollStyle
                    color: "#2991d1"
                    anchors.fill: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: rectScrollStyle.opacity = 1
                    onExited: rectScrollStyle.opacity = 0.5
                }
            }
            scrollBarBackground: Item {
                implicitWidth: 5
                implicitHeight: 5

                Rectangle {
                    anchors.fill: parent
                    color: "#2991d1"
                    opacity: 0.2
                }
            }
            minimumHandleLength: 70
        }
    }
}

