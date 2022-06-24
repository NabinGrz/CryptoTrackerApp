import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailPage extends StatefulWidget {
  String id;
  PriceChartModel priceData;
  DetailPage({Key? key, required this.id, required this.priceData})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  PriceChartModel? _chartData;
  TooltipBehavior? _tooltipBehavior;
  var currentMonth = DateFormat.LLLL().format(DateTime.now());
  var currentMonthShort = DateFormat.MMM().format(DateTime.now());
  @override
  void initState() {
    _chartData = widget.priceData;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: Consumer<MarketProvider>(
          builder: (context, marketProvider, child) {
            CryptoCurrencyModel crypto =
                marketProvider.getMarketByID(widget.id);

            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.getMarketByID(widget.id);
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "images/background.png",
                          fit: BoxFit.cover,
                          width: getDeviceWidth(context),
                          height: getDeviceHeight(context) / 1.7,
                        ),
                        SizedBox(
                          height: getDeviceHeight(context) / 1.7,
                          //color: const Color.fromARGB(255, 30, 0, 179),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  height: getDeviceHeight(context) / 15,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.arrow_left,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getDeviceWidth(context) * 0.02),
                                child: Row(
                                  //mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              crypto.name!,
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "(${crypto.symbol!.toUpperCase()})",
                                              style: const TextStyle(
                                                fontSize: 23,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${crypto.currentPrice!} USD",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 200, 200, 200),
                                          ),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          NetworkImage(crypto.image!),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(
                              //   height: 13,
                              // ),
                              SizedBox(
                                // color: Colors.redAccent,
                                height: getDeviceHeight(context) / 2.5,
                                width: MediaQuery.of(context).size.width,
                                child: LineChart(
                                  LineChartData(
                                    minX: 0,
                                    maxX: 11,
                                    minY: 0,
                                    maxY: 6,
                                    titlesData: FlTitlesData(
                                      show: false,
                                    ),
                                    gridData: FlGridData(
                                      show: false,
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          const FlSpot(0, 3),
                                          const FlSpot(2.6, 2),
                                          const FlSpot(4.9, 5),
                                          const FlSpot(6.8, 2.5),
                                          const FlSpot(8, 4),
                                          const FlSpot(9.5, 3),
                                        ],
                                        isCurved: true,
                                        color: Colors.red,
                                        barWidth: 5,
                                        // dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // SfCartesianChart(
                                //   enableAxisAnimation: true,
                                //   primaryXAxis: NumericAxis(
                                //       edgeLabelPlacement:
                                //           EdgeLabelPlacement.shift,
                                //       isVisible: true,
                                //       labelFormat: '{value}',
                                //       labelStyle: const TextStyle(
                                //         color:
                                //             Color.fromARGB(255, 189, 189, 189),
                                //         fontSize: 14,
                                //       )),
                                //   title: ChartTitle(
                                //       alignment: ChartAlignment.center,
                                //       textStyle: const TextStyle(
                                //           color: Color.fromARGB(
                                //               255, 255, 255, 255),
                                //           fontSize: 14,
                                //           fontStyle: FontStyle.italic),
                                //       text: crypto.name! +
                                //           ' price analysis for '
                                //               "$currentMonth"),
                                //   //  legend: Legend(isVisible: true),
                                //   tooltipBehavior: _tooltipBehavior,
                                //   series: <ChartSeries<PriceData, dynamic>>[
                                //     LineSeries<PriceData, dynamic>(
                                //       dataSource: getChartData(),
                                //       xValueMapper: (PriceData price, _) {
                                //         var dateCrypto =
                                //             DateTime.fromMicrosecondsSinceEpoch(
                                //                     price.day.toInt() * 1000,
                                //                     isUtc: false)
                                //                 .day;
                                //         // print(dateCrypto);
                                //         return dateCrypto;
                                //       },
                                //       yValueMapper: (PriceData price, _) {
                                //         return price.price;
                                //       },
                                //       name: 'Sales',
                                //       pointColorMapper: (PriceData price, _) =>
                                //           price.color,
                                //     )
                                //   ],

                                //   primaryYAxis: NumericAxis(
                                //       labelFormat: '{value}' " \$",
                                //       labelStyle: const TextStyle(
                                //         color:
                                //             Color.fromARGB(255, 189, 189, 189),
                                //         fontSize: 14,
                                //       )),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "TODAY'S HIGHEST",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${crypto.high24H!}\$",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Builder(
                                builder: (context) {
                                  double priceChange = crypto.priceChange24H!;

                                  if (priceChange > 0) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          CupertinoIcons.up_arrow,
                                          // size: 12,
                                          color:
                                              Color.fromARGB(255, 0, 236, 59),
                                        ),
                                        Text(
                                          "+${priceChange.toStringAsFixed(3)}\$",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 236, 59),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          // size: 12,
                                          CupertinoIcons.down_arrow,
                                          color:
                                              Color.fromARGB(255, 236, 51, 0),
                                        ),
                                        Text(
                                          "${priceChange.toStringAsFixed(3)}\$",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 236, 51, 0),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "MARKET CAP",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${crypto.marketCap!}\$",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Builder(
                                builder: (context) {
                                  double priceChange = crypto.priceChange24H!;
                                  double priceChangePercentage =
                                      crypto.priceChangePercentage24H!;

                                  if (priceChange > 0) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          CupertinoIcons.up_arrow,
                                          // size: 12,
                                          color:
                                              Color.fromARGB(255, 0, 236, 59),
                                        ),
                                        Text(
                                          "+${priceChangePercentage.toStringAsFixed(3)}%",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 236, 59),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Icon(
                                          // size: 12,
                                          CupertinoIcons.down_arrow,
                                          color:
                                              Color.fromARGB(255, 236, 51, 0),
                                        ),
                                        Text(
                                          "${priceChangePercentage.toStringAsFixed(3)}%",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 236, 51, 0),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "MARKET SUPPLIES",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: getDeviceWidth(context) / 3.1,
                              width: getDeviceWidth(context) / 3.1,
                              child: SleekCircularSlider(
                                appearance: CircularSliderAppearance(
                                    customColors: CustomSliderColors(
                                        progressBarColor: Colors.orange),
                                    //  spinnerMode: true,
                                    infoProperties: InfoProperties(
                                        modifier: (val) {
                                          return val.toString();
                                        },
                                        bottomLabelText: "Supplies",
                                        bottomLabelStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        mainLabelStyle: const TextStyle(
                                          fontSize: 13,
                                        ))),
                                min: 0,
                                max: crypto.maxSupply ??
                                    crypto.circulatingSupply,
                                initialValue: crypto.circulatingSupply ?? 1,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<FlSpot> getChartData() {
    try {
      List<FlSpot> chartData = [];
      List<dynamic> datalistPrice = [];
      List<dynamic> datalistDate = [];
      List<dynamic> finalListDate = [];
      List<dynamic> finalListPrice = [];
      for (int i = 0; i < _chartData!.prices!.length; i++) {
        datalistPrice.addAll([_chartData!.prices![i][1]]);
        datalistDate.addAll([_chartData!.prices![i][0]]);
        finalListPrice = datalistPrice;
        finalListDate = datalistDate;
        chartData.add(FlSpot(finalListDate[i], finalListPrice[i]));
        // chartData.add(PriceData(
        //     day: finalListDate[i],
        //     price: finalListPrice[i],
        //     color: (i.isEven)
        //         ? const Color.fromARGB(255, 46, 197, 0)
        //         : const Color.fromARGB(255, 252, 29, 0)));

        //print(finalListPrice[i]);
      }
      return chartData;
    } catch (ex) {
      return [];
    }
  }
}

class PriceData {
  PriceData({required this.day, required this.price, required this.color});
  final double day;
  final double price;
  final Color color;

  factory PriceData.fromJson(Map<String, dynamic> map) =>
      PriceData(day: map["day"], price: map["price"], color: map["color"]);
}
