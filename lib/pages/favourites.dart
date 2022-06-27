import 'package:cryptotrackerapp/localstorage/local-storage.dart';
import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/widgets/favourite-market-list-tile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late MarketProvider marketProv;
  @override
  void initState() {
    marketProv = Provider.of<MarketProvider>(context, listen: false);
    super.initState();
  }

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
                      //buildChart(context, priceData, index),
                      FavouriteCryptoTileList(
                        cryptoCurrencyModel: cryptoCurrencyModel,
                      )
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
