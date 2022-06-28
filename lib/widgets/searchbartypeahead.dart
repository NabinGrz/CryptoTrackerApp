import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

Widget buildTypeSuggestionField(
    MarketProvider marketProv, BuildContext context) {
  return TypeAheadField(
      getImmediateSuggestions: true,
      textFieldConfiguration: TextFieldConfiguration(
        style: DefaultTextStyle.of(context).style,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: textColor1,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search cryptocurrency....",
          hintStyle: TextStyle(color: textColor1, fontWeight: FontWeight.w600),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
          color: Colors.white,
          //elevation: 100.0

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      debounceDuration: const Duration(milliseconds: 400),
      suggestionsCallback: (val) {
        return marketProv.market
            .where((element) => element.id!.contains(val.toLowerCase()));
      },
      itemBuilder: (context, CryptoCurrencyModel currencyModel) {
        return ListTile(
          leading: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(currencyModel.image!),
          ),
          title: Text(currencyModel.name.toString()),
        );
      },
      onSuggestionSelected: (CryptoCurrencyModel currencyModel) async {
        var data = await marketProv.fetchMarketChart(currencyModel.id!);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailPage(id: currencyModel.id!, priceData: data);
          },
        ));
      });
}
