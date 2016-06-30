import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id: root
    visible: false

    property string username: editUsername.text
    property string password: editPassword.text

    Rectangle {
        id: rectLoginPage
        anchors.fill: parent
        color: "#ffffff"

        Image {
            id: imgLogo
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 10
            }
            height: 250
            width: height
            source: "qrc:/images/iconbig256.png"
        }

        StackView {
            id: stkSignin_Signup
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: imgLogo.bottom
                margins: 20
                topMargin: 30
            }
            initialItem: pageSingin
            width: root.width

            delegate: StackViewDelegate {
                function transitionFinished(properties)
                {
                    properties.exitItem.opacity = 1
                }

                pushTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "opacity"
                        from: 1
                        to: 0
                    }
                }
            }
        }


        Item {
            id: pageSingin
            visible: false
            Text {
                id: txtLogin
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
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
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                height: 40
                width: txtLogin.implicitWidth
                placeholderText: "Enter username"
                validator: RegExpValidator {
                    regExp: /(\.)?[0-9a-zA-Z]*(\.)?[0-9a-zA-Z]*(\_)?[0-9a-zA-Z]*/
                }
                maximumLength: 9

                style: TextFieldStyle {
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
                echoMode: TextInput.Password
                maximumLength: 9
                style: TextFieldStyle {
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
                }

                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
            }

            MButton {
                id: btnSignin
                anchors {
                    top: editPassword.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                height: 35
                bgColor: hlColor
                color: "#ffffff"
                text: "Sgin in"
                fontSize: 11

                onClicked: stkViewMain.push(pageMain)
            }

            Item {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: btnSignin.bottom
                    topMargin: 20
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

                        onClicked: stkSignin_Signup.push(pageSignup)
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

                        onClicked: stkSignin_Signup.push(pageSignup)
                    }
                }
            }
        }

        Item {
            id: pageSignup
            visible: false

            Text {
                id: txtSignup
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                text: "Craete your AlirezaGram account"
                font.family: "Open Sans"
                font.pointSize: 12
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: editName
                anchors {
                    top: txtSignup.bottom
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                height: 40
                width: txtLogin.implicitWidth
                placeholderText: "Enter username"
                validator: RegExpValidator {
                    regExp: /[0-9a-zA-Z]*(\.)?[0-9a-zA-Z]*(\_)?[0-9a-zA-Z]*/
                }
                maximumLength: 9

                style: TextFieldStyle {
                    background: Rectangle {
                        color: (editName.focus) ? "#ffffff" : "#f5f5f5"
                        border.width: 2
                        border.color: (editName.focus) ? "#29cfff" : "#f5f5f5"
                        radius: 5

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "IBeamCursor"
                            onClicked: editName.forceActiveFocus()
                        }

                        Behavior on border.color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }

                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
            }

            Rectangle {
                id: rectNotifName
                anchors {
                    left: editName.right
                    right: parent.right
                    top: editName.top
                    leftMargin: 5
                    rightMargin: 80
                }
                height: txtNotifName.implicitHeight+10
                color: "#b3eaff"
                radius: 5
                visible: editName.focus

                Text {
                    id: txtNotifName
                    anchors.fill: parent
                    anchors.margins: 5
                    text: "You can use ( . , _ ) characters in your username.\n"+
                          "Please use between 4 and 11 characters."
                    font.family: "Open Sans"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
            }

            TextField {
                id: editPass
                anchors {
                    left: editName.left
                    right: editName.right
                    top: editName.bottom
                    topMargin: 10
                }
                height: 40
                placeholderText: "Enter password"
                echoMode: TextInput.Password
                maximumLength: 9
                style: TextFieldStyle {
                    background: Rectangle {
                        color: (editPass.focus) ? "#ffffff" : "#f5f5f5"
                        border.width: 2
                        border.color: (editPass.focus) ? "#29cfff" : "#f5f5f5"
                        radius: 5

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "IBeamCursor"
                            onClicked: editPass.forceActiveFocus()
                        }

                        Behavior on border.color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }

                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
            }

            Rectangle {
                id: rectNotifPass
                anchors {
                    left: editPass.right
                    right: parent.right
                    top: editPass.top
                    leftMargin: 5
                    rightMargin: 80
                }
                height: txtNotifPass.implicitHeight+10
                color: "#b3eaff"
                radius: 5
                visible: editPass.focus

                Text {
                    id: txtNotifPass
                    anchors.fill: parent
                    anchors.margins: 5
                    text: "You can use any characters in your password.\n"+
                          "Please use between 4 and 11 characters."
                    font.family: "Open Sans"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
            }

            TextField {
                id: editConfirmPass
                anchors {
                    left: editPass.left
                    right: editPass.right
                    top: editPass.bottom
                    topMargin: 10
                }
                height: 40
                placeholderText: "Confirm your password"
                echoMode: TextInput.Password
                maximumLength: 9
                style: TextFieldStyle {
                    background: Rectangle {
                        color: (editConfirmPass.focus) ? "#ffffff" : "#f5f5f5"
                        border.width: 2
                        border.color: (editConfirmPass.focus) ? "#29cfff" : "#f5f5f5"
                        radius: 5

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "IBeamCursor"
                            onClicked: editConfirmPass.forceActiveFocus()
                        }

                        Behavior on border.color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                }

                font.family: "Open Sans"
                font.pointSize: 11
                font.weight: Font.DemiBold
            }

            Rectangle {
                id: rectNotifConfirm
                anchors {
                    left: editConfirmPass.right
                    right: parent.right
                    verticalCenter: editConfirmPass.verticalCenter
                    leftMargin: 5
                    rightMargin: 80
                }
                height: txtNotifConfirm.implicitHeight+10
                color: "#ffb3b3"
                radius: 5
                visible: false

                Text {
                    id: txtNotifConfirm
                    anchors.fill: parent
                    anchors.margins: 5
                    text: "These passwords don't match."
                    font.family: "Open Sans"
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }
            }

            MButton {
                id: btnSignup
                anchors {
                    top: editConfirmPass.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                height: 35
                bgColor: hlColor
                color: "#ffffff"
                text: "Sgin up"
                fontSize: 11

                onClicked: {
                    if(editName.length >= 4 && editPass.length >= 4 && editPass.text == editConfirmPass.text)
                        stkViewMain.push(pageMain)
                    else if (editName.length < 4) {
                        rectNotifName.color = "#ffb3b3"
                        editName.forceActiveFocus()
                    } else if (editPass.length < 4) {
                        rectNotifPass.color = "#ffb3b3"
                        editPass.forceActiveFocus()
                    } else if (editPass.text !== editConfirmPass) {
                        rectNotifConfirm.visible = true
                        editConfirmPass.forceActiveFocus()
                    }
                }
            }

            Item {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: btnSignup.bottom
                    topMargin: 10
                }
                height: 30
                Row {
                    anchors.centerIn: parent

                    Text {
                        text: "If you have account click "
                        font.family: "Open Sans"
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    TextLink {
                        text: "here "
                        fontName: "Open Sans"
                        fontSize: 12

                        onClicked: stkSignin_Signup.push(pageSingin)
                    }

                    Text {
                        text: "to "
                        font.family: "Open Sans"
                        font.pointSize: 12
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    TextLink {
                        text: "Sign in"
                        fontName: "Open Sans"
                        fontSize: 12

                        onClicked: stkSignin_Signup.push(pageSingin)
                    }
                }
            }
        }
    }
}
