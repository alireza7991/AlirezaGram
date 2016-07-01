import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: appWindow
    // @disable-check M16
    visible: true

    // @disable-check M16
    width: 800
    // @disable-check M16
    height: 600

    // @disable-check M16
    minimumHeight: 500
    // @disable-check M16
    minimumWidth: 600

    background: BorderImage {
        id: bgImage
        source: "qrc:/images/blurred.jpg"
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
    }

    // @disable-check M16
    flags: Qt.FramelessWindowHint || Qt.Window
    // @disable-check M16
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
        color: "#52799e"

        Rectangle {
            id: icon
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 8.5
            }
            width: 22.5
            color: "#26669e"
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
                id: tbtnCantacts
                height: parent.height
                caption: "Contacts"
            }
            TButton {
                id: tbtnAbout
                height: parent.height
                caption: "About"

                onClicked: {
                    rectFocus.itemFocus = rectAbout
                    rectFocus.show()
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
            property point clickPos: "1,1"

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
        initialItem: pageLogin
    }

    LoginPage {
        id: pageLogin
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
                    onClicked: editSearch.forceActiveFocus()
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
                width: 35
                color: editSearch.bgColor

                Text {
                    anchors.centerIn: parent
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

            TextField {
                id: editSearch
                anchors {
                    left: iconSearch.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 12
                    leftMargin: 0
                }
                placeholderText: "Search"
                font.family: "Open Sans"
                font.pointSize: 10
                property color bgColor: "#f0f0f0"
                clip: true
                renderType: Text.QtRendering

                background: Rectangle {
                    id: rectEditSearchStyle
                    color: editSearch.bgColor
                }

                onFocusChanged: {
                    if(editSearch.focus){
                        editSearch.bgColor = "#ffffff"
                        rectSearchBox.borderColor = "#4ab7ee"
                    } else {
                        editSearch.bgColor = "#f0f0f0"
                        rectSearchBox.borderColor = "#f0f0f0"
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

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height/3
                text: "List is empty"
                font.family: "Open Sans"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                color: "#b0b0b0"
                font.pointSize: 12
                visible: (listModelChatList.count) ? false : true
            }

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

                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: true }
                        ListElement { title: "Test Chat List Button "; text: "Test Chat List Button "; isSelf: false}
                    }

                    Column {
                        id: columnListChat
                        anchors.fill: parent

                        Repeater {
                            id: listViewChatList
                            model: listModelChatList
                            delegate: ListButton {
                                width: parent.width
                                caption: title + index
                                lastText: text + index
                                lastTime: (listModelMessages.count) ? listViewMessages.itemAt(0).pmTime : "00:00"
                                newMessage: index+1
                                self: isSelf
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
            id: rectMessagePage
            anchors {
                left: rectSearchBox.right
                right: parent.right
                top: parent.top
                topMargin: -0.1
                bottom: parent.bottom
            }
            color: "transparent"
            clip: true

            Rectangle {
                id: rectProfileTitle
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    leftMargin: 0.5
                }
                height: 54.5
                visible: (listModelMessages.count) ? true : false
                z:1

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
                    height: 1
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
            }

            Rectangle {
                id: rectMessageBox
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    leftMargin: 0.5
                }
                height: 46
                visible: (listModelMessages.count) ? true : false
                z:1

                property real maxHeight: 200

                function sendSticker(sticker, self) {
                    listModelMessages.insert(listViewMessages.count,{text:sticker, isSelf: self, time: Qt.formatDateTime(new Date(), "hh:mm"), isSticker: true})
                    if(listModelChatList.count) listViewChatList.itemAt(0).lastTime = Qt.formatDateTime(new Date(), "hh:mm")
                    if (scrollViewMessages.contentY < flickListMessages.maxContentY){
                        scrollViewMessages.contentY = flickListMessages.maxContentY
                    }
                }

                function sendMessage(text, self, isSticker) {
                    while(editMessageBox.getText(0,1)===" " || editMessageBox.getText(0,1)==="	")
                        editMessageBox.remove(0,1)
                    if(!editMessageBox.isEmpty) {
                        listModelMessages.insert(listViewMessages.count,{text:text, isSelf: self, time: Qt.formatDateTime(new Date(), "hh:mm"), isSticker: isSticker})
                        editMessageBox.text = ""
                        if(listModelChatList.count) listViewChatList.itemAt(0).lastTime = Qt.formatDateTime(new Date(), "hh:mm")
                        if (scrollViewMessages.contentY < flickListMessages.maxContentY){
                            scrollViewMessages.contentY = flickListMessages.maxContentY
                        }
                    }
                }

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
                        bottom: parent.bottom
                        topMargin: 1
                    }
                    height: 45
                    width: 40
                    itemFocus: editMessageBox

                    onClicked: {
                        rectMessageBox.sendMessage(editMessageBox.text, true, false);
                    }
                }

                SFaceButton {
                    id: btnFaceSticker
                    anchors {
                        right: btnSend.left
                        bottom: parent.bottom
                    }
                    height: 45
                    width: 40

                    onEntered: {
                        if(emojiPicker.visible) emojiPicker.visible = false
                        stickerPicker.visible = true
                        stickerPicker.hovered = true
                    }

                    onExited: {
                        stickerPicker.hovered = false
                    }
                }

                Rectangle {
                    id: rectEmoji
                    anchors {
                        right: btnFaceSticker.left
                        bottom: parent.bottom
                    }
                    width: 40
                    height: 45

                    Text {
                        id: iconEmoji
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Material-Design-Iconic-Font"
                        font.pointSize: 20
                        color: "#c0c0c0"
                        text: mi_emoji

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered:{
                                if(stickerPicker.visible) stickerPicker.visible = false
                                emojiPicker.visible = true
                                emojiPicker.hovered = true
                            }
                            onExited: {
                                emojiPicker.hovered = false
                            }
                        }
                    }
                }

                WebCamButton {
                    id: webCameraButton
                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                        leftMargin: 1
                    }
                    height: 45
                    width: 40

                    onClicked: {
                        rectFocus.itemFocus = rectVideoChat
                        rectFocus.show()
                    }
                }

                Rectangle {
                    id: rectEditMessageBox
                    anchors {
                        left: webCameraButton.right
                        right: rectEmoji.left
                        top: parent.top
                        bottom: parent.bottom
                        margins: 10
                        leftMargin: 0
                        rightMargin: 0
                    }

                    MouseArea {
                        anchors.fill: editMessageBox
                        hoverEnabled: true
                        cursorShape: "IBeamCursor"

                        onClicked: editMessageBox.forceActiveFocus()
                    }

                    TextPlain {
                        id: editMessageBox
                        anchors.fill: parent
                        font.family: "Open Sans"
                        font.pointSize: 9.5
                        placeholderText: " Write a message..."
                        z:1

                        onTextChanged: (editMessageBox.implicitHeight+15 < 45) ? rectMessageBox.height = 46 : (editMessageBox.implicitHeight+15 < 250) ? rectMessageBox.height = editMessageBox.implicitHeight+15 : 250

                        Keys.onReturnPressed: {
                            rectMessageBox.sendMessage(editMessageBox.text, true, false);
                        }
                    }
                }
            }

            EmojiPicker {
                id: emojiPicker
                anchors {
                    right: parent.right
                    bottom: rectMessageBox.top
                    bottomMargin: 10
                    rightMargin: 10
                }
                textPlain: editMessageBox
                z:1
            }

            StickerPicker {
                id: stickerPicker
                anchors {
                    right: parent.right
                    bottom: rectMessageBox.top
                    bottomMargin: 10
                    rightMargin: 10
                }
                sendTo: rectMessageBox
                z:1
            }

            ListModel {
                id: listModelMessages

                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: true ; isSticker: false}
                ListElement { text: "Test Message Bubble "; isSelf: false; isSticker: false}
            }

            Flickable {
                id: flickListMessages
                anchors {
                    left: parent.left
                    right: parent.right
                    top: rectProfileTitle.bottom
                    bottom: rectMessageBox.top
                }
                contentWidth: columnListMessages.implicitWidth
                contentHeight: columnListMessages.implicitHeight
                clip: true

                property real maxContentY: (listViewMessages.count!=0) ? (flickListMessages.contentHeight - flickListMessages.height)  : 0

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
                                left: if(!isSelf) listViewMessages.left
                                right: if(isSelf) listViewMessages.right
                                margins: 15
                                bottomMargin: 10
                            }
                            self: isSelf
                            sticker: isSticker
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
                anchors {
                    right: parent.right
                    top: rectProfileTitle.bottom
                    bottom: rectMessageBox.top
                    margins: 5
                }
                width: 7
                flickableItem: flickListMessages
                anchors.rightMargin: 2
                bgColor: "lightblue"
                bgOpacity: 0.3
                handleOpacity: 1
                opacity: 0
                orientation: Qt.Vertical
                position: flickListMessages.visibleArea.yPosition
                pageSize: flickListMessages.visibleArea.heightRatio
                clip: true
                contentY: (flickListMessages.contentHeight > rectMessagePage.height) ? flickListMessages.maxContentY : 0
                visible: (flickListMessages.contentHeight > rectMessagePage.height) ? true : false
            }
        }
    }

    Rectangle {
        id: rectFocus
        anchors.fill: parent
        color: "#000000"
        opacity: 0
        visible: opacity > 0
        z:1

        property variant itemFocus

        function show(){
            rectFocus.opacity = 0.5
            itemFocus.opacity = 1
        }

        function close(){
            itemFocus.opacity = 0
            rectFocus.opacity = 0
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                rectFocus.close()
            }
        }
    }

    Rectangle {
        id: rectAbout
        anchors.centerIn: parent
        width: 400
        height: 300
        visible: opacity > 0
        opacity: 0
        color: "#ffffff"
        radius: 5
        z:1

        Text {
            id: txtAppName
            anchors {
                left: parent.left
                top: parent.top
                margins: 30
            }
            font.family: "Open Sans"
            font.pointSize: 11
            font.weight: Font.DemiBold
            text: "AlirezaGarm Desktop"
        }

        Text {
            id: txtAppVersion
            anchors {
                left: txtAppName.left
                top: txtAppName.bottom
                topMargin: 5
            }
            color: "#a0a0a0"
            font.family: "Open Sans"
            font.pointSize: 9.5
            text: "version 0.10.0.0"
        }

        Text {
            id: txtAppInfo
            anchors {
                left: txtAppName.left
                top: txtAppVersion.bottom
                right: parent.right
                rightMargin: 30
                topMargin: 20
            }
            font.family: "Open Sans"
            font.pointSize: 9.5
            lineHeight: 1.3
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "Official free messaging app based on AlirezaGram API for speed and security"
        }

        Text {
            id: txtAppLicense
            anchors {
                left: txtAppName.left
                top: txtAppInfo.bottom
                right: parent.right
                rightMargin: 30
                topMargin: 20
            }
            font.family: "Open Sans"
            font.pointSize: 9.5
            lineHeight: 1.3
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "This software is licensed under GNU GPL version 3.\n"+
                  "Source code available on GitHub."
        }

        Text {
            id: txtEnjoy
            anchors {
                left: txtAppName.left
                top: txtAppLicense.bottom
                topMargin: 20
                rightMargin: 30
            }
            font.family: "Open Sans"
            font.pointSize: 9.5
            lineHeight: 1.3
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "I hope you enjoy from AlirezaGram."
        }

        Rectangle {
            id: btnAboutClose
            anchors {
                right: parent.right
                bottom: parent.bottom
                margins: 20
            }
            width: txtClose.implicitWidth + 15
            height: txtClose.implicitHeight + 15
            color: "#ffffff"
            radius: 3
            z:1

            Text {
                id: txtClose
                anchors.centerIn: parent
                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#2196F3"
                text: "CLOSE"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: "PointingHandCursor"

                onEntered: {
                    btnAboutClose.color = "#dfefff"
                }
                onExited: {
                    btnAboutClose.color = "#ffffff"
                }
                onClicked: rectFocus.close()
            }

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }

        MouseArea {
            anchors.fill: parent
        }
    }

    Rectangle {
        id: rectVideoChat
        anchors.fill: rectFocus
        anchors.margins: 150
        color: "#000000"
        radius: 10
        opacity: 0
        visible: opacity > 0
        z:10

        Text {
            id: iconClose
            anchors {
                right: parent.right
                top: parent.top
                margins: 10
                rightMargin: iconClose.implicitWidth
            }
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
            opacity: 0.7
            font.family: "Material-Design-Iconic-Font"
            font.pointSize: 20
            text: mi_close
            z:1

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: "PointingHandCursor"
                onEntered: parent.opacity = 1
                onExited: parent.opacity = 0.7
                onPressed: parent.scale = 0.9
                onReleased: parent.scale = 1
                onClicked: {
                    rectFocus.close()
                }
            }
        }

        MouseArea {
            anchors.fill: parent
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }

    Rectangle {
        id: pageSettings
        color: "transparent"
        visible: false

        Text {
            anchors.centerIn: pageSettings
            font.pointSize: 20
            text: "Settings."
            font.family: "Open Sans"
        }
    }
}

