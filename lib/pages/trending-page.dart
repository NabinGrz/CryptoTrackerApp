import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/model/trendingcryptomodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:cryptotrackerapp/provider/trending-crypto-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingCryptoPage extends StatefulWidget {
  const TrendingCryptoPage({Key? key}) : super(key: key);

  @override
  State<TrendingCryptoPage> createState() => _TrendingCryptoPageState();
}

class _TrendingCryptoPageState extends State<TrendingCryptoPage> {
  @override
  void initState() {
    //_chartData =
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PriceChartModel chartData;
    MarketProvider marketProv =
        Provider.of<MarketProvider>(context, listen: false);

    return Consumer<TrendingCryptoProvider>(
      builder: (context, trendProvider, child) {
        return Column(
          children: [
            SizedBox(
              height: getDeviceHeight(context) / 3,
              width: getDeviceWidth(context),
              //color: Colors.red,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemCount: trendProvider.trendingCrypto.length,
                itemBuilder: (context, index) {
                  Coin? coin = trendProvider.trendingCrypto[index];
                  // CryptoCurrencyModel crypto =
                  //     marketProv.getMarketByID("bitcoin");

                  return Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProv, child) {
                          // chartData = marketProv
                          //     .getMarketByID(coin!.item!.symbol!.toString());
                          return Container(
                              height: getDeviceHeight(context) / 3.4,
                              width: getDeviceWidth(context) / 2.2,
                              decoration: BoxDecoration(
                                  color: (themeProv.themeMode ==
                                          ThemeMode.light)
                                      ? const Color.fromARGB(255, 219, 219, 219)
                                      : const Color.fromARGB(255, 77, 76, 76),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          coin!.item!.small!.toString()),
                                    ),
                                    title: Text(
                                      coin.item!.symbol!.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ), //currentPrice.currentPrice;
                                    subtitle: Text(
                                      "${coin.item!.name!}#${coin.item!.marketCapRank!}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getDeviceHeight(context) / 5.4,
                                    width: getDeviceWidth(context) / 2.9,
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
                                            spots:
                                                //getTrendChartData(),
                                                [
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
                                  )
                                ],
                              ));
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // List<FlSpot> getTrendChartData() {
  //   try {
  //     List<FlSpot> chartData = [];
  //     List<dynamic> datalistPrice = [];
  //     List<dynamic> datalistDate = [];
  //     List<dynamic> finalListDate = [];
  //     List<dynamic> finalListPrice = [];
  //     for (int i = 0; i < _chartData!.prices!.length; i++) {
  //       datalistPrice.addAll([_chartData!.prices![i][1]]);
  //       datalistDate.addAll([_chartData!.prices![i][0]]);
  //       finalListPrice = datalistPrice;
  //       finalListDate = datalistDate;
  //       chartData.add(FlSpot(finalListDate[i], finalListPrice[i]));
  //       print("PRICE: ${finalListPrice[0]}");
  //       // chartData.add(PriceData(
  //       //     day: finalListDate[i],
  //       //     price: finalListPrice[i],
  //       //     color: (i.isEven)
  //       //         ? const Color.fromARGB(255, 46, 197, 0)
  //       //         : const Color.fromARGB(255, 252, 29, 0)));

  //       //print(finalListPrice[i]);
  //     }
  //     //[(0.0, 3.0), (2.6, 2.0), (4.9, 5.0), (6.8, 2.5), (8.0, 4.0), (9.5, 3.0)]
  //     // chartData = [
  //     //   const FlSpot(343.0, 28828.44755984821),
  //     //   const FlSpot(544.0, 28928.059944615532),
  //     //   const FlSpot(5655.0, 29078.446327272137),
  //     //   const FlSpot(767766.0, 29019.21560114639),
  //     //   const FlSpot(7676.0, 29048.091431795056)
  //     //   // const FlSpot(0, 3),
  //     //   // const FlSpot(2.6, 2),
  //     //   // const FlSpot(4.9, 5),
  //     //   // const FlSpot(6.8, 2.5),
  //     //   // const FlSpot(8, 4),
  //     //   // const FlSpot(9.5, 3),
  //     // ];
  //     return chartData;
  //   } catch (ex) {
  //     return [];
  //   }
  // }

}
