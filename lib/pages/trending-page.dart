import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/model/trendingcryptomodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
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
              height: getDeviceHeight(context) / 3,
              width: getDeviceWidth(context),
              //color: Colors.red,
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
                          print(
                              "ITEMS:  ${trendProvider.trendingCrypto[index]?.item!.id}");

                          // getTrendChartData();
                          return InkWell(
                            onTap: () async {
                              var data = await marketProvider
                                  .getMarketByID(coin!.item!.id!);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(
                                      id: coin.item!.id!, priceData: data);
                                },
                              ));
                            },
                            child: Container(
                                height: getDeviceHeight(context) / 3.4,
                                width: getDeviceWidth(context) / 2.2,
                                decoration: BoxDecoration(
                                    color: (themeProv.themeMode ==
                                            ThemeMode.light)
                                        ? const Color.fromARGB(
                                            255, 219, 219, 219)
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
                                      title: GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          coin.item!.symbol!.toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ), //currentPrice.currentPrice;
                                      subtitle: Text(
                                        "${coin.item!.name!}#${coin.item!.marketCapRank!}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    //buildChart(context, priceData, index)
                                  ],
                                )),
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
