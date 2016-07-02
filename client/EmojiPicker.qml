import QtQuick 2.7

Item {
    id: root
    width: gridEmojis.implicitWidth
    height: 300
    visible: false

    property bool hovered: false
    property variant textPlain

    ListModel {
        id: emojiListModel

            ListElement { icon: "a" }
            ListElement { icon: "b" }
            ListElement { icon: "c" }
            ListElement { icon: "d" }
            ListElement { icon: "e" }
            ListElement { icon: "f" }
            ListElement { icon: "g" }
            ListElement { icon: "h" }
            ListElement { icon: "i" }
            ListElement { icon: "j" }
            ListElement { icon: "k" }
            ListElement { icon: "l" }
            ListElement { icon: "m" }
            ListElement { icon: "n" }
            ListElement { icon: "o" }
            ListElement { icon: "p" }
            ListElement { icon: "q" }
            ListElement { icon: "r" }
            ListElement { icon: "s" }
            ListElement { icon: "t" }
            ListElement { icon: "u" }
            ListElement { icon: "v" }
            ListElement { icon: "w" }
            ListElement { icon: "x" }
            ListElement { icon: "y" }
            ListElement { icon: "z" }
            ListElement { icon: "A" }
            ListElement { icon: "B" }
            ListElement { icon: "C" }
            ListElement { icon: "D" }
            ListElement { icon: "E" }
            ListElement { icon: "F" }
            ListElement { icon: "G" }
            ListElement { icon: "H" }
            ListElement { icon: "I" }
            ListElement { icon: "J" }
            ListElement { icon: "K" }
            ListElement { icon: "L" }
            ListElement { icon: "M" }
            ListElement { icon: "N" }
            ListElement { icon: "O" }
            ListElement { icon: "P" }
            ListElement { icon: "Q" }
            ListElement { icon: "R" }
            ListElement { icon: "S" }
            ListElement { icon: "T" }
            ListElement { icon: "U" }
            ListElement { icon: "V" }
            ListElement { icon: "W" }
            ListElement { icon: "X" }
            ListElement { icon: "Y" }
            ListElement { icon: "Z" }
            ListElement { icon: "0" }
            ListElement { icon: "1" }
            ListElement { icon: "2" }
            ListElement { icon: "3" }
            ListElement { icon: "4" }
            ListElement { icon: "5" }
            ListElement { icon: "6" }
            ListElement { icon: "7" }
            ListElement { icon: "8" }
            ListElement { icon: "9" }
    }

    Timer {
        id: visbileTime
        interval: 500
        running: !hovered && !scrollViewEmojis.hovered
        onTriggered: root.visible = false
    }

    Rectangle {
        id: rectPanel
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: root.hovered = true
            onExited: root.hovered = false
        }

        Text {
            id: header
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            height: 30
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#909090"
            font.weight: Font.DemiBold
            font.family: "Open Sans"
            font.pointSize: 9.5
            text: "Default Emojis"
        }

        Text {
            id: footer
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 20
        }


        Flickable {
            id: flickEmojis
            anchors {
                left: parent.left
                right: parent.right
                top: header.bottom
                bottom: footer.top
            }
            contentWidth: gridEmojis.implicitWidth
            contentHeight: gridEmojis.implicitHeight
            clip: true

            property real maxContentY: (emojis.count!=0) ? ((flickEmojis.contentHeight - flickEmojis.height) +
                                                            (emojis.itemAt(emojis.count-1).height + emojis.implicitHeight)) : 0

            contentY: scrollViewEmojis.contentY

            states: State {
                name: "ShowBars"
                when: flickEmojis.movingVertically
                PropertyChanges { target: scrollViewEmojis; opacity: 1 }
            }

            transitions: Transition {
                NumberAnimation { properties: "opacity"; duration: 200 }
            }

            Grid {
                id: gridEmojis
                columns: 7
                padding: 10

                Repeater {
                    id: emojis
                    model: emojiListModel
                    visible: false

                    Rectangle {
                        width: 50
                        height: 50
                        clip: true
                        color: "#ffffff"
                        z:100

                        Text {
                            id: emoji
                            anchors.centerIn: parent
                            width: 30
                            height: 30
                            color: "#4389d9"
                            font.family: "Emoticons"
                            font.pointSize: 25
                            text: icon
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "PointingHandCursor"

                            onClicked: {
                                textPlain.insert(textPlain.cursorPosition, " <p style=\"font-family:'Emoticons'; font-size:30px; color:"+emoji.color+";\">"+icon+"</p> ")
                            }
                            onEntered: {
                                root.hovered = true
                                parent.color = "#e8f2ff"
                            }
                            onExited: {
                                root.hovered = false
                                parent.color = "#ffffff"
                            }
                        }

                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }
                }
            }
        }

        MScrollBar {
            id: scrollViewEmojis
            width: 5;
            height: flickEmojis.height - 5
            anchors.top: header.bottom
            anchors.right: parent.right
            flickableItem: flickEmojis
            anchors.rightMargin: 2
            bgColor: "#1955a4"
            bgOpacity: 0.3
            handleOpacity: 0.7
            opacity: 0
            orientation: Qt.Vertical
            position: flickEmojis.visibleArea.yPosition
            pageSize: flickEmojis.visibleArea.heightRatio
            clip: true
            visible: (flickEmojis.contentHeight > root.height) ? true : false
            z:100
        }
    }
}
