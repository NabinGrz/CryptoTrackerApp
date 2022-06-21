import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  String id;
  DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MarketProvider>(
        builder: (context, marketProvider, child) {
          CryptoCurrencyModel crypto = marketProvider.getMarketByID(widget.id);
          return ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(crypto.image!),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            crypto.name!,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ), //crypto.symbol!.toUpperCase()
                          Text(
                            "(${crypto.symbol!.toUpperCase()})",
                            style: const TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${crypto.currentPrice!} USD",
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
