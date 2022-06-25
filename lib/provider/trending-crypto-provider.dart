import 'package:cryptotrackerapp/apiservices/api.dart';
import 'package:cryptotrackerapp/model/trendingcryptomodel.dart';
import 'package:flutter/cupertino.dart';

class TrendingCryptoProvider extends ChangeNotifier {
  List<Coin?> trendingCrypto = [];
  bool isLoading = true;
  bool isHigh = false;
  TrendingCryptoProvider() {
    fetchTrendingCrypto();
  }
  Future<void> fetchTrendingCrypto() async {
    List<Coin?> trendingCryptos = await API.getTrendingCrypto();
    trendingCrypto = trendingCryptos;

    isLoading = false;
    notifyListeners();
  }
}
