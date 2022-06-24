// To parse this JSON data, do
//
//     final trendingCryptoModelModel = trendingCryptoModelModelFromJson(jsonString);

import 'dart:convert';

TrendingCryptoModelModel trendingCryptoModelModelFromJson(String str) =>
    TrendingCryptoModelModel.fromJson(json.decode(str));

String trendingCryptoModelModelToJson(TrendingCryptoModelModel data) =>
    json.encode(data.toJson());

class TrendingCryptoModelModel {
  TrendingCryptoModelModel({
    this.coins,
    this.exchanges,
  });

  List<Coin>? coins;
  List<dynamic>? exchanges;

  factory TrendingCryptoModelModel.fromJson(Map<String, dynamic> json) =>
      TrendingCryptoModelModel(
        coins: List<Coin>.from(json["coins"].map((x) => Coin.fromJson(x))),
        exchanges: List<dynamic>.from(json["exchanges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "coins": List<dynamic>.from(coins!.map((x) => x.toJson())),
        "exchanges": List<dynamic>.from(exchanges!.map((x) => x)),
      };
}

class Coin {
  Coin({
    this.item,
  });

  Item? item;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        item: Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": item!.toJson(),
      };
}

class Item {
  Item({
    this.id,
    this.coinId,
    this.name,
    this.symbol,
    this.marketCapRank,
    this.thumb,
    this.small,
    this.large,
    this.slug,
    this.priceBtc,
    this.score,
  });

  String? id;
  int? coinId;
  String? name;
  String? symbol;
  int? marketCapRank;
  String? thumb;
  String? small;
  String? large;
  String? slug;
  double? priceBtc;
  int? score;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        coinId: json["coin_id"],
        name: json["name"],
        symbol: json["symbol"],
        marketCapRank: json["market_cap_rank"],
        thumb: json["thumb"],
        small: json["small"],
        large: json["large"],
        slug: json["slug"],
        priceBtc: json["price_btc"].toDouble(),
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coin_id": coinId,
        "name": name,
        "symbol": symbol,
        "market_cap_rank": marketCapRank,
        "thumb": thumb,
        "small": small,
        "large": large,
        "slug": slug,
        "price_btc": priceBtc,
        "score": score,
      };
}
