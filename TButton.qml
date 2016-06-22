import QtQuick 2.5

Item {
    id: root
    width: btnText.implicitWidth+15
    height: 30

    // Properteis
    property color color: "#ffffff"
    property color bgColor: "transparent"
    property color downColor: "#f0f0b0"
    property color disableColor: "#424242"
    property string caption: "TButton"
    property int fontSize: 10

    // Signals
    signal clicked()
    signal pressed()
    signal released()
    signal entered()
    signal exited()

    Rectangle {
        id: btn
        anchors.fill: root
        color: root.bgColor

        Text {
            id: btnText
            anchors.centerIn: btn
            font.family: "Open Sans"
            font.pointSize: root.fontSize
            color: root.color
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: root.caption
            opacity: 0.7

            Behavior on opacity {
                NumberAnimation { duration: 100 }
            }
            Behavior on scale {
                NumberAnimation { duration: 50 }
            }
        }
    }

    MouseArea {
        id: musArea
        anchors.fill: root
        hoverEnabled: true
        onClicked: root.clicked()
        onEntered: {
            root.entered()
            btnText.opacity = 1
        }
        onExited: {
            root.exited();
            btnText.opacity = 0.7
        }
        onPressed: {
            root.pressed()
            btnText.scale = 0.9
        }
        onReleased: {
            root.released()
            btnText.scale = 1
        }
    }
}

