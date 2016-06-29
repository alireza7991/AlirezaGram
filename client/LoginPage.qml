import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Page {
    id: root
    visible: false

    property string username: editUsername.text

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        BorderImage {
            id: bgImage
            anchors.fill: parent
            source: "qrc:/images/blurred.jpg"
            horizontalTileMode: BorderImage.Stretch
            verticalTileMode: BorderImage.Stretch
        }

        StackLayout {
            id: stkUserPass
            anchors.centerIn: parent
            width: 400
            height: 200

            Page {
                anchors.fill: parent
                Rectangle {
                    id: rectLogin
                    anchors.fill: parent
                    width: 400
                    height: 110
                    color: "#335e86"
//                    radius: 10

                    Text {
                        id: txtLogin
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            topMargin: 10
                        }
                        text: "Please login to your account"
                        color: "#e0e0e0"
                        horizontalAlignment: Text.AlignHCenter
                        font.weight: Font.DemiBold
                        font.pointSize: 14
                        font.family: "Open Sans"
                    }

                    Rectangle {
                        id: rectUsername
                        color: "#52799e"
                        anchors.centerIn: parent
                        width: 400
                        height: 110

                        Rectangle {
                            id: rectAccountPic
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }
                            width: 110
                            color: "transparent"

                            Text {
                                id: accountPic
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Material-Design-Iconic-Font"
                                font.pointSize: 80
                                antialiasing: true
                                color: "#ffffff"
                                text: mi_account
                            }
                        }

                        Text {
                            id: txtUsername
                            anchors {
                                left: rectAccountPic.right
                                top: parent.top
                                margins: 20
                                leftMargin: 5
                            }
                            color: "#ffffff"
                            text: "Enter username"
                            font.pointSize: 12
                            font.family: "Open Sans"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Rectangle {
                            id: rectEditUsername
                            anchors {
                                left: rectAccountPic.right
                                top: txtUsername.bottom
                                margins: 10
                                leftMargin: 5
                            }
                            width: 200
                            height: 40
                            radius: 5

                            TextPlain {
                                id: editUsername
                                anchors.fill: parent
                                anchors.margins: 10
                                font.pointSize: 12
                                font.family: "Open Sans"
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: "WordWrap"
                            }
                        }

                        MButton {
                            id: btnNext
                            anchors {
                                left: rectEditUsername.right
                                right: parent.right
                                top: rectEditUsername.top
                                bottom: rectEditUsername.bottom
                                leftMargin: 10
                                rightMargin: 10
                            }
                            text: "Next"
                        }
                    }
                }

                TextLink {
                    id: txtSignUp
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        bottomMargin: 10
                    }
                    text: 'Are you have a account? Click <font color="lightblue">here</font> for sign up'
                    color: "#cccccc"
                    hlColor: "#ffffff"
                    downColor: "#e0e0e0"
                    fontSize: 13
                    fontName: "Open Sans"
                }
            }
        }
    }
}
