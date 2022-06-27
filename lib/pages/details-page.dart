import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
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
    ThemeProvider themeProv =
        Provider.of<ThemeProvider>(context, listen: false);
    List<FlSpot> dataList = getChartData();
    if (double.parse(dataList[0].y.toString()) <
        double.parse(dataList[dataList.length - 1].y.toString())) {
      print("YEESSSSS");
    } else {
      print("NNOOOOOOOOOOOO");
    }
    return Scaffold(
      body: Consumer<MarketProvider>(
        builder: (context, marketProvider, child) {
          CryptoCurrencyModel crypto = marketProvider.getMarketByID(widget.id);

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
                  Column(
                    children: [
                      SizedBox(
                        height: getDeviceHeight(context) * 0.06,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Expanded(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_left,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  crypto.name!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: (themeProv.themeMode ==
                                              ThemeMode.light)
                                          ? const Color(0xff323862)
                                          : const Color.fromARGB(
                                              255, 255, 255, 255)),
                                ),
                                Text(
                                  "(${crypto.symbol!.toUpperCase()})",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getDeviceWidth(context) * 0.02,
                            vertical: getDeviceWidth(context) / 23,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "${crypto.name!} Price",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "${crypto.currentPrice!} \$",
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.bold,
                                        color: (themeProv.themeMode ==
                                                ThemeMode.light)
                                            ? const Color(0xff323862)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255)),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Total Volume: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "${crypto.totalVolume!} \$",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XFF47d093)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(crypto.image!),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: themeProv.themeMode == ThemeMode.light
                                ? Colors.white
                                : const Color.fromARGB(255, 44, 45, 45),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            boxShadow: [
                              themeProv.themeMode == ThemeMode.light
                                  ? const BoxShadow(
                                      color: Color.fromARGB(255, 196, 202, 206),
                                      offset: Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    )
                                  : const BoxShadow(
                                      color: Color.fromARGB(255, 65, 67, 68),
                                      offset: Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    )
                            ]),
                        height: getDeviceHeight(context) / 2.6,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, TitleMeta) {
                                      var d =
                                          DateTime.fromMicrosecondsSinceEpoch(
                                                  value.toInt() * 1000,
                                                  isUtc: false)
                                              .day;
                                      return Column(
                                        children: [
                                          Text(
                                            d.toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 120, 148, 162)),
                                          ),
                                          Text(
                                            currentMonthShort,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
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
                                show: false,
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: getChartData(),
                                  gradient:
                                      (double.parse(dataList[0].y.toString()) <
                                              double.parse(
                                                  dataList[dataList.length - 1]
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
                                          : LinearGradient(
                                              colors: [
                                                const Color.fromARGB(
                                                    255, 230, 93, 35),
                                                const Color.fromARGB(
                                                        255, 211, 26, 2)
                                                    .withOpacity(0.6)
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              stops: const [0.4, 0.7],
                                              tileMode: TileMode.repeated,
                                            ),
                                  barWidth: 1.5,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: (double.parse(
                                                dataList[0].y.toString()) <
                                            double.parse(
                                                dataList[dataList.length - 1]
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
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.repeated,
                                          )
                                        : LinearGradient(
                                            colors: [
                                              const Color.fromARGB(
                                                      255, 141, 79, 71)
                                                  .withOpacity(0.1),
                                              const Color.fromARGB(
                                                      255, 230, 48, 35)
                                                  .withOpacity(0.9),
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            tileMode: TileMode.repeated,
                                          ),
                                  ),
                                  dotData: FlDotData(
                                      show: false,
                                      getDotPainter:
                                          (spot, percent, barData, index) {
                                        return FlDotCirclePainter();
                                      },
                                      checkToShowDot: (spot, barData) {
                                        return spot.x != 0 && spot.x != 6;
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Market Statistics",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: (themeProv.themeMode == ThemeMode.light)
                                    ? textColor1
                                    : whiteTextColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TODAY'S HIGHEST",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color:
                                      (themeProv.themeMode == ThemeMode.light)
                                          ? textColor1
                                          : whiteTextColor),
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
                                        color: Color.fromARGB(255, 0, 236, 59),
                                      ),
                                      Text(
                                        "+${priceChange.toStringAsFixed(3)}\$",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 236, 59),
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
                                        CupertinoIcons.down_arrow,
                                        color: Color.fromARGB(255, 236, 51, 0),
                                      ),
                                      Text(
                                        "${priceChange.toStringAsFixed(3)}\$",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 236, 51, 0),
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
                            Text(
                              "MARKET CAP",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color:
                                      (themeProv.themeMode == ThemeMode.light)
                                          ? textColor1
                                          : whiteTextColor),
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
                                        color: Color.fromARGB(255, 0, 236, 59),
                                      ),
                                      Text(
                                        "+${priceChangePercentage.toStringAsFixed(3)}%",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 236, 59),
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
                                        CupertinoIcons.down_arrow,
                                        color: Color.fromARGB(255, 236, 51, 0),
                                      ),
                                      Text(
                                        "${priceChangePercentage.toStringAsFixed(3)}%",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 236, 51, 0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MARKET SUPPLIES",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color:
                                      (themeProv.themeMode == ThemeMode.light)
                                          ? textColor1
                                          : whiteTextColor),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All TIME HIGH",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color:
                                      (themeProv.themeMode == ThemeMode.light)
                                          ? textColor1
                                          : whiteTextColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${crypto.ath!}\$",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Builder(
                              builder: (context) {
                                double priceChange =
                                    crypto.athChangePercentage!;

                                if (priceChange > 0) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.up_arrow,
                                        color: Color.fromARGB(255, 0, 236, 59),
                                      ),
                                      Text(
                                        "+${priceChange.toStringAsFixed(3)}\$",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 236, 59),
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
                                        CupertinoIcons.down_arrow,
                                        color: Color.fromARGB(255, 236, 51, 0),
                                      ),
                                      Text(
                                        "${priceChange.toStringAsFixed(3)}\$",
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 236, 51, 0),
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
                  )
                ],
              ),
            ),
          );
        },
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
