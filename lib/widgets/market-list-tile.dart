import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoTileList extends StatelessWidget {
  final CryptoCurrencyModel cryptoCurrencyModel;
  const CryptoTileList({Key? key, required this.cryptoCurrencyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProv =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailPage(id: cryptoCurrencyModel.id!);
          },
        ));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(cryptoCurrencyModel.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              "${cryptoCurrencyModel.name!} #${cryptoCurrencyModel.marketCapRank!}",
              style: const TextStyle(
                  //color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontSize: 19),
            ),
          ),
          (cryptoCurrencyModel.isFavourite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProv.addFavourite(cryptoCurrencyModel);
                  },
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    size: 19,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProv.removeFavourite(cryptoCurrencyModel);
                  },
                  child: const Icon(
                    Icons.favorite,
                    size: 19,
                    color: Colors.red,
                  )),
          // IconButton(
          //     onPressed: () {
          //       marketProv.addFavourite(crypto);
          //     },
          //     icon: (crypto.isFavourite == false)
          //         ? const Icon(
          //             Icons.favorite_border_outlined,
          //             size: 19,
          //           )
          //         : const Icon(
          //             Icons.favorite,
          //             size: 19,
          //             color: Colors.red,
          //           ))
        ],
      ),
      subtitle: Text(cryptoCurrencyModel.symbol!.toUpperCase()),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${cryptoCurrencyModel.currentPrice!.toString()} USD",
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Builder(
            builder: (context) {
              double priceChange = cryptoCurrencyModel.priceChange24H!;
              double priceChangePercentage =
                  cryptoCurrencyModel.priceChangePercentage24H!;

              if (priceChange < 0) {
                return Text(
                  "(${priceChangePercentage.toStringAsFixed(3)}%) ${priceChange.toStringAsFixed(2)} USD",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 236, 59),
                      fontWeight: FontWeight.w500),
                );
              } else {
                return Text(
                  "(${priceChangePercentage.toStringAsFixed(3)}%) ${priceChange.toStringAsFixed(2)} USD",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 236, 51, 0),
                      fontWeight: FontWeight.w500),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
