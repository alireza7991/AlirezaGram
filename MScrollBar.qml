/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

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
    property variant orientation : Qt.Vertical
    property variant flickableItem
    property color bgColor: "#000000"
    property real bgOpacity: 0.2
    property real handleOpacity: 0.3

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
            else if(scrollBar.X > (flickableItem.contentWidth - flickableItem.width))
                scrollBar.contentX = (flickableItem.contentWidth - flickableItem.width)
            if(scrollBar.contentY < 0)
                scrollBar.contentY = 0
            else if(scrollBar.contentY > (flickableItem.contentHeight - flickableItem.height))
                scrollBar.contentY = (flickableItem.contentHeight - flickableItem.height)
            scrollBar.pressed = false
        }
        onMouseYChanged: {
            if(scrollBar.orientation == Qt.Vertical && scrollBar.pressed)
                scrollBar.contentY = (musArea.mouseY / background.height * (flickableItem.contentHeight - flickableItem.height))
            else if (scrollBar.orientation == Qt.Horizontal && scrollBar.pressed)
                scrollBar.contentX = (musArea.mouseX / background.width * (flickableItem.contentWidth - flickableItem.width))
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }
}
