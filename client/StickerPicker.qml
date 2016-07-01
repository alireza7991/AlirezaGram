import QtQuick 2.7
import Qt.labs.folderlistmodel 2.1

Item {
    id: root
    width: gridStickrs.implicitWidth
    height: 300
    visible: true

    property bool hovered: false
    property variant sendTo

    FolderListModel {
        id: folderModel
        nameFilters: ['*.png']
        sortField: FolderListModel.Name
        folder: "stickers/"
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
            text: "Default Stickers"
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
            id: flickStickers
            anchors {
                left: parent.left
                right: parent.right
                top: header.bottom
                bottom: footer.top
            }
            contentWidth: gridStickrs.implicitWidth
            contentHeight: gridStickrs.implicitHeight
            clip: true

            property real maxContentY: (stickers.count!=0) ? ((flickStickers.contentHeight - flickStickers.height) +
                                                            (stickers.itemAt(stickers.count-1).height + stickers.implicitHeight)) : 0

            contentY: scrollViewEmojis.contentY

            states: State {
                name: "ShowBars"
                when: flickStickers.movingVertically
                PropertyChanges { target: scrollViewEmojis; opacity: 1 }
            }

            transitions: Transition {
                NumberAnimation { properties: "opacity"; duration: 200 }
            }

            Grid {
                id: gridStickrs
                columns: 5
                padding: 10
                rightPadding: 15

                Repeater {
                    id: stickers
                    model: folderModel

                    Rectangle {
                        width: 80
                        height: 80
                        clip: true
                        color: "#ffffff"
                        z:1

                        Image {
                            anchors.centerIn: parent
                            width: 60
                            height: 60
                            source: folderModel.folder+fileName
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "PointingHandCursor"

                            onClicked: {
                                sendTo.sendSticker("<img src=\""+folderModel.folder+fileName+"\" width=256 height: 256/>", true)
                                root.visible = false
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
            height: flickStickers.height - 5
            anchors.top: header.bottom
            anchors.right: parent.right
            anchors.rightMargin: 5
            flickableItem: flickStickers
            bgColor: "#1955a4"
            bgOpacity: 0.3
            handleOpacity: 0.7
            opacity: 0
            orientation: Qt.Vertical
            position: flickStickers.visibleArea.yPosition
            pageSize: flickStickers.visibleArea.heightRatio
            clip: true
            visible: (flickStickers.contentHeight > root.height) ? true : false
            z:100
        }
    }
}
