import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
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
  final CryptoCurrencyModel cryptoCurrencyModel;
  const TrendingCryptoPage({Key? key, required this.cryptoCurrencyModel})
      : super(key: key);

  @override
  State<TrendingCryptoPage> createState() => _TrendingCryptoPageState();
}

class _TrendingCryptoPageState extends State<TrendingCryptoPage> {
  PriceChartModel? chartOfTrending;
  List<FlSpot> priceData = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);

    return Consumer<TrendingCryptoProvider>(
      builder: (context, trendProvider, child) {
        // getTrendChartData(marketProvider, trendProvider, index);
        return Column(
          children: [
            SizedBox(
              height: getDeviceHeight(context) / 5.9,
              width: getDeviceWidth(context),
              // color: Colors.red,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemCount: trendProvider.trendingCrypto.length,
                itemBuilder: (context, index) {
                  // getTrendChartData();
                  Coin? coin = trendProvider.trendingCrypto[index];
                  //getTrendChartData(marketProvider, coin!, index);
                  // CryptoCurrencyModel crypto =
                  //     marketProv.getMarketByID("bitcoin");

                  return Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProv, child) {
                          // getTrendChartData();
                          return Stack(
                            children: [
                              Container(
                                  height: double.infinity,
                                  width: getDeviceWidth(context) / 2.2,
                                  decoration: BoxDecoration(
                                      color: (themeProv.themeMode ==
                                              ThemeMode.light)
                                          ? (index.isOdd)
                                              ? blueColor
                                              : (index % 4 != 0)
                                                  ? orangeColor
                                                  : (index % 3 != 0)
                                                      ? yellowColor
                                                      : (index % 3 > 4 ||
                                                              index % 3 > 3)
                                                          ? greenColor
                                                          : redwColor
                                          : const Color.fromARGB(
                                              255, 77, 76, 76),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, top: 10),
                                          child: Text(
                                            "Rank: ${coin!.item!.marketCapRank!}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Text(
                                          coin.item!.name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  coin.item!.small!.toString()),
                                            ),
                                            Text(
                                              coin.item!.symbol!.toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //buildChart(context, priceData, index)
                                    ],
                                  )),
                              Positioned(
                                  right: -50,
                                  child: Opacity(
                                    opacity:
                                        (themeProv.themeMode == ThemeMode.light)
                                            ? 0.4
                                            : 0.2,
                                    child: Image.asset(
                                      "images/topRightTrend.png",
                                    ),
                                  )),
                              Positioned(
                                  top: 20,
                                  left: -30,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 186, 188, 223)
                                            .withOpacity(
                                          (themeProv.themeMode ==
                                                  ThemeMode.light)
                                              ? 0.4
                                              : 0.2,
                                        ),
                                        shape: BoxShape.circle),
                                  )),
                            ],
                          );
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

  Future<List<FlSpot>> getTrendChartData(
      MarketProvider marketProvider, Coin coin, int index) async {
    chartOfTrending = await marketProvider.fetchMarketChart(coin.item!.id!
        //  trendingCryptoProvider.trendingCrypto[index]?.item!.id!.toString()
        );
    print("CHART OF TRENDASDHJHJ${chartOfTrending!.prices}");
    //try {
    List<FlSpot> chartData = [];
    List<dynamic> datalistPrice = [];
    List<dynamic> datalistDate = [];
    List<dynamic> finalListDate = [];
    List<dynamic> finalListPrice = [];
    List<FlSpot> coinPriceData = [];
    for (int i = 0; i < chartOfTrending!.prices!.length; i++) {
      datalistPrice.addAll([chartOfTrending!.prices![i][1]]);
      datalistDate.addAll([chartOfTrending!.prices![i][0]]);
      finalListPrice = datalistPrice;
      finalListDate = datalistDate;
      chartData.add(FlSpot(finalListDate[i], finalListPrice[i]));
      coinPriceData.add(chartData[i]);
    }
    //  priceData.add(chartData[]);

    priceData = coinPriceData;
    print("WHOLE DATE:  $priceData");
    print(chartData.length);
    return chartData;
  }
}
