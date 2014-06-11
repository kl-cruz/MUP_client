import QtQuick 2.0


import "qchart.js/QChart.js"        as Charts
import "dataModeler.js" as ChartsData

import "qchart.js/."

import mupServerHandle 1.0



Rectangle {
    width: 500
    height: 500
    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent

        onDoubleClicked: ChartsData.clearData();
    }
    ServerHandle{
        id: handle
        onValueChanged: {
            var now = new Date();
            ChartsData.addData2(now.toTimeString(),newValue*1.00);//Math.random()*100);
            console.log("newValue is ", newValue);
        }

    }

    Timer {
            interval: 1000; running: true; repeat: true;
            onTriggered: {
                var now = new Date();
                //console.log(now.toTimeString())
                //now.format("dd/M/yy h:mm:tt");
                    //ChartsData.addData2(now.toTimeString(),Math.random()*100);
                    //chart_line.requestPaint();
                chart_line.requestPaint();
                handle.sendValue('5');
                }
                //console.log(chart_line.chartData);
        }


    Chart {
      id: chart_line;
      anchors.fill: parent
      chartAnimated: true;
      chartAnimationEasing: Easing.InOutQuad;
      chartAnimationDuration: 200;
      chartData: ChartsData.ChartLineData;
      chartType: Charts.ChartType.LINE;
    }


}
