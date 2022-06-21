import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:flutter/cupertino.dart';
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
        return Center(child: Text(favourites.length.toString()));
      },
    );
  }
}
