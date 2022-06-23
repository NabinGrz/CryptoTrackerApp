// To parse this JSON data, do
//
//     final priceChartModel = priceChartModelFromJson(jsonString);

import 'dart:convert';

PriceChartModel priceChartModelFromJson(String str) =>
    PriceChartModel.fromJson(json.decode(str));

String priceChartModelToJson(PriceChartModel data) =>
    json.encode(data.toJson());

class PriceChartModel {
  PriceChartModel({
    this.prices,
  });

  List<List<double>>? prices;

  factory PriceChartModel.fromJson(Map<String, dynamic> json) =>
      PriceChartModel(
        prices: List<List<double>>.from(json["prices"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "prices": List<dynamic>.from(
            prices!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
