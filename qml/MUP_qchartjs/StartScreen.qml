import QtQuick 2.0

Screen {
    id: screen

    Rectangle{
        id: error
        anchors.fill: parent
        color: "#C0FFFFFF"
        z:1
        visible: false

        Column{
            anchors.centerIn: parent
            spacing: 50
            Rectangle{
                radius: 10
                border.color: "gray"
                border.width: 2
                width: error.width/2
                height:error.height/2
                Text {
                    anchors.centerIn: parent
                    width: parent.width-10
                    id: errorText
                    wrapMode: Text.WordWrap
                    font.pixelSize: parent.height*0.1
                    text: qsTr("text błędu")
                }
            }
            Rectangle{
                radius: 10
                border.color: "gray"
                border.width: 2
                width: error.width/2
                height:error.height/5

                Text {
                    anchors.centerIn: parent
                    id: name
                    text: qsTr("Zamknij")
                    font.pixelSize: parent.height*0.5
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        app.enabled=true
                        error.visible=false

                    }
                }
            }
        }
    }

    Rectangle{
        anchors.fill: parent
        id: app
        Rectangle {
            id: logo
            width:parent.width
            height: 3*parent.height / 12
            gradient: Gradient {
                GradientStop { position: 0.0; color: "lightsteelblue" }
                GradientStop { position: 1.0; color: "steelblue" }
            }
            Rectangle
            {
                anchors.centerIn: parent
                color:"transparent"
                height: parent.height-parent.height/5
                width: parent.width/4
                Image {
                    anchors.fill: parent
                    id: imLogo
                    sourceSize.width: 2048
                    sourceSize.height: 2048
                    source: "graphics/logo.svg"
                }
            }



        }

        Rectangle {
            anchors.top : logo.bottom
            id: prediction
            width:parent.width
            height: 8*parent.height / 12

            Column{
                anchors.centerIn: parent
                spacing: 50
                Rectangle {

                    width:prediction.width/2; height:prediction.height/5
                    color: "#A0FFFFFF"
                    radius: 10
                    border.color: "gray"
                    border.width: 2
                    TextInput{
                        id:functionText
                        anchors.centerIn: parent
                        width: parent.width-parent.width/20
                        height: parent.height*0.5
                        font.pixelSize: parent.height*0.5
                        color: "gray"
                        text: "Wpisz adres serwera"
                        onFocusChanged: {
                            color= "black"
                            text= ""
                        }
                    }
                }
                Rectangle{
                    width:prediction.width/2; height:prediction.height/5
                    Rectangle {
                        anchors.right: parent.right
                        width:prediction.width/4; height:prediction.height/5
                        color: "#A0FFFFFF"
                        radius: 10
                        border.color: "gray"
                        border.width: 2
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("Zaloguj")
                            font.pixelSize: parent.height*0.5
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if(functionText.text!="Wpisz adres serwera")
                                {
                                    var component = Qt.createComponent("DrawScreen.qml");
                                    if (component.status == Component.Ready) {
                                        var functionscreen = component.createObject(main);
                                        functionscreen.previousScreen = screen
                                        functionscreen.state = "visible"
                                        functionscreen.connectToServer(functionText.text)
                                        screen.state = "before"
                                    }
                                }
                                else {
                                    errorText.text = "Proszę podać adres serwera!"
                                    error.visible=true
                                    app.enabled=false

                                }
                            }
                        }
                    }
                }


            }
        }

        Rectangle {
            id: footer
            anchors.top:prediction.bottom
            width:parent.width
            height: parent.height / 12
            gradient: Gradient {
                GradientStop { position: 0.0; color: "lightsteelblue" }
                GradientStop { position: 1.0; color: "steelblue" }
            }

        }


    }
}
