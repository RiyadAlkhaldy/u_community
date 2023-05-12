import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../models/user_response_auth.dart';

final getUserDetailes = StateNotifierProvider<UserDetailes, User?>((ref) {
  final user = UserDetailes();

  return user;
});
final getUserDetailesFuture = FutureProvider((ref) async {
  final user = UserDetailes();
  // await user.initi();
  return await user.getUserData();
});
final getUserProviderProfile = FutureProvider<User>((ref) async {
  var user;
  await ref
      .watch(getUserDetailes.notifier)
      .getUserData()
      .then((value) async => user = value);
  // await user;
  return user;
});

class UserDetailes extends StateNotifier<User?> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();
  Response? response;
  User? user;
  UserDetailes() : super(null);
  // Future<User>
  Future<User?>? initi() async {
    return await getUserD().then((value) => state = value);
  }

  factory UserDetailes.init() {
    // initi();
    return UserDetailes();
  }
  getUserData() async {
    SharedPreferences prefs = await _prefs;
    final stat = await initi();
    print(state);
    state = state;
    return state;
    // try {
    //   response = await dio.get(
    //     '${ApiUrl}auth/me',
    //     options: Options(headers: {
    //       'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
    //       "Accept": "application/json"
    //     }),
    //   );
    //   if (kDebugMode) {
    //     print(response!.data);
    //   }
    //   user = User.fromMap(response!.data);
    //   if (kDebugMode) {
    //     print('the userrrrrrrrrrrrrrrrrrrrrrrrrrrrr $user');
    //   }
    //   return user;
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
    // return user;
  }
}

Future<User?> getUserD() async {
  Response? response;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;

  User? user;
  Dio dio = Dio();
  try {
    response = await dio.get(
      '${ApiUrl}auth/me',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
        "Accept": "application/json"
      }),
    );
    if (kDebugMode) {
      // print(response.data);
    }
    user = User.fromMap(response.data);
    if (kDebugMode) {
      print('the userrrrrrrrrrrrrrrrrrrrrrrrrrrrr $user');
    }
    return user;
  } catch (e) {
    if (kDebugMode) {
      print('rerrrrrrrrrrrrrrrrrrrruser $e');
    }
  }
  return user;
}
