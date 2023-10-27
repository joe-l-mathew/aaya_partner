import 'package:aaya_partner/constants/enums.dart';
import 'package:aaya_partner/functions/get_fmc_token.dart';
import 'package:aaya_partner/main.dart';
import 'package:aaya_partner/repository/routes/api_routes.dart';
import 'package:aaya_partner/services/token_services.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class BasicDetailModel {
  final String name;
  final String email;
  final DateTime dob;
  final Gender gender;
  final String? profileImage;
  final double longitude;
  final double latitude;
  BasicDetailModel({
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    this.profileImage,
    required this.longitude,
    required this.latitude,
  });
}

class OnboardingServices {
  static Future<void> addBasicData({required BasicDetailModel model}) async {
    Dio dio = dioInstance!;
    var header = await TokenServices.getHeader();
    String path = ApiRoutes.baseUrl + ApiRoutes.basicDetailsUpload;
    String? fcmToken = await getFCMToken();
    // CommonService.upload
    Map<String, dynamic> data = {
      "name": model.name,
      "email_id": model.email,
      "dob": DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(model.dob),
      "profile_url": model.profileImage ?? "",
      "latitude": model.longitude,
      "longitude": model.latitude,
      "location_name": "Home",
      "gender": model.gender.name,
      "fcm_token": fcmToken
    };
    Logger().d(data);
    try {
      Response res =
          await dio.post(path, options: Options(headers: header), data: data);

      Logger().e(res.statusCode);
    } catch (e) {
      Logger().e(e);
    }
  }
}
