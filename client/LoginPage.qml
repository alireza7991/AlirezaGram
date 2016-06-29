import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Page {
    id: root
    visible: false

    property string username: editUsername.text

    Rectangle {
        id: rectLoginPage
        anchors.fill: parent
        color: "#ffffff"

        Item {
            anchors.centerIn: parent
            width: 400
            height: 300

//            Rectangle {
//                anchors.fill: parent
//                color: "#eeeeee"
//            }

            Text {
                id: txtWelcom
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                text: "Welcom to AlirezaGram"
                font.family: "Open Sans"
                font.pointSize: 14
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter

                Rectangle {
                    id: borderTop
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    height: 1
                    color: "#e0e0e0"
                }
            }

            Text {
                id: txtLogin
                anchors {
                    left: parent.left
                    right: parent.right
                    top: txtWelcom.bottom
                    topMargin: 20
                }
                text: "Please login to your account"
                font.family: "Open Sans"
                font.pointSize: 12
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: editUsername
                anchors {
                    top: txtLogin.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                height: 40
                width: txtLogin.implicitWidth
                placeholderText: "Enter username"
                validator: RegExpValidator {
                    regExp: /[0-9a-zA-Z]*(\.)?[0-9a-zA-Z]*(\_)?[0-9a-zA-Z]*/
                }

                background: Rectangle {
                    color: (editUsername.focus) ? "#ffffff" : "#f5f5f5"
                    border.width: 2
                    border.color: (editUsername.focus) ? "#29cfff" : "#f5f5f5"
                    radius: 5

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: "IBeamCursor"
                        onClicked: editUsername.forceActiveFocus()
                    }

                    Behavior on border.color {
                        ColorAnimation { duration: 200 }
                    }
                }

                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
            }

            TextField {
                id: editPassword
                anchors {
                    left: editUsername.left
                    right: editUsername.right
                    top: editUsername.bottom
                    topMargin: 10
                }
                height: 40
                placeholderText: "Enter password"

                background: Rectangle {
                    color: (editPassword.focus) ? "#ffffff" : "#f5f5f5"
                    border.width: 2
                    border.color: (editPassword.focus) ? "#29cfff" : "#f5f5f5"
                    radius: 5

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: "IBeamCursor"
                        onClicked: editPassword.forceActiveFocus()
                    }

                    Behavior on border.color {
                        ColorAnimation { duration: 200 }
                    }
                }

                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
            }

            MButton {
                id: btnSignIn
                anchors {
                    top: editPassword.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                height: 35
                bgColor: hlColor
                color: "#ffffff"
                text: "Sgin In"
            }

            Rectangle {
                id: borderBottom
                anchors {
                    left: parent.left
                    right: parent.right
                    top: btnSignIn.bottom
                    topMargin: 20
                }
                height: 1
                color: "#e0e0e0"
            }

            Item {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: borderBottom.bottom
                    bottom: parent.bottom
                }
                Row {
                    anchors.centerIn: parent

                    Text {
                        text: "Are you have a account? Click "
                        font.family: "Open Sans"
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    TextLink {
                        text: "here "
                        fontName: "Open Sans"
                        fontSize: 12
                    }

                    Text {
                        text: "to "
                        font.family: "Open Sans"
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    TextLink {
                        text: "Sign up"
                        fontName: "Open Sans"
                        fontSize: 12
                    }
                }
            }
        }
    }
}

