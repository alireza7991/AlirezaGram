import QtQuick 2.5

Item {
    id: root

    property string iconChervon: mi_chevron_right

    opacity: 0.5

    Rectangle {
        id: btn
        color: "transparent"

        Text {
            id: txtBtn
            anchors.fill: parent
            font.pointSize: 25
            color: "#a0a0a0"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: root.iconChervon
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }
}

