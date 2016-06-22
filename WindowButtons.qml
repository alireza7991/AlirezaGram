import QtQuick 2.5

Item {
    id: root
    width: row.implicitWidth

    property string max_min: ""



    Row {
        id: row
        anchors.centerIn: parent
        spacing: 5

        Rectangle {
            id: btnMinimize
            color: "transparent"
            width: iconMinimize.implicitWidth+5
            height: iconMinimize.implicitHeight+5
            opacity: 0.5

            Text {
                id: iconMinimize
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.family: "Material-Design-Iconic-Font"
                font.pointSize: 15
                text: mi_minimize
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.opacity = 1
                onExited: parent.opacity = 0.5
                onClicked: {
                    appWindow.showMinimized()
                }
            }

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }

        Rectangle {
            id: btnMaxMin
            color: "transparent"
            width: iconMaxMin.implicitWidth+5
            height: iconMaxMin.implicitHeight+5
            opacity: 0.5

            Text {
                id: iconMaxMin
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.family: "Material-Design-Iconic-Font"
                font.pointSize: 15
                text: root.max_min
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.opacity = 1
                onExited: parent.opacity = 0.5
                onClicked: {
                    if(appWindow.visibility==4)
                        appWindow.showNormal()
                    else
                        appWindow.showMaximized()
                }
            }

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }

        Rectangle {
            id: btnExit
            color: "transparent"
            width: iconExit.implicitWidth+5
            height: iconExit.implicitHeight+5
            opacity: 0.5

            Text {
                id: iconExit
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.family: "Material-Design-Iconic-Font"
                font.pointSize: 15
                text: mi_close
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.opacity = 1
                onExited: parent.opacity = 0.5
                onClicked: {
                    appWindow.close()
                }
            }

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }
        }
    }
}
