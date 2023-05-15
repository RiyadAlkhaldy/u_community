import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../core/utils/utils.dart';
import '../../../main.dart';
import '../../../models/colloge_model.dart';
import '../../../models/user_response_auth.dart';
import '../screens/message_auth_teacher.dart';

final authProvider = StateProvider((ref) => AuthRepository());
final getUserProviderfromSharedPrefernces = StateProvider((ref) async {
  Map<String, dynamic> myuser = {};
  await SharedPreferences.getInstance().then((user) {
    myuser[UserEnum.token.type] = user.getString(UserEnum.token.type);
    myuser[UserEnum.id.type] = user.getString(UserEnum.id.type);
    myuser[UserEnum.name.type] = user.getString(UserEnum.name.type);
    myuser[UserEnum.img.type] = user.getString(UserEnum.img.type);
    myuser[UserEnum.email.type] = user.getString(UserEnum.email.type);
    myuser[UserEnum.typeUser.type] = user.getString(UserEnum.typeUser.type);
    myuser[UserEnum.collogeId.type] = user.getString(UserEnum.collogeId.type);
    myuser[UserEnum.sectionId.type] = user.getString(UserEnum.sectionId.type);
  });
  return myuser;
});
final setUserProviderfromSharedPrefernces =
    StateProvider.family((ref, UserResponseLogin userResponseLogin) async {
  // Map<String, dynamic> myuser = {};
  await SharedPreferences.getInstance().then((prefs) async {
    await prefs.setString(
        UserEnum.token.type, userResponseLogin.authorisation.token.toString());
    await prefs.setString(
        UserEnum.name.type, userResponseLogin.user!.name.toString());
    await prefs.setString(
        UserEnum.email.type, userResponseLogin.user!.email.toString());
    if (userResponseLogin.user!.sectionId != null) {
      await prefs.setString(UserEnum.sectionId.type,
          userResponseLogin.user!.sectionId.toString());
    }
    if (userResponseLogin.user!.collogeId != null) {
      await prefs.setString(UserEnum.collogeId.type,
          userResponseLogin.user!.collogeId.toString());
    }
    await prefs.setString(
        UserEnum.id.type, userResponseLogin.user!.id.toString());
    if (userResponseLogin.user!.img != null) {
      await prefs.setString(
          UserEnum.img.type, userResponseLogin.user!.img.toString());
    }
    await prefs.setString(
        UserEnum.typeUser.type, userResponseLogin.user!.type.toString());
  });
});

class AuthRepository {
  late UserResponseLogin userResponseLogin;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final dio = Dio();
  Future<List<Colloge>?> getAllColloges(context) async {
    List<Colloge> colloges;
    Response response;
    ResponseColloge responseColloge;
    try {
      response = await dio.post(
        '${ApiUrl}colloge/get-all-colloge/',
      );
      print(response.data);

      if (response.statusCode == 200) {
        responseColloge = ResponseColloge.fromMap(response.data);
        // responseColloge = ResponseColloge.fromMap(response.data);
        print(responseColloge.colloge![0].name);

        return responseColloge.colloge;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      if (kDebugMode) print(e.toString());
    }
  }

  Future<void> registerStudent(
      {required String email,
      required final String uniId,
      required String iDNumber,
      int type = 1,
      required BuildContext context}) async {
    Map<String, dynamic> data = {
      'email': email,
      'university_id': uniId,
      'id_number': iDNumber,
      'type': type,
    };
    //  SharedPreferences.getInstance()

    try {
      final response = await dio.post(
        '${ApiUrl}auth/register/',
        queryParameters: data,
      );
      // ignore: use_build_context_synchronously
      if (_checkIfUserRegsterBefore(response, context)) {
        if (kDebugMode) print('It is regisger before');
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('ok');
          print(response.data);
        }
        userResponseLogin =
            UserResponseLogin.fromMap(response.data as Map<String, dynamic>);
        print(
            'tokennnnnnnnnnnnnnnnnnnnnnnnnnnnn${userResponseLogin.authorisation.token}');
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('token', userResponseLogin.authorisation.token!);
        await prefs.setString(UserEnum.name.type, userResponseLogin.user!.name);
        await prefs.setString(
            UserEnum.email.type, userResponseLogin.user!.email);
        await prefs.setString(UserEnum.sectionId.type,
            userResponseLogin.user!.sectionId.toString());
        await prefs.setString(UserEnum.collogeId.type,
            userResponseLogin.user!.collogeId.toString());
        await prefs.setString(
            UserEnum.id.type, userResponseLogin.user!.id.toString());
        await prefs.setString(
            UserEnum.img.type, userResponseLogin.user!.img.toString());
        await prefs.setString(
            UserEnum.typeUser.type, userResponseLogin.user!.type.toString());
        if (kDebugMode) {
          print(
              'tokennnnnnnnnnnnnnnnnnnnnnnnnnnnn${userResponseLogin.authorisation.token}');
          print(userResponseLogin);
        }
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          MyApp.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      if (kDebugMode) print(e.toString());
    }
  }
  // ignore: use_build_context_synchronously

  Future<void> registerTeacher(
      {required String email,
      required String name,
      required String password,
      required String iDNumber,
      required String collogeId,
      int type = 2,
      required BuildContext context}) async {
    Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'password': password,
      'id_number': iDNumber,
      'colloge_id': collogeId,
      'type': type,
    };
    try {
      Response response;
      response = await dio.post(
        '${ApiUrl}auth-temp/create-teacher-temp/',
        queryParameters: data,
      );
      // ignore: use_build_context_synchronously
      if (_checkIfUserRegsterBefore(response, context)) {
        if (kDebugMode) print('It is regisger before');
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('ok');
          print(response.data);
        }
        if (kDebugMode) {}
      }
      // ignore: use_build_context_synchronously
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          MessageAuthTeacher.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      if (kDebugMode) print(e.toString());
    }
  }

  bool _checkIfUserRegsterBefore([Response? response, BuildContext? context]) {
    if (response!.statusCode == 200 && response.data['status'] == 'error') {
      // var data = json.decode(response.data);
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(content: Text(response.data['message'].toString())));
      return true;
    }
    return false;
  }

  Future<void> registerAsAdmin(
      {required String email,
      required final String password,
      required String iDNumber,
      required BuildContext context}) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'id_number': iDNumber,
    };
    try {
      Response response;
      response = await dio.post(
        '${ApiUrl}auth/register-admin/',
        queryParameters: data,
      );
      if (_checkIfUserRegsterBefore(response, context)) {
        if (kDebugMode) print('It is regisger before');
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('ok');
          print(response.data);
        }
        userResponseLogin = UserResponseLogin.fromMap(response.data);
        if (kDebugMode) {
          print(
              'tokennnnnnnnnnnnnnnnnnnnnnnnnnnnn${userResponseLogin.authorisation.token}');
        }
        await SharedPreferences.getInstance().then((prefs) async {
          await prefs.setString(
              'token', userResponseLogin.authorisation.token!);
          await prefs.setString(
              UserEnum.name.type, userResponseLogin.user!.name);
          await prefs.setString(
              UserEnum.email.type, userResponseLogin.user!.email);
          await prefs.setString(UserEnum.sectionId.type,
              userResponseLogin.user!.sectionId.toString());
          await prefs.setString(UserEnum.collogeId.type,
              userResponseLogin.user!.collogeId.toString());
          await prefs.setString(
              UserEnum.id.type, userResponseLogin.user!.id.toString());
          await prefs.setString(
              UserEnum.img.type, userResponseLogin.user!.img.toString());
          await prefs.setString(
              UserEnum.typeUser.type, userResponseLogin.user!.type.toString());
        });
        if (kDebugMode) {
          print(
              'tokennnnnnnnnnnnnnnnnnnnnnnnnnnnn${userResponseLogin.authorisation.token}');
          print(userResponseLogin);
        }
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          MyApp.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      if (kDebugMode) print('ther is rong roooooooooooong  ${e.toString()}');
    }
    //  on DioError catch (e) {
    //   if (e.response!.statusCode == 422) {
    //     print(e.response!.data);
    //   }
    // } on DioError catch (e) {
    //   if (e.response!.statusCode == 500) {
    //     if (kDebugMode) {
    //       print(e.response!.data);
    //     }
    //   }
    // }
    // ignore: use_build_context_synchronously
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    print(data);
    try {
      Response response;
      response = await dio.post(
        '${ApiUrl}auth/login/',
        queryParameters: data,
        options: Options(headers: {"Accept": "application/json"}),
      );
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        print(response.data);
        userResponseLogin =
            UserResponseLogin.fromMap(response.data as Map<String, dynamic>);
        print(
            'tokennnnnnnnnnnnnnnnnnnnnnnnnnnnn${userResponseLogin.authorisation.token}');
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('token', userResponseLogin.authorisation.token!);
        await prefs.setString(UserEnum.name.type, userResponseLogin.user!.name);
        await prefs.setString(
            UserEnum.email.type, userResponseLogin.user!.email);
        await prefs.setString(UserEnum.sectionId.type,
            userResponseLogin.user!.sectionId.toString());
        await prefs.setString(UserEnum.collogeId.type,
            userResponseLogin.user!.collogeId.toString());
        await prefs.setString(
            UserEnum.id.type, userResponseLogin.user!.id.toString());
        await prefs.setString(
            UserEnum.img.type, userResponseLogin.user!.img.toString());
        await prefs.setString(
            UserEnum.typeUser.type, userResponseLogin.user!.type.toString());

        print(userResponseLogin);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
          context,
          MyApp.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      print('errrrrrrrrrr${e.toString()}');
      showSnackBar(
          context: context,
          content: 'check from password or email is corrects $e');
      if (kDebugMode) print(e.toString());
    }
    // ignore: use_build_context_synchronously
  }

  Future<void> logout({required BuildContext context}) async {
    SharedPreferences prefs = await _prefs;

    try {
      Response response;
      response = await dio.post(
        '${ApiUrl}auth/logout/',
        options: Options(headers: {
          'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
          "Accept": "application/json"
        }),
      );
      // clear sharedprefernces
      await prefs.clear();
      if (kDebugMode) {
        print('ok');
        print(response.data);
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, content: response.data.toString());
      }
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        MyApp.routeName,
        // (route) => false,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
      if (kDebugMode) print(e.toString());
    }
    // ignore: use_build_context_synchronously
  }

  void websok() async {
    var channel = await IOWebSocketChannel.connect(
        "ws://10.0.2.2:6001/app/laravelWebsocketKey");
// channel.stream.l
    channel.sink.add(json.encode({
      "event": "NotificationRecieved",
      "data": {"channel": "Notification"}
    }));
    // channel.stream.asBroadcastStream();

    channel.stream.listen((_data) {
      print(_data.toString());
    }, onError: (error) {
      print("Socket: error => " + error.toString());
      channel.sink.close();
    }, onDone: () {
      print("Socket: done");
    });
  }
}
