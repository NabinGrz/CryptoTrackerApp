import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProv.market.length,
                        itemBuilder: (context, index) {
                          CryptoCurrencyModel crypto = marketProv.market[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(id: crypto.id!);
                                },
                              ));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(crypto.image!),
                              ),
                              title: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${crypto.name!} #${crypto.marketCapRank!}",
                                      style: const TextStyle(
                                          //color: Colors.blue,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 19),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        marketProv.addFavourite(crypto);
                                      },
                                      icon: (crypto.isFavourite == false)
                                          ? const Icon(
                                              Icons.favorite_border_outlined,
                                              size: 19,
                                            )
                                          : const Icon(
                                              Icons.favorite,
                                              size: 19,
                                              color: Colors.red,
                                            ))
                                ],
                              ),
                              subtitle: Text(crypto.symbol!.toUpperCase()),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${crypto.currentPrice!.toString()} USD",
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      double priceChange =
                                          crypto.priceChange24H!;
                                      double priceChangePercentage =
                                          crypto.priceChangePercentage24H!;

                                      if (priceChange < 0) {
                                        return Text(
                                          "(${priceChangePercentage.toStringAsFixed(3)}%) ${priceChange.toStringAsFixed(2)} USD",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 236, 59),
                                              fontWeight: FontWeight.w500),
                                        );
                                      } else {
                                        return Text(
                                          "(${priceChangePercentage.toStringAsFixed(3)}%) ${priceChange.toStringAsFixed(2)} USD",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 236, 51, 0),
                                              fontWeight: FontWeight.w500),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return const Text("No Data");
          }
        }
        //CryptoCurrencyModel crypto =
        return Container();
      },
    );
  }
}
