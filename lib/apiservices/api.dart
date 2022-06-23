import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/model/pricechartmodel.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<List<CryptoCurrencyModel>> getMarketData() async {
    try {
      var myUrl = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false",
      );
      var response = await http.get(myUrl);
      var data = response.body;
      var market = cryptoCurrencyModelFromJson(data.toString());
      return market;
    } catch (exc) {
      return [];
    }
  }

  //https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=1
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
}
