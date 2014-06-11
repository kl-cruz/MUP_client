function addData(label,newData) {
    if((ChartLineData.labels.length)>MaxSamples){
    ChartLineData.labels.shift();
    ChartLineData.datasets[0].data.shift();

    }
    ChartLineData.labels.push(label);
    ChartLineData.datasets[0].data.push(newData);
}

function clearData() {
    ChartLineData.labels = [];
    ChartLineData.datasets[0].data = [];
}

var MaxSamples = 10;

var ChartLineData = {
      labels: [],
    datasets: [{
               fillColor: "rgba(220,220,220,0.5)",
             strokeColor: "rgba(220,220,220,1)",
              pointColor: "rgba(220,220,220,1)",
        pointStrokeColor: "#ffffff",
                    data: []
    }]
}
