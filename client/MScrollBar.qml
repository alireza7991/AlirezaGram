import QtQuick 2.7

Item {
    id: scrollBar

    // The properties that define the scrollbar's state.
    // position and pageSize are in the range 0.0 - 1.0.  They are relative to the
    // height of the page, i.e. a pageSize of 0.5 means that you can see 50%
    // of the height of the view.
    // orientation can be either Qt.Vertical or Qt.Horizontal

    property bool pressed: false
    property bool hovered: false
    property real position
    property real contentY: 0
    property real contentX: 0
    property real pageSize
    property int orientation : Qt.Vertical
    property Flickable flickableItem
    property color bgColor: "#000000"
    property real bgOpacity: 0.2
    property real handleOpacity: 0.3

    onContentYChanged: {
        if(!pressed){
            if(scrollBar.contentY < 0)
                scrollBar.contentY = 0
            if(scrollBar.contentY > (flickableItem.contentHeight - flickableItem.height))
                scrollBar.contentY = (flickableItem.contentHeight - flickableItem.height)
        }
    }

    onContentXChanged: {
        if(!pressed){
            if(scrollBar.contentX < 0)
                scrollBar.contentX = 0
            if(scrollBar.X > (flickableItem.contentWidth - flickableItem.width))
                scrollBar.contentX = (flickableItem.contentWidth - flickableItem.width)
        }
    }

    // A light, semi-transparent background
    Rectangle {
        id: background
        anchors.fill: parent
        color: scrollBar.bgColor
        opacity: bgOpacity
    }

    // Size the bar to the required size, depending upon the orientation.
    Rectangle {
        id: handle
        x: orientation == Qt.Vertical ? 1 : (scrollBar.position * (scrollBar.width-2) + 1)
        y: orientation == Qt.Vertical ? (scrollBar.position * (scrollBar.height-2) + 1) : 1
        width: orientation == Qt.Vertical ? (parent.width-2) : (scrollBar.pageSize * (scrollBar.width-2))
        height: orientation == Qt.Vertical ? (scrollBar.pageSize * (scrollBar.height-2)) : (parent.height-2)
        color: scrollBar.bgColor
        opacity: handleOpacity
    }

    Behavior on contentY {
        NumberAnimation { duration: 100 }
    }

    Behavior on contentX {
        NumberAnimation { duration: 100 }
    }

    MouseArea {
        id: musArea
        anchors.fill: scrollBar
        hoverEnabled: true

        onEntered: {
            scrollBar.hovered = true
            scrollBar.opacity = 1
        }
        onExited: {
            if(!scrollBar.pressed)
                scrollBar.opacity = 0
            scrollBar.hovered = false
        }
        onPressed: {
            if(scrollBar.orientation == Qt.Vertical)
                scrollBar.contentY = (musArea.mouseY / background.height * (flickableItem.contentHeight - flickableItem.height))
            if(scrollBar.orientation == Qt.Horizontal)
                scrollBar.contentX = (musArea.mouseX / background.width * (flickableItem.contentWidth - flickableItem.width))
            scrollBar.pressed = true
        }
        onReleased: {
            if(!scrollBar.hovered){
                scrollBar.opacity = 0
            }
            if(scrollBar.contentX < 0)
                scrollBar.contentX = 0
            if(scrollBar.X > (flickableItem.contentWidth - flickableItem.width))
                scrollBar.contentX = (flickableItem.contentWidth - flickableItem.width)
            if(scrollBar.contentY < 0)
                scrollBar.contentY = 0
            if(scrollBar.contentY > (flickableItem.contentHeight - flickableItem.height))
                scrollBar.contentY = (flickableItem.contentHeight - flickableItem.height)
            scrollBar.pressed = false
        }
        onMouseYChanged: {
            if(scrollBar.orientation == Qt.Vertical && scrollBar.pressed) {
                scrollBar.contentY = (musArea.mouseY / background.height * (flickableItem.contentHeight - flickableItem.height))
            }
            else if (scrollBar.orientation == Qt.Horizontal && scrollBar.pressed)
                scrollBar.contentX = (musArea.mouseX / background.width * (flickableItem.contentWidth - flickableItem.width))
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }
}
