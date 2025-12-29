import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const boxName = 'appBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static void saveToken(String token) {
    Hive.box(boxName).put('token', token);
  }

  static String? getToken() {
    return Hive.box(boxName).get('token');
  }

  static void clear() {
    Hive.box(boxName).clear();
  }
}

