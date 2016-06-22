import QtQuick 2.5

Item {
    id: root
    width: parent.width
    height: 62.5

    // Properteis
    property color color: "#000000"
    property color bgPicColor: "#223ea4"
    property color bgColor: "transparent"
    property color highlightColor: "#f0f0f0"
    property color downColor: "#3083cf"
    property color disableColor: "#424242"
    property string caption: "List Button"
    property string lastText: "You have a new message!1234567891011121314151617181920"
    property string lastTime: Qt.formatDateTime(new Date(),"hh:mm")
    property int newMessage: 50
    property bool notifications: true
    property bool checked: false
    property bool self: false
    property string senderName:  ""

    onCheckedChanged: {
        if(!root.checked) {
            txtSender.color = "#2196F3"
            rectNotifications.color = "#2196F3"
            txtNotifications.color = "#ffffff"
            txtLast.color = "#a0a0a0"
            txtCaption.color = "#000000"
            txtTime.color = "#a0a0a0"
            btn.color = root.bgColor
        }
    }

    // Signals
    signal clicked()
    signal pressed()
    signal released()
    signal entered()
    signal exited()

    Rectangle {
        id: btn
        color: root.bgColor
        anchors.fill: root

        Rectangle {
            id: pic
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: 7.5
            }
            width: 48.5
            color: root.bgPicColor
            radius: 50

            Text {
                id: icon
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Material-Design-Iconic-Font"
                font.pointSize: 35
                color: "#ffffff"
                text: mi_account
            }
        }

        Text {
            id: txtCaption
            anchors {
                left: pic.right
                right: parent.right
                top: parent.top
                margins: 10
            }
            height: 20
            color: root.color
            text: root.caption
            font.weight: Font.DemiBold
            font.pointSize: 10
            font.family: "Open Sans"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight

        }

        TextMetrics {
            id: txtMSender
            text: root.self ? "You: " : root.senderName
            elide: Text.ElideRight
            elideWidth: root.width / 4
        }

        Text {
            id: txtSender
            anchors {
                left: pic.right
                top: txtCaption.top
                leftMargin: 10
                topMargin: 25
            }
            color: "#2196F3"
            font.family: "Open Sans"
            font.pointSize: 9
            verticalAlignment: Text.AlignVCenter
            text: root.self ? txtMSender.elidedText : ""
        }

        TextMetrics {
            id: txtMLast
            text: root.lastText
            elide: Text.ElideRight
            elideWidth: root.width - txtLast.x-txtNotifications.implicitWidth
        }

        Text {
            id: txtLast
            anchors {
                left: txtSender.right
                right: rectNotifications.left
                top: txtCaption.top
                topMargin: 25
                rightMargin: 5
            }
            text: txtMLast.elidedText
            font.pointSize: 9
            color: "#808080"
            font.family: "Open Sans"
            verticalAlignment: Text.AlignVCenter
            clip:true
        }

        Rectangle {
            id: rectNotifications
            anchors {
                right: parent.right
                bottom: parent.bottom
                margins: 10
            }
            width: txtNotifications.implicitWidth+12
            height: txtNotifications.implicitHeight+2
            color: "#2196F3"
            radius: 20

            Text {
                id: txtNotifications
                anchors.centerIn: rectNotifications
                font.pointSize: 9
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.bold: true
                font.family: "Open Sans"
                text: root.newMessage
            }
        }

        Text {
            id: txtTime
            anchors {
                right: parent.right
                top: parent.top
                margins: 10
                topMargin: 10
            }
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 9
            color: "#a0a0a0"
            text: root.lastTime
        }
    }

    MouseArea {
        id: musArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: if(!root.checked) btn.color = root.highlightColor
        onExited: {
            if(!root.checked) {
                txtSender.color = "#2196F3"
                txtLast.color = "#a0a0a0"
                txtCaption.color = "#000000"
                txtTime.color = "#a0a0a0"
                btn.color = root.bgColor
            }
        }
        onPressed: {
            root.pressed()
            txtLast.color = "#ffffff"
            txtSender.color = "#ffffff"
            txtCaption.color = "#ffffff"
            txtTime.color = "#ffffff"
            rectNotifications.color = "#ffffff"
            txtNotifications.color = "#2196F3"
            btn.color = root.downColor
        }
    }
}

