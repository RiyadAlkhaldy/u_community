import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_community/core/utils/utils.dart';

import '../../../core/constant.dart';
// import 'package:http/http.dart' as http;

// final uploadTextProvider = Provider.autoDispose<TextPost>((ref) {
//   return TextPost();
// });
final uploadTextProvider = StateProvider<TextPost>((ref) {
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
      {required String content,
      required BuildContext context,
      // ignore: non_constant_identifier_names
      String? colloge_id}) async {
    final SharedPreferences prefs = await _prefs;
    String? sectionId = prefs.getString('section_id');
    Map<String, dynamic> data;
    // print(sectionId! != null);
    if (content.isNotEmpty) {
      if (sectionId != null && sectionId.length <= 2) {
        data = {
          'content': content,
          'type': 1,
          'user_id': prefs.getString('id'),
          'section_id': sectionId,
          'colloge_id': int.parse(prefs.getString('type')!) >= 3
              ? colloge_id
              : prefs.getString('colloge_id'),
        };
      } else {
        data = {
          'content': content,
          'type': 1,
          'user_id': prefs.getString('id'),
          'colloge_id': int.parse(prefs.getString('type')!) >= 3
              ? colloge_id
              : prefs.getString('colloge_id'),
        };
      }

      if (kDebugMode) {
        print(data);
      }
      try {
        Response response;
        response = await dio.post(
          '${ApiUrl}posts/create/'.toString(),
          queryParameters: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${prefs.getString('token')}',
            "Accept": "application/json"
          }),
        );
        data.clear();
        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          Navigator.maybePop(context);
        }
      } catch (e) {
        if (kDebugMode) {
          print('the errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror  $e');
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: 'the content is empty ');
    }
  }
}
