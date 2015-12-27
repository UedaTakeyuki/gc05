<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>計測値</title>
  <script src="Chart.js"></script>
  <script src="browserMqtt-1.3.5.js"></script>
  <script>

  var myLineChart;
  window.onload = function (){
  // コンテキストの取得
  var ctx = document.getElementById("myChart").getContext("2d");
  // イニシャルデータ
  var data = {
    //labels: ["January", "February", "March", "April", "May", "June", "July"],
    labels: ["", "", "", "", "", "", "", "", "", "", ""],
    datasets: [
        /*{
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81, 56, 55, 40]
        },*/
        {
            label: "My Second dataset",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            //data: [28, 48, 40, 19, 86, 27, 90]
            data: [00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00]
        }
    ]
	};
  myLineChart = new Chart(ctx).Line(data, 
    {animation: false});

  // データ追加
  myLineChart.addData([0], "");
  // 先頭データ削除
  myLineChart.removeData();
	}
  </script>
  <script>
	var client; // MQTTのクライアントです
  // 接続(WebSocketなBrokerへのURL)
//  var client = mqtt.connect('ws://gc05.local:9001/mqtt');
//  var client = mqtt.connect('ws://<?php echo $_SERVER['SERVER_ADDR']; ?>:9001/mqtt');
//  var client = mqtt.connect('ws://<?php echo gethostbyname($_SERVER['SERVER_NAME']); ?>:9001/mqtt');
//  var client = mqtt.connect('ws://<?php echo gethostbyname("gc05"); ?>:9001/mqtt');
  var client = mqtt.connect('ws://<?php echo substr(`hostname -I`, 0, -2) ?>:9001/mqtt');

  // 購読するTopicを指定
  client.subscribe('value');

  client.on('message', function(topic, payload) {
    console.log([topic, payload].join(': '));
    // payload: 2015/12/26 06:35:47.418,23.0
    //   => datetime, value
    [datetime, value] = payload.toString().split(",");
    // データ追加
    document.getElementById("datetime_tag").innerText = datetime;
    document.getElementById("value_tag").innerText = value + " ℃";
    myLineChart.addData([parseFloat(value)], datetime);
    // 先頭データ削除
    myLineChart.removeData();

    // 切断
    //client.end();
  });
  </script>
</head>
<body>
  <p>計測値</p>
  <table border="1"><tr>
    <td>日時: <span id="datetime_tag"></span></td>
    <td>測定値: <span id="value_tag"></span></td>
  </tr></table>
	<canvas id="myChart" width="800" height="400"></canvas>
</body>
</html>
