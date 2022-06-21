// To parse this JSON data, do
//
//     final cryptoCurrencyModel = cryptoCurrencyModelFromJson(jsonString);

import 'dart:convert';

List<CryptoCurrencyModel> cryptoCurrencyModelFromJson(String str) =>
    List<CryptoCurrencyModel>.from(
        json.decode(str).map((x) => CryptoCurrencyModel.fromJson(x)));

String cryptoCurrencyModelToJson(List<CryptoCurrencyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoCurrencyModel {
  CryptoCurrencyModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24H,
    this.low24H,
    this.priceChange24H,
    this.priceChangePercentage24H,
    this.marketCapChange24H,
    this.marketCapChangePercentage24H,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.roi,
    this.lastUpdated,
  });

  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  int? marketCap;
  int? marketCapRank;
  int? fullyDilutedValuation;
  int? totalVolume;
  double? high24H;
  double? low24H;
  double? priceChange24H;
  double? priceChangePercentage24H;
  double? marketCapChange24H;
  double? marketCapChangePercentage24H;
  double? circulatingSupply;
  double? totalSupply;
  dynamic? maxSupply;
  double? ath;
  double? athChangePercentage;
  DateTime? athDate;
  double? atl;
  double? atlChangePercentage;
  DateTime? atlDate;
  Roi? roi;
  DateTime? lastUpdated;
  bool isFavourite = false;

  factory CryptoCurrencyModel.fromJson(Map<String, dynamic> map) =>
      CryptoCurrencyModel(
        id: map["id"],
        symbol: map["symbol"],
        name: map["name"],
        image: map["image"],
        currentPrice: map["current_price"].toDouble(),
        marketCap: map["market_cap"],
        marketCapRank: map["market_cap_rank"],
        fullyDilutedValuation: map["fully_diluted_valuation"],
        totalVolume: map["total_volume"],
        high24H: map["high_24h"].toDouble(),
        low24H: map["low_24h"].toDouble(),
        priceChange24H: map["price_change_24h"].toDouble(),
        priceChangePercentage24H: map["price_change_percentage_24h"].toDouble(),
        marketCapChange24H: map["market_cap_change_24h"].toDouble(),
        marketCapChangePercentage24H:
            map["market_cap_change_percentage_24h"].toDouble(),
        circulatingSupply: map["circulating_supply"].toDouble(),
        totalSupply:
            map["total_supply"] == null ? null : map["total_supply"].toDouble(),
        maxSupply: map["max_supply"],
        ath: map["ath"].toDouble(),
        athChangePercentage: map["ath_change_percentage"].toDouble(),
        athDate: DateTime.parse(map["ath_date"]),
        atl: map["atl"].toDouble(),
        atlChangePercentage: map["atl_change_percentage"].toDouble(),
        atlDate: DateTime.parse(map["atl_date"]),
        roi: map["roi"] == null ? null : Roi.fromJson(map["roi"]),
        lastUpdated: DateTime.parse(map["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "fully_diluted_valuation": fullyDilutedValuation,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "price_change_percentage_24h": priceChangePercentage24H,
        "market_cap_change_24h": marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "ath": ath,
        "ath_change_percentage": athChangePercentage,
        "ath_date": athDate!.toIso8601String(),
        "atl": atl,
        "atl_change_percentage": atlChangePercentage,
        "atl_date": atlDate!.toIso8601String(),
        "roi": roi == null ? null : roi!.toJson(),
        "last_updated": lastUpdated!.toIso8601String(),
        "isFavourite": isFavourite
      };
}

class Roi {
  Roi({
    this.times,
    this.currency,
    this.percentage,
  });

  double? times;
  String? currency;
  double? percentage;

  factory Roi.fromJson(Map<String, dynamic> json) => Roi(
        times: json["times"].toDouble(),
        currency: json["currency"],
        percentage: json["percentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "times": times,
        "currency": currency,
        "percentage": percentage,
      };
}
