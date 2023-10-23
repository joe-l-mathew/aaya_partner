import 'package:aaya_partner/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TokenServices {
  static Future<void> saveToken(String token) async {
    final box = await Hive.openBox('tokenBox');
    await box.put('jwt', token);
  }

  static Future<String?> getToken() async {
    final box = await Hive.openBox('tokenBox');

    return box.get('jwt');
  }

  static Future<Map<String, String>> getHeader() async {
    String? accessToken = await getToken();
    if (accessToken == null) {
      Get.offAll(const SplashScreen());
    }
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': accessToken!,
    };
    return headers;
  }
}
