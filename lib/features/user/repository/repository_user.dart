import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../auth/models/user_response.dart';

final getUser = StateProvider((ref) => UserDetailes());

class UserDetailes {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();
  // Future<User>

  Future<User?> getUserData() async {
    SharedPreferences prefs = await _prefs;

    Response response;
    User? user;

    try {
      response = await dio.get(
        '${ApiUrl}auth/me',
        options: Options(headers: {
          'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
          "Accept": "application/json"
        }),
      );
      if (kDebugMode) {
        print(response.data);
      }
      user = User.fromMap(response.data);
    } catch (e) {
      print(e);
    }
    return user;
  }
}
