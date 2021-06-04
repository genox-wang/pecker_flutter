import 'dart:math';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:moor/moor.dart';

// 工具类
class MyTools {
  static final _random = Random(DateTime.now().microsecondsSinceEpoch);

  // sec 格式化, 例如： 12:11:25
  static String formatSec(int sec) {
    var d = Duration(seconds: sec);
    return '${d.inHours.toString().padLeft(2, "0")}:${(d.inMinutes % 60).toString().padLeft(2, "0")}:${(d.inSeconds % 60).toString().padLeft(2, "0")}';
  }

  // 生成 md5
  static String generateMd5(Uint8List? data) {
    if (data == null) {
      return '';
    }
    var digest = md5.convert(data);
    return hex.encode(digest.bytes);
  }

  // 生成随机数
  static int rand(int max) {
    return _random.nextInt(max);
  }

  // 是否是今天
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
