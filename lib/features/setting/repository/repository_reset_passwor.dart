import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_community/models/user_response_auth.dart';
import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../core/utils/utils.dart';
import '../../auth/repository/auth_repository.dart';

final resetPasswordRepositoryProvider =
    StateProvider.family((ref, Map map) async {
  return await resetPaaswrd(map['data'], map['context'], ref);
});

// function reset password
Future<void> resetPaaswrd(
    Map<String, dynamic> map, BuildContext context, ref) async {
  Dio dio = Dio();
  SharedPreferences? prefs;
  await SharedPreferences.getInstance().then((value) async {
    prefs = value;
    final userId = value.getString('id');
  });
  Map<String, dynamic> data = {
    'id': prefs!.getString(UserEnum.id.type),
    'password': map['password'],
    'new_password': map['new_password'],
    'email': prefs!.getString(UserEnum.email.type),
  };
  if (kDebugMode) {
    print(data);
  }
  Response? response;

  try {
    response = await dio.post(
      '${ApiUrl}auth/reset-password/',
      options: Options(headers: {
        'authorization': 'Bearer ${prefs!.getString(UserEnum.token.type)}',
        "Accept": "application/json"
      }),
      queryParameters: data,
    );
    if (kDebugMode) {
      print('ok');
    }
    if (response.data['status'] == 'success') {
      UserResponseLogin userResponseLogin =
          UserResponseLogin.fromMap(response.data as Map<String, dynamic>);
      print(userResponseLogin);

      await ref!.watch(setUserProviderfromSharedPrefernces(userResponseLogin));

// ignore: use_build_context_synchronously
      showSnackBar(context: context, content: response.data['message']);

      // ignore: use_build_context_synchronously
      Navigator.maybePop(context);
    } else if (response.data['status'] == 'error') {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, content: response.data['message'].toString());
    }
  } catch (e) {
    // ignore: use_build_context_synchronously
    showSnackBar(
        context: context, content: response!.data['message'].toString());
    if (kDebugMode) {
      print(e);
    }
  }
}

