import 'package:cryptotrackerapp/apiservices/api.dart';
import 'package:cryptotrackerapp/localstorage/local-storage.dart';
import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isDark = false;
  List<CryptoCurrencyModel> market = [];
  MarketProvider() {
    fetchData();
    // API.getMarketData();
  }
  void checkTheme(bool check) {
    if (check) {
      isDark = true;
      notifyListeners();
    } else {
      isDark = false;
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    List<CryptoCurrencyModel> markets = await API.getMarketData();
    List<String> favourites = await LocalStorage.fetchFavourite();
    var m = Map.fromIterable(
      markets,
      key: (element) => element.toString(),
    );
    //for (var e in markets) {
    // CryptoCurrencyModel crypto = CryptoCurrencyModel.fromJson(m);
    // if (favourites.contains(crypto.id)) {
    //   crypto.isFavourite = true;
    //   //markets[];
    // }
    // }

    market = markets;
    isLoading = false;
    notifyListeners();
  }

  getMarketByID(String id) {
    var crypto = market.where((data) => data.id == id).toList()[0];
    return crypto;
  }

  void addFavourite(CryptoCurrencyModel crypto) async {
    int index = market.indexOf(crypto);
    market[index].isFavourite = true;
    await LocalStorage.addFavourite(index.toString());
    notifyListeners();
  }

  void removeFavourite(CryptoCurrencyModel crypto) async {
    int index = market.indexOf(crypto);
    market[index].isFavourite = false;
    await LocalStorage.removeFavourite(index.toString());
    notifyListeners();
  }
}
