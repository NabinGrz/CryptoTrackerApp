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
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];

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
    List<FlSpot> dataList = getChartData();
    if (double.parse(dataList[0].y.toString()) <
        double.parse(dataList[dataList.length - 1].y.toString())) {
      print("YEESSSSS");
    } else {
      print("NNOOOOOOOOOOOO");
    }
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
                        Container(
                          height: getDeviceHeight(context) / 1.7,
                          color: const Color.fromARGB(255, 30, 0, 179),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  // color: Colors.green,
                                  height: getDeviceHeight(context) / 40,
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
                                  horizontal: getDeviceWidth(context) * 0.02,
                                  vertical: getDeviceWidth(context) / 12,
                                ),
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
                                            fontSize: 20,
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
                              Container(
                                // color: Colors.redAccent,
                                height: getDeviceHeight(context) / 2.5,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),

                                width: MediaQuery.of(context).size.width,
                                child: LineChart(
                                  LineChartData(
                                    titlesData: FlTitlesData(
                                        show: true,
                                        bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                          showTitles: true,
                                          //interval: 7,
                                          reservedSize: 40,
                                          getTitlesWidget: (value, TitleMeta) {
                                            var d = DateTime
                                                    .fromMicrosecondsSinceEpoch(
                                                        value.toInt() * 1000,
                                                        isUtc: false)
                                                .day;
                                            return Column(
                                              children: [
                                                Text(
                                                  d.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 120, 148, 162)),
                                                ),
                                                Text(
                                                  currentMonthShort,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 120, 148, 162)),
                                                ),
                                              ],
                                            );
                                          },
                                        )),
                                        leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                          showTitles: true,
                                          //interval: 7,
                                          reservedSize: 40,

                                          getTitlesWidget: (value, TitleMeta) {
                                            NumberFormat numberFormat =
                                                NumberFormat.compact();

                                            return Text(
                                              numberFormat.format(value),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 120, 148, 162)),
                                            );
                                          },
                                        )),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false))),
                                    gridData: FlGridData(
                                      show: true,
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: getChartData(),
                                        // [
                                        //   const FlSpot(2.6, 2),
                                        //   const FlSpot(4.9, 5),
                                        //   const FlSpot(6.8, 2.5),
                                        //   const FlSpot(8, 4),
                                        //   const FlSpot(9.5, 3),
                                        // ],
                                        // color: Colors.red,
                                        gradient: (double.parse(
                                                    dataList[0].y.toString()) <
                                                double.parse(dataList[
                                                        dataList.length - 1]
                                                    .y
                                                    .toString()))
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xff23b6e6),
                                                  Color(0xff02d39a)
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                stops: [0.4, 0.7],
                                                tileMode: TileMode.repeated,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 230, 93, 35),
                                                  Color.fromARGB(
                                                      255, 211, 26, 2)
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                stops: [0.4, 0.7],
                                                tileMode: TileMode.repeated,
                                              ),

                                        // isCurved: true,
                                        barWidth: 1.5,
                                        // dotData: FlDotData(show: false),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          // color: Colors.red,
                                          gradient: (double.parse(dataList[0]
                                                      .y
                                                      .toString()) <
                                                  double.parse(dataList[
                                                          dataList.length - 1]
                                                      .y
                                                      .toString()))
                                              ? LinearGradient(
                                                  colors: [
                                                    const Color(0xff23b6e6)
                                                        .withOpacity(0.6),
                                                    const Color(0xff02d39a)
                                                        .withOpacity(0.6)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomLeft,
                                                  // stops: [0.9, 0.20],
                                                  tileMode: TileMode.repeated,
                                                )
                                              : LinearGradient(
                                                  colors: [
                                                    const Color.fromARGB(
                                                            255, 90, 26, 18)
                                                        .withOpacity(0.6),
                                                    const Color.fromARGB(
                                                            255, 230, 48, 35)
                                                        .withOpacity(0.6),
                                                  ],
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                  //  stops: const [0.4, 0.7],
                                                  tileMode: TileMode.repeated,
                                                ),
                                          // spotsLine: BarAreaSpotsLine(
                                          //   show: true,
                                          //   flLineStyle: FlLine(

                                          //     color: const Color.fromARGB(
                                          //             255, 110, 217, 47)
                                          //         .withOpacity(0.4),
                                          //     // strokeWidth: 2,
                                          //   ),
                                          //   checkToShowSpotLine: (spot) {
                                          //     if (spot.x == 0 || spot.x == 6) {
                                          //       return false;
                                          //     }

                                          //     return true;
                                          //   },
                                          // ),
                                        ),
                                        dotData: FlDotData(
                                            show: false,
                                            getDotPainter: (spot, percent,
                                                barData, index) {
                                              return FlDotCirclePainter();
                                              // if (index % 2 == 0) {
                                              //   return FlDotCirclePainter(
                                              //       radius: 6,
                                              //       color: Colors.white,
                                              //       strokeWidth: 3,
                                              //       strokeColor:
                                              //           Colors.deepOrange);
                                              // } else {
                                              //   return FlDotSquarePainter(
                                              //     size: 12,
                                              //     color: Colors.white,
                                              //     strokeWidth: 3,
                                              //     strokeColor:
                                              //         Colors.deepOrange,
                                              //   );
                                              // }
                                            },
                                            checkToShowDot: (spot, barData) {
                                              return spot.x != 0 && spot.x != 6;
                                            }),
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
        print("PRICE: ${finalListPrice[0]}");
        // chartData.add(PriceData(
        //     day: finalListDate[i],
        //     price: finalListPrice[i],
        //     color: (i.isEven)
        //         ? const Color.fromARGB(255, 46, 197, 0)
        //         : const Color.fromARGB(255, 252, 29, 0)));

        //print(finalListPrice[i]);
      }
      //[(0.0, 3.0), (2.6, 2.0), (4.9, 5.0), (6.8, 2.5), (8.0, 4.0), (9.5, 3.0)]
      // chartData = [
      //   const FlSpot(343.0, 28828.44755984821),
      //   const FlSpot(544.0, 28928.059944615532),
      //   const FlSpot(5655.0, 29078.446327272137),
      //   const FlSpot(767766.0, 29019.21560114639),
      //   const FlSpot(7676.0, 29048.091431795056)
      //   // const FlSpot(0, 3),
      //   // const FlSpot(2.6, 2),
      //   // const FlSpot(4.9, 5),
      //   // const FlSpot(6.8, 2.5),
      //   // const FlSpot(8, 4),
      //   // const FlSpot(9.5, 3),
      // ];
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
