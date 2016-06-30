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

        Image {
            id: rectLogo
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: txtLogin.top
                margins: 70
                bottomMargin: 30
            }
            width: height
            source: "qrc:/images/iconbig256.png"
        }

        Text {
            id: txtWelcom
            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            text: "Welcom to AlirezaGram"
            font.family: "Open Sans"
            font.pointSize: 14
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            visible: false
        }

        Rectangle {
            id: borderTop
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: txtWelcom.bottom
            }
            width: 300
            height: 1
            z:1
            color: "#e0e0e0"
            visible: false
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
                regExp: /(\.)?[0-9a-zA-Z]*(\.)?[0-9a-zA-Z]*(\_)?[0-9a-zA-Z]*/
            }
            maximumLength: 9

            onTextChanged: changed = true

            property bool changed: false



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
            echoMode: "Password"
            maximumLength: 9

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
            fontSize: 11

            onClicked: stkViewMain.push(pageMain)
        }

        Rectangle {
            id: borderBottom
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: btnSignIn.bottom
                topMargin: 20
            }
            width: 300
            height: 1
            color: "#e0e0e0"
            visible: false
        }

        Item {
            anchors {
                left: parent.left
                right: parent.right
                top: borderBottom.bottom
            }
            height: 30
            Row {
                anchors.centerIn: parent

                Text {
                    text: "Don't you have an account? Click "
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
