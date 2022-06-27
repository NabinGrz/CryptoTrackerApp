import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoTileList extends StatefulWidget {
  final CryptoCurrencyModel cryptoCurrencyModel;
  Widget? chartWidget;
  CryptoTileList(
      {Key? key, required this.cryptoCurrencyModel, this.chartWidget})
      : super(key: key);

  @override
  State<CryptoTileList> createState() => _CryptoTileListState();
}

class _CryptoTileListState extends State<CryptoTileList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _sizeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProv =
        Provider.of<MarketProvider>(context, listen: false);
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
      child: ListTile(
        onTap: () async {
          print("NAIUNB");
          var data =
              await marketProv.fetchMarketChart(widget.cryptoCurrencyModel.id!);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPage(
                  id: widget.cryptoCurrencyModel.id!, priceData: data);
            },
          ));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(widget.cryptoCurrencyModel.image!),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                "${widget.cryptoCurrencyModel.name!} #${widget.cryptoCurrencyModel.marketCapRank!}",
                style: const TextStyle(
                    //color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 19),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            (widget.cryptoCurrencyModel.isFavourite == false)
                ? GestureDetector(
                    onTap: () {
                      marketProv.addFavourite(widget.cryptoCurrencyModel);
                    },
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.bounceInOut,
                      duration: const Duration(milliseconds: 700),
                      builder: (context, double val, child) {
                        return Opacity(
                          opacity: val,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            size: val * 20,
                          ),
                        );
                      },
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      marketProv.removeFavourite(widget.cryptoCurrencyModel);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, _) {
                        return TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          curve: Curves.bounceInOut,
                          duration: const Duration(milliseconds: 700),
                          builder: (context, double val, child) {
                            return Opacity(
                              opacity: val,
                              child: Icon(
                                Icons.favorite,
                                size: val * 20,
                                color: Colors.red,
                              ),
                            );
                          },
                        );
                      },
                    )),
          ],
        ),
        subtitle: Text(widget.cryptoCurrencyModel.symbol!.toUpperCase()),
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
                double priceChange = widget.cryptoCurrencyModel.priceChange24H!;
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
