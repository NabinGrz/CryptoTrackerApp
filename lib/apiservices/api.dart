import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
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
}
