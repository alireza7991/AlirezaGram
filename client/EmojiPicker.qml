import QtQuick 2.7
import Qt.labs.folderlistmodel 2.1

Item {
    id: root
    width: gridEmojis.implicitWidth
    height: 300

    property bool hovered: false

    FolderListModel {
        id: folderModel
        nameFilters: ['*.svg']
        sortField: FolderListModel.Name
        folder: "emojis/"
    }

    Timer {
        id: visbileTime
        interval: 1000
        running: !hovered
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
                    model: folderModel

                    Rectangle {
                        width: 50
                        height: 50
                        clip: true
                        color: "#ffffff"

                        Image {
                            anchors.centerIn: parent
                            width: 30
                            height: 30
                            source: folderModel.folder+fileName
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "PointingHandCursor"

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
