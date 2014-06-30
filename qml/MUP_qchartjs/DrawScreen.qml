import QtQuick 2.0

import "qchart.js/QChart.js"        as Charts
import "dataModeler.js" as ChartsData

import "qchart.js/."

import mupServerHandle 1.0

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
                        previousScreen.state = "visible"
                        screen.state = "after"

                    }
                }
            }
        }
    }

    Rectangle
    {
        id:app
        anchors.fill: parent

    Rectangle{
        id: menu
        width: parent.width/5
        height: parent.height
        opacity: 0.0
        x : - parent.width/5
        color: "#D0FFFFFF"
        visible: true
        z: 1

        Column{
    anchors.centerIn: parent
    spacing: 50
            Rectangle {

                width:menu.width*0.75; height:width
                radius: 10
                color: "transparent"
                Image {
                    id: clearChart
                    source: "graphics/clearChart_black_transparent.svg"
                    anchors.fill: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        ChartsData.clearData()


                    }
                    onEntered:
                    {
                        clearChart.source="graphics/clearChart_black.svg"
                    }
                    onExited: {
                        clearChart.source="graphics/clearChart_black_transparent.svg"
                    }
                }
            }

            Rectangle {
                width:menu.width*0.75; height:width
                radius: 10
                color: "transparent"
                Image {
                    id: logout
                    source: "graphics/logout_black_transparent.svg"
                    anchors.fill: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        handle.iSerrorOnDisconnect=false;
                        handle.disconnectFromServer();
                        previousScreen.state = "visible"
                        screen.state = "after"
                    }
                    onEntered:
                    {
                        logout.source="graphics/logout_black.svg"
                    }
                    onExited: {
                        logout.source="graphics/logout_black_transparent.svg"
                    }
                }
                }
        }

    }

    Rectangle{
        id:upInfo
        anchors.top: parent.top
        width: parent.width
        height: parent.height/10
        Text {
            id :hostInfo
            text: qsTr("Hello World")
            anchors.centerIn: parent
        }
    }

    Rectangle {
        anchors.top: upInfo.bottom
        width: parent.width
        height: parent.height-parent.height/10

        MouseArea {
            width: parent.width/5
            height: parent.height

            hoverEnabled: true
            onEntered: {
                animateMenuOut.stop();
                animateMenuIn.start();
            }
            onExited: {
                animateMenuIn.stop();
                animateMenuOut.start();
            }
        }



        PropertyAnimation {id: animateMenuInOpacity; target: menu; properties: "opacity"; to: 1.0; duration: 1000}

        ParallelAnimation {
                id: animateMenuIn
                running: false
                NumberAnimation { target: menu; property: "x"; to: 0; duration: 1000; easing {
                        type: Easing.InOutQuart
                    }}
                NumberAnimation { target: menu; property: "opacity"; to: 1.0; duration: 1000;easing {
                        type: Easing.InOutQuart
                    }}
            }
        ParallelAnimation {
                id: animateMenuOut
                running: false
                NumberAnimation { target: menu; property: "x"; to:- parent.width/5; duration: 1000;easing {
                        type: Easing.InOutQuart
                    }}
                NumberAnimation { target: menu; property: "opacity"; to: 0.1; duration: 1000;easing {
                        type: Easing.InOutQuart
                    }}
            }

        ServerHandle{
            id: handle
            property bool iSerrorOnDisconnect: true
            property string ip
            onValueChanged: {
                var now = new Date();
                ChartsData.addData(now.toTimeString(),newValue*1.00);
                chart_line.repaint();
                console.log("Odebrano wartość ", newValue);
                hostInfo.text="Podłączony do hosta:"+ip+" o godzinie:"+now.toTimeString()+" ostatnia wartość:"+newValue
                handle.sendValue('ok');
            }
            onDisconnected: {
                if(iSerrorOnDisconnect){
                error.visible=true;
                errorText.text="Połączenie z serwerem zostało zerwane!"
                app.enabled=false;
                console.log("Error");
                }
            }

        }

        Timer {
            id: samplesTimer
                interval: 3000; running: false; repeat: true;
                onTriggered: {
                    var now = new Date();
                    chart_line.requestPaint();
                    handle.sendValue('0');
                    }
            }




        Chart {
          id: chart_line;
          anchors.fill: parent
          chartAnimated: true;
          chartAnimationEasing: Easing.InCubic;
          chartAnimationDuration: 0;
          chartData: ChartsData.ChartLineData;
          chartType: Charts.ChartType.LINE;
        }


    }
}
    function connectToServer(ip)
    {
        console.log("Use IP: ", ip);
        hostInfo.text="Łączenie z hostem:"+ip
        if(handle.connect(ip,50000)==true)
        {
            samplesTimer.running=true;
            var now = new Date();
            hostInfo.text="Podłączony do hosta:"+ip+" o godzinie:"+now.toTimeString()
            handle.ip=ip;
        }else
        {
            error.visible=true;
            errorText.text="Serwer jest nieczynny!!"
            app.enabled=false;
        }


    }

}


