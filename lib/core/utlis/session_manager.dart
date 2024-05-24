import 'dart:convert';
import 'package:emschool_dashboard/models/user_response.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_model.dart';

class SessionManager {
  Future<void> setUserData(Map<String, dynamic> user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('userData', json.encode(user));
  }

  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString('userData');
    if (data != null) {
      Map<String, dynamic> json = jsonDecode(pref.getString('userData')!);
      currentUser = UserResponse.fromJson(json);

      if (kDebugMode) {
        print(currentUser!.user.id);
      }
    }

    // AppModel.lang = pref.getString('lang') ?? AppModel.langAr;
  }

  Future singOut({context}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('userData');
    // currentUser = null;
    // pushPage(context,const SelectTypeAccountScreen());
  }

  Future<void> setData(String key, String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(key, data);
  }
}
