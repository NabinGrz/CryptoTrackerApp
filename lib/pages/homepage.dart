import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("BUILD WIDEGTS");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<MarketProvider>(
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
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: marketProv.market.length,
                            itemBuilder: (context, index) {
                              CryptoCurrencyModel crypto =
                                  marketProv.market[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(crypto.image!),
                                ),
                                title: Text(
                                  crypto.name!,
                                  style: const TextStyle(
                                      //color: Colors.blue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19),
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
                              );
                            }),
                      );
                    } else {
                      return const Text("No Data");
                    }
                  }
                  //CryptoCurrencyModel crypto =
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
