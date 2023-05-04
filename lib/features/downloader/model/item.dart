// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_downloader/flutter_downloader.dart';

class item {
  final String name;
  final String url;
  String? itemId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;
  item({
    required this.name,
    required this.url,
   
  });
}
