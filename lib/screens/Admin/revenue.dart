import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Revenue extends StatefulWidget {
  const Revenue({Key? key}) : super(key: key);

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  DateTime now = DateTime.now();
  late String _displayMonth;
  late String _displayYear;

  @override
  void initState() {
    _displayMonth = DateFormat.MMMM().format(now);
    _displayYear = DateFormat.y().format(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 35),
      ChartData(5, 28),
      ChartData(10, 34),
      ChartData(15, 32),
      ChartData(20, 40),
      ChartData(25, 40),
      ChartData(30, 100),
    ];

    return Scaffold(
      body: Column(children: [
        SizedBox(height: getheight(context, 60)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_arrow_left)),
                ],
              ),
              SizedBox(
                height: getheight(context, 10),
              ),
              Text(
                "Revenue",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(
          height: getheight(context, getheight(context, 25)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: getwidth(context, 40)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now.subtract(Duration(days: 3650 * 2)),
                    lastDate: now.add(Duration(days: 3650 * 2)),
                  ).then((value) {
                    setState(() {
                      DateTime? now = value;
                      _displayYear = value!.year.toString();
                      _displayMonth = DateFormat.MMMM().format(value);
                    });
                  });
                },
                child: Text("${_displayMonth} ${_displayYear}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    /// going to previous date
                    setState(() {
                      now = now.subtract(Duration(days: 30));
                      _displayMonth = DateFormat.MMMM().format(now);
                    });
                  },
                  child: Icon(Icons.keyboard_arrow_left)),
              SizedBox(width: 10),
              GestureDetector(
                  onTap: () {
                    //////// going to forward date
                    setState(() {
                      now = now.add(Duration(days: 30));
                      _displayMonth = DateFormat.MMMM().format(now);
                    });
                  },
                  child: Icon(Icons.keyboard_arrow_right))
            ],
          ),
        ),
        SizedBox(height: getheight(context, 30)),
        Container(
          height: getheight(context, 250),
          child: SfCartesianChart(
              crosshairBehavior: CrosshairBehavior(
                  shouldAlwaysShow: true,
                  enable: true,
                  activationMode: ActivationMode.singleTap),
              series: <ChartSeries>[
                LineSeries<ChartData, int>(
                    xAxisName: "Revenue",
                    yAxisName: "Days",
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ]),
        ),
        SizedBox(
          height: getheight(context, 40),
        ),
        Container(
          height: getheight(context, 70),
          width: getwidth(context, 315),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your revenue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Spacer(),
                Text(
                  "1500/-",
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getheight(context, 20),
        ),
        Container(
          height: getheight(context, 70),
          width: getwidth(context, 315),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total orders",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Spacer(),
                Text(
                  "250",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getheight(context, 20),
        ),
        Container(
          height: getheight(context, 70),
          width: getwidth(context, 315),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settled on ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Spacer(),
                Text(
                  "25 May 2011",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
