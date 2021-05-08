

import 'package:shared_preferences/shared_preferences.dart';

var sesScore = "score";
var sesLeftAttempt= "leftAttempt";









Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
saveString(String key, String value) async {

  SharedPreferences preferences = await _prefs;
  preferences.setString(key, value);
}

saveBool(String key, bool value) async {
  SharedPreferences preferences = await _prefs;
  preferences.setBool(key, value);
}

saveInt(String key, int value) async {
  SharedPreferences preferences = await _prefs;
  preferences.setInt(key, value);
}


getSession(String key) async{

  SharedPreferences preferences = await _prefs;
  return preferences.get(key);
}

getSessionB(String key) async{

  SharedPreferences preferences = await _prefs;
  return preferences.getBool(key)?? false;
}


removeSession() async{

  SharedPreferences preferences = await _prefs;
  await preferences.remove(sesScore);
  await preferences.remove(sesLeftAttempt);
  //await preferences.clear();




}