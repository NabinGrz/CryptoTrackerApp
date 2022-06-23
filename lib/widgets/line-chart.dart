import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends StatefulWidget {
  List<dynamic> priceData;
  MyHomePage({required this.priceData});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SalesData>? _chartData;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        return SafeArea(
          child: Column(
            children: [
              Text(widget.priceData.toString()),
              // Consumer<MarketProvider>(
              //   builder: (context, marketProvider, child) {
              //     return IconButton(
              //         onPressed: () async {
              //           await marketProvider.fetchMarketChart("bitcoin");
              //         },
              //         icon: const Icon(Icons.abc));
              //   },
              // ),
              SfCartesianChart(
                title: ChartTitle(text: 'Yearly price analysis'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  LineSeries<SalesData, double>(
                      name: 'Sales',
                      dataSource: _chartData!,
                      xValueMapper: (SalesData price, _) => price.day,
                      yValueMapper: (SalesData price, _) => price.price,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true)
                ],
                primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}',
                  // numberFormat:
                  //     NumberFormat.simpleCurrency(decimalDigits: 0)
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  List<SalesData> getChartData() {
    // var d =
    //     DateTime.fromMillisecondsSinceEpoch(1655359284380 * 1000, isUtc: false)
    //         .month;
    // //54426-04-01 05:11:20.000
    // print(DateTime.fromMillisecondsSinceEpoch(1655359284380 * 1000,
    //     isUtc: false));
    // print(d);
    final List<SalesData> chartData = [
      SalesData(1655359284380, 22003.149221852662),
      SalesData(1655366556864, 21757.406627470282),
      SalesData(1655370094716, 21776.193990099047),
      SalesData(1655373749469, 21254.109080668997),
      SalesData(1655377305773, 21110.606208355235)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.day, this.price);
  final double day;
  final double price;
}
