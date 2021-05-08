

import 'package:shared_preferences/shared_preferences.dart';

var sesPhoneNumber = "phoneNumber";
var sesIsLogin = "isLogin";
var sesProfileInfo = "sesProfileInfo";





Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
saveString(String key, String value) async {

  SharedPreferences preferences = await _prefs;
  preferences.setString(key, value);
}

saveBool(String key, bool value) async {
  SharedPreferences preferences = await _prefs;
  preferences.setBool(key, value);
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
  preferences.clear();




}