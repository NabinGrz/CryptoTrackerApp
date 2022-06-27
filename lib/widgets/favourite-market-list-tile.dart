import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteCryptoTileList extends StatefulWidget {
  final CryptoCurrencyModel cryptoCurrencyModel;
  Widget? chartWidget;
  FavouriteCryptoTileList(
      {Key? key, required this.cryptoCurrencyModel, this.chartWidget})
      : super(key: key);

  @override
  State<FavouriteCryptoTileList> createState() =>
      _FavouriteCryptoTileListState();
}

class _FavouriteCryptoTileListState extends State<FavouriteCryptoTileList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  List<PriceData> priceData = [];
  late MarketProvider marketProv;
  var aData;
  @override
  void initState() {
    marketProv = Provider.of<MarketProvider>(context, listen: false);
    super.initState();
    getTrendChartData(widget.cryptoCurrencyModel.id!);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _sizeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: false);
  }

  Future<List<PriceData>> getTrendChartData(String id) async {
    PriceChartModel chartOfTrending = await marketProv.fetchMarketChart(id);
    try {
      List<PriceData> chartData = [];
      List<dynamic> datalistPrice = [];
      List<dynamic> datalistDate = [];
      List<dynamic> finalListDate = [];
      List<dynamic> finalListPrice = [];

      for (int i = 0; i < chartOfTrending.prices!.length; i++) {
        datalistPrice.addAll([chartOfTrending.prices![i][1]]);
        datalistDate.addAll([chartOfTrending.prices![i][0]]);
        finalListPrice = datalistPrice;
        finalListDate = datalistDate;
        priceData.add(
            PriceData(day: finalListDate[i], price: finalListPrice[i], id: id));
      }
      print(priceData);
      return priceData;
    } catch (ex) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProv =
        Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      height: getDeviceHeight(context) * 0.1,
      width: getDeviceWidth(context),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: themeProv.themeMode == ThemeMode.light
            ? Colors.white
            : const Color.fromARGB(255, 44, 45, 45),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      //color: Colors.white,

      //width: 800,
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          height: getDeviceHeight(context) * 0.3,
          width: getDeviceWidth(context),
          margin: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Color.fromARGB(255, 255, 3, 3)),
        ),
        onDismissed: (direction) {
          marketProv.removeFavourite(widget.cryptoCurrencyModel);
        },
        child: ListTile(
          onTap: () async {
            print("NAIUNB");
            var data = await marketProv
                .fetchMarketChart(widget.cryptoCurrencyModel.id!);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailPage(
                    id: widget.cryptoCurrencyModel.id!, priceData: data);
              },
            ));
          },
          leading: Text(
            "${widget.cryptoCurrencyModel.marketCapRank!}",
            style: const TextStyle(
                //color: Colors.blue,
                fontWeight: FontWeight.w400,
                fontSize: 19),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    NetworkImage(widget.cryptoCurrencyModel.image!),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cryptoCurrencyModel.name!,
                    style: const TextStyle(
                        //color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 19),
                  ),
                  Text(widget.cryptoCurrencyModel.symbol!.toUpperCase())
                ],
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.cryptoCurrencyModel.currentPrice!.toString()} \$",
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              const SizedBox(
                height: 5,
              ),
              Builder(
                builder: (context) {
                  double priceChange =
                      widget.cryptoCurrencyModel.priceChange24H!;
                  double priceChangePercentage =
                      widget.cryptoCurrencyModel.priceChangePercentage24H!;

                  if (priceChange > 0) {
                    return Text(
                      "+${priceChangePercentage.toStringAsFixed(3)}%",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 236, 59),
                          fontWeight: FontWeight.w500),
                    );
                  } else {
                    return Text(
                      "${priceChangePercentage.toStringAsFixed(3)}%",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 236, 51, 0),
                          fontWeight: FontWeight.w500),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PriceData {
  PriceData({required this.day, required this.price, required this.id});
  final double day;
  final double price;
  final String id;

  factory PriceData.fromJson(Map<String, dynamic> map) =>
      PriceData(day: map["day"], price: map["price"], id: map["id"]);
}
