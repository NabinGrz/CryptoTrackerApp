import 'package:cryptotrackerapp/apiservices/api.dart';
import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider extends ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrencyModel> market = [];
  MarketProvider() {
    fetchData();
    // API.getMarketData();
  }
  Future<void> fetchData() async {
    List<CryptoCurrencyModel> markets = await API.getMarketData();
    List<CryptoCurrencyModel> temp = [];
    market = markets;
    isLoading = false;
    print("CAQLLED");
    notifyListeners();
  }
}
