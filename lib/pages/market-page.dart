import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/pages/trending-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/trending-crypto-provider.dart';
import 'package:cryptotrackerapp/widgets/market-list-tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TrendingCryptoProvider trendingCryptoProvider =
        Provider.of<TrendingCryptoProvider>(context, listen: false);
    return Consumer<MarketProvider>(
      builder: (context, marketProv, child) {
        if (marketProv.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        } else {
          if (marketProv.market.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProv.fetchData();
                await trendingCryptoProvider.fetchTrendingCrypto();
              },
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 10),
                      child: Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TrendingCryptoPage(
                      cryptoCurrencyModel:
                          marketProv.market[marketProv.coinIndex]),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 10),
                      child: Text(
                        "Coins",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProv.market.length,
                        itemBuilder: (context, index) {
                          CryptoCurrencyModel cryptoCurrencyModel =
                              marketProv.market[index];
                          return CryptoTileList(
                              cryptoCurrencyModel: cryptoCurrencyModel);
                        }),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No Crypto Found"));
          }
        }
        //CryptoCurrencyModel crypto =
        return Container();
      },
    );
  }
}
