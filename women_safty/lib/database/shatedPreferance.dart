import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefference {
  static SharedPreferences? _preferences;
  

  static init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future saveUserType(String key,String type) async {
    if (_preferences == null) await init();
    return await _preferences!.setString(key, type);
  }

  static Future<String>? getUserType(String key) async {
   if (_preferences == null) await init();
      return await _preferences!.getString(key) ?? "";
  }
  static Future<bool> deleteUserType(String key) async {

    if (_preferences == null) await init();
    
   
    return await _preferences!.remove(key);
  }
}
