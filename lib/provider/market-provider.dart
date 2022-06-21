import 'package:cryptotrackerapp/apiservices/api.dart';
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
    List<CryptoCurrencyModel> temp = [];
    market = markets;
    isLoading = false;
    notifyListeners();
  }

  getMarketByID(String id) {
    var crypto = market.where((data) => data.id == id).toList()[0];
    return crypto;
  }
}
