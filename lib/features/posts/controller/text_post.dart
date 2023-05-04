import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';
import 'package:http/http.dart' as http;

final uploadTextProvider = Provider.autoDispose<TextPost>((ref) {
  return TextPost();
});
final uploadFilePppp = FutureProvider.autoDispose((ref) async {
  final file = ref.watch(uploadTextProvider);
  return file;
});

class TextPost {
  final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance(); // final

  final dio = Dio();

  Future<void> textPost(
      {required String content, required BuildContext context}) async {
    final SharedPreferences prefs = await _prefs;

    var data = {
      'content': content,
      'type': '1',
      'user_id': prefs.getString('id'),
      'section_id': prefs.getString('section_id') ?? 0,
      'colloge_id': prefs.getString('colloge_id'),
    };
    // Response response;
    // response = await dio.post(
    //   '${ApiUrl}posts/store/'.toString(),
    //   queryParameters: data,
    //   options: Options(headers: {
    //     'Authorization': 'Bearer ${prefs.getString('token')}',
    //     "Accept": "application/json"
    //   }),
    // );

    try {
      final response = await http.post(
        Uri.parse('${ApiUrl}posts/store'.toString()),
        body: data,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          "Accept": "application/json"
        },
      );
      print('ok');
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('the errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror  $e');
    }
    // ignore: use_build_context_synchronously
  }
}
