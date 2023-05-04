// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant.dart';

final uploadFileProvider =
    StateProvider.autoDispose<UploadFileReposetitory>((ref) {
  return UploadFileReposetitory();
});
// final textPostProfider = FutureProvider((ref) async {
//   final up = ref.watch(uploadFileProvider);
//   return up;
// });
final uploadFilePppp = FutureProvider.autoDispose((ref) async {
  final file = ref.watch(uploadFileProvider).getFile();
  return file;
});

class UploadFileReposetitory {
  //this for text post
  final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance(); // final
//this for upload file
  // List<PlatformFile>? paths;
  PlatformFile? path;
  String? _extension;
  double progress = 0.0;
  String link = '';
  // var file;

  getFile() {
    if (path != null) {
      var _file = path;

      final p = _file!.path;
      final file = File(p.toString());
      print('this is the file $file');
      return file;
    }
    return null;
  }

  Future pickFiles({required FileType type}) async {
    // FilePicker.platform.pickFiles()
    try {
      path = (await FilePicker.platform.pickFiles(
        withReadStream: true,
        type: type,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            print('file status $status'),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files
          .single;
      if (kDebugMode) {
        // file = paths![0];
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Unsupported operation$e');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return path;
  }

  Future upload(
      {dynamic Function(double)? onUploadProgress,
      String? content,
      int? type,
      BuildContext? context,
      String urlCompelete = 'v1/file_upload'}) async {
    if (path != null) {
      final prefs = await _prefs;

      var _path = path!.path;
      if (kDebugMode) print('path $_path');
      String fileName = _path!.split('/').last;
      if (kDebugMode) print('fileName $fileName');
      String url = "$ApiUrl$urlCompelete"; // change it with your api url
      ChunkedUploader chunkedUploader = ChunkedUploader(
        Dio(
          BaseOptions(
            baseUrl: url,
            headers: {
              'Content-Type': 'multipart/form-data',
              'Connection': 'Keep-Alive',
              'authorization': 'Bearer ${prefs.getString('token')}',
              "Accept": "application/json"
            },
          ),
        ),
      );
      try {
        var data = {
          'content': content,
          'type': type,
          'user_id': prefs.getString('id'),
          // 'section_id': prefs.getString('section_id') ?? 0,
          'colloge_id': prefs.getString('colloge_id'),
        };
        Response? response = await chunkedUploader.upload(
          fileKey: "file",
          method: "POST",
          fileName: _path,
          maxChunkSize: 5000000,
          path: url,
          fileSize: path!.size,
          // fileDataStream: paths!.single.readStream!,
          fileDataStream: path!.readStream!,
          data: data,
          // onUploadProgress: onUploadProgress,
        );
        // path!.bytes!.clear();
        print('the response from upload fileeeeeeeeeeeeeeeeeeeee $response');

        if (context != null) Navigator.pop(context);
        if (kDebugMode) {}
      } on DioError catch (e) {
        if (kDebugMode) {
          print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror $e');
        }
      }
    } else {
      print('Select a file first.');
    }
  }

  // void textPost(
  //     {required String content, required BuildContext context}) async {
  //   final SharedPreferences prefs = await _prefs;
  //   final String url = 'http://10.0.2.2:8000/api/';

  //   final dio = Dio();

  //   Map<String, dynamic> data = {
  //     'content': content,
  //     'type': 1,
  //     'user_id': prefs.getString('id'),
  //     'section_id': prefs.getString('section_id'),
  //     'colloge_id': prefs.getString('colloge_id'),
  //     // 'url': null,
  //   };
  //   Response response;
  //   response = await dio.post(
  //     '${url}posts/store/',
  //     queryParameters: data,
  //     options: Options(
  //       headers: {'authorization': 'Bearer ${prefs.getString('token')}'},
  //     ),
  //   );
  //   print('ok');
  //   print(response.data);
  //   if (response.statusCode == 200) {
  //     Navigator.pop(context);
  //   }
  //   // ignore: use_build_context_synchronously
  // }
}

//////////////////////////////////////////////////////////////////////////////////////////////
///
///
// final uploadFileControllerProvider = Provider((ref) {
//   final uploadFileRepository = ref.watch(uploadFileProvider);
//   return UploadFileController(
//       uploadFileReposetitory: uploadFileRepository, ref: ref);
// });

// class UploadFileController {
//   final UploadFileReposetitory? uploadFileReposetitory;
//   final ProviderRef? ref;
//   UploadFileController({
//     this.uploadFileReposetitory,
//     this.ref,
//   });

//   Future<void> pickeFile({required FileType type}) async {
//     await uploadFileReposetitory!.pickFiles(type: type);
//   }

//   getFile() {
//     return uploadFileReposetitory!.getFile();
//   }

//   uploadFile() async {
//     await uploadFileReposetitory!.upload();
//   }
// }
