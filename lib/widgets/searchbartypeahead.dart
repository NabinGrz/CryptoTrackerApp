import 'package:cryptotrackerapp/model/cryptocurrencymodel.dart';
import 'package:cryptotrackerapp/pages/details-page.dart';
import 'package:cryptotrackerapp/provider/market-provider.dart';
import 'package:cryptotrackerapp/provider/theme-provider.dart';
import 'package:cryptotrackerapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

Widget buildTypeSuggestionField(
    MarketProvider marketProv, BuildContext context) {
  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
      return TypeAheadField(
          getImmediateSuggestions: true,
          textFieldConfiguration: TextFieldConfiguration(
            enabled: true,
            style: DefaultTextStyle.of(context).style,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: textColor1,
              ),
              filled: true,
              fillColor: (themeProvider.themeMode == ThemeMode.light)
                  ? Colors.white
                  : const Color(0xff39314d),
              hintText: "Search cryptocurrency....",
              hintStyle:
                  TextStyle(color: textColor1, fontWeight: FontWeight.w600),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (themeProvider.themeMode != ThemeMode.light)
                        ? const Color.fromARGB(255, 116, 114, 114)
                        : const Color.fromARGB(255, 194, 193, 193),
                    width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: (themeProvider.themeMode != ThemeMode.light)
                        ? const Color.fromARGB(255, 116, 114, 114)
                        : const Color.fromARGB(255, 194, 193, 193),
                    width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
              color: (themeProvider.themeMode == ThemeMode.light)
                  ? Colors.white
                  : const Color(0xff39314d),
              //elevation: 100.0

              borderRadius: const BorderRadius.only(
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
    },
  );
}
