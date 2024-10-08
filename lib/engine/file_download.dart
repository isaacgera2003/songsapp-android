import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:songsapp/engine/notification_provider.dart';

class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void startDownloading(BuildContext context, final Function okCallback) async {
    String baseUrl = "http://3.7.73.205/main.pdf";
    String fileName =
        "Magazine_${monthNames[currentMonth - 1]}_$currentYear.pdf";

    String path = await _getFilePath(fileName);

    try {
      await dio.download(
        baseUrl,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      NotificationProvider np = NotificationProvider();
      np.downloadNotifier(fileName,"/storage/emulated/0/Download/$fileName");
      Navigator.pop(context);
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
}
