import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moor/moor.dart';

class MyTools {
  static String formatSec(int sec) {
    var d = Duration(seconds: sec);
    return '${d.inHours.toString().padLeft(2, "0")}:${(d.inMinutes % 60).toString().padLeft(2, "0")}:${(d.inSeconds % 60).toString().padLeft(2, "0")}';
  }

  static String generateMd5(Uint8List? data) {
    if (data == null) {
      return '';
    }
    var digest = md5.convert(data);
    return hex.encode(digest.bytes);
  }

  static int rand(int max) {
    return Random().nextInt(max);
  }

  static String formatMessageTime(DateTime date) {
    final now = DateTime.now();
    final diffDays = now.difference(date).inDays;
    if (diffDays > 7) {
      return DateFormat('yyyy/MM/dd', Get.locale?.languageCode).format(date);
    } else if (diffDays > 0) {
      return DateFormat.EEEE(Get.locale?.languageCode).format(date);
    }
    return DateFormat.jm(Get.locale?.languageCode).format(date);
  }

  static bool isToday(DateTime? date) {
    if (date == null) {
      return false;
    }
    var now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return true;
    }
    return false;
  }
}
