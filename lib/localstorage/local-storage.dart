import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> setTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString("theme");
    return theme;
  }

  static Future<bool> addFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList("favourites") ?? [];
    favourites.add(id);
    var result =
        await sharedPreferences.setStringList("favourites", favourites);
    return result;
  }

  static Future<List<String>> fetchFavourite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList("favourites") ?? [];

    return favourites;
  }

  static Future<bool> removeFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList("favourites") ?? [];
    favourites.remove(id);
    var result =
        await sharedPreferences.setStringList("favourites", favourites);
    return result;
  }
}
