import 'package:cryptotrackerapp/localstorage/local-storage.dart';
import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/widgets/market-list-tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProv, child) {
        List<CryptoCurrencyModel> favourites = marketProv.market
            .where(
              (element) => element.isFavourite == true,
            )
            .toList();
        if (favourites.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await LocalStorage.fetchFavourite();
            },
            child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  CryptoCurrencyModel cryptoCurrencyModel = favourites[index];
                  return Column(
                    children: [
                      CryptoTileList(cryptoCurrencyModel: cryptoCurrencyModel)
                    ],
                  );
                }),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Iconsax.box,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your favourite list is empty!!",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Explore crypto currencies and add them to favourites to show them here",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
            ],
          );
        }
      },
    );
  }
}
