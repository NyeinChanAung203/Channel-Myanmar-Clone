import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  Future<void> addToFavorite(List<String> favList) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setStringList('fav', favList);
  }

  Future<List<String>?> getFavoriteList() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList('fav');
  }
}
