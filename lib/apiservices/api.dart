import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:cryptotrackerapp/model/trendingcryptomodel.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<List<CryptoCurrencyModel>> getMarketData() async {
    try {
      var myUrl = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false",
      );
      var response = await http.get(myUrl);
      var data = response.body;
      var market = cryptoCurrencyModelFromJson(data.toString());
      return market;
    } catch (exc) {
      return [];
    }
  }

  static Future<PriceChartModel?> getMarketDataOfCrypto(String id) async {
    try {
      var myUrl = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=usd&days=29",
      );
      var response = await http.get(myUrl);
      var data = response.body;
      var marketChart = priceChartModelFromJson(data.toString());
      return marketChart;
    } catch (exc) {
      return null;
    }
  }

  static Future<List<Coin?>> getTrendingCrypto() async {
    try {
      var myUrl = Uri.parse(
        "https://api.coingecko.com/api/v3/search/trending",
      );
      var response = await http.get(myUrl);
      var data = response.body;
      var trending = trendingCryptoModelModelFromJson(data.toString());
      return trending.coins!.toList();
    } catch (exc) {
      return [];
    }
  }
}


/**
 double.parse(getChartData()[0]
                                                    .toString()) >
                                                double.parse(getChartData()[6]
                                                    .toString())
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xff23b6e6),
                                                  Color(0xff02d39a)
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                stops: [0.4, 0.7],
                                                tileMode: TileMode.repeated,
                                              )
                                            : const LinearGradient(
                                                colors: [
                                                  Color(0xff23b6e6),
                                                  Color(0xff02d39a)
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                stops: [0.4, 0.7],
                                                tileMode: TileMode.repeated,
                                              ),
 */