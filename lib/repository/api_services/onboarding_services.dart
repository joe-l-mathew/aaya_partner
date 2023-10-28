import 'package:aaya_partner/constants/enums.dart';
import 'package:aaya_partner/functions/get_fmc_token.dart';
import 'package:aaya_partner/main.dart';
import 'package:aaya_partner/repository/api_services/common_services.dart';
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
  final List<String> skills;
  BasicDetailModel({
    required this.name,
    required this.skills,
    required this.email,
    required this.dob,
    required this.gender,
    this.profileImage,
    required this.longitude,
    required this.latitude,
  });
}

class DocumentVerificationModel {
  final String aadharNo;
  final String panNumber;
  final String panFront;
  final String panBack;
  final String aadharFront;
  final String aadharBack;
  final String? drivingFront;
  final String? drivingBack;
  final String? drivingNumber;

  DocumentVerificationModel({
    required this.aadharNo,
    required this.panNumber,
    required this.panFront,
    required this.panBack,
    required this.aadharFront,
    required this.aadharBack,
    this.drivingFront,
    this.drivingBack,
    this.drivingNumber,
  });
}

class OnboardingServices {
  static Future<bool> addBasicData({required BasicDetailModel model}) async {
    Dio dio = dioInstance!;
    var header = await TokenServices.getHeader();
    String path = ApiRoutes.baseUrl + ApiRoutes.basicDetailsUpload;
    String? fcmToken = await getFCMToken();
    String profileDownPath = "";
    if (model.profileImage != null) {
      String? downPath =
          await CommonService.uploadFile(filePath: model.profileImage!);
      profileDownPath = downPath ?? "";
    }
    Map<String, dynamic> data = {
      "name": model.name,
      "email_id": model.email,
      "dob": DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(model.dob),
      "profile_url": profileDownPath,
      "latitude": model.longitude,
      "longitude": model.latitude,
      "location_name": "Home",
      "gender": model.gender.name,
      "fcm_token": fcmToken
    };
    Logger().d(data);
    try {
      await dio.post(path, options: Options(headers: header), data: data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addVerificationImage(String imagePath) async {
    Dio dio = dioInstance!;
    var header = await TokenServices.getHeader();
    String path = ApiRoutes.baseUrl + ApiRoutes.uploadVerifiactaionImage;
    String? dwnldPath = await CommonService.uploadFile(filePath: imagePath);
    if (dwnldPath == null) {
      return false;
    }
    var data = {"verification_image": dwnldPath};

    try {
      await dio.post(path, options: Options(headers: header), data: data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verifyDocuments(
      DocumentVerificationModel documentVerificationModel) async {
    Dio dio = dioInstance!;
    var header = await TokenServices.getHeader();
    String path = ApiRoutes.baseUrl + ApiRoutes.addWorkerDocuments;
    String? aadharFront = await CommonService.uploadFile(
        filePath: documentVerificationModel.aadharFront);
    String? aadharBack = await CommonService.uploadFile(
        filePath: documentVerificationModel.aadharBack);
    String? panFront = await CommonService.uploadFile(
        filePath: documentVerificationModel.panFront);
    String? panBack = await CommonService.uploadFile(
        filePath: documentVerificationModel.panBack);
    String? drivingFront;
    String? drivingBack;
    if (documentVerificationModel.drivingFront != null &&
        documentVerificationModel.drivingBack != null &&
        documentVerificationModel.drivingNumber!.isNotEmpty) {
      drivingFront = await CommonService.uploadFile(
          filePath: documentVerificationModel.drivingFront!);
      drivingBack = await CommonService.uploadFile(
          filePath: documentVerificationModel.drivingBack!);
    }
    if (aadharFront == null ||
        aadharBack == null ||
        panFront == null ||
        panBack == null) {
      return false;
    }
    var data = {
      "aadhar_no": documentVerificationModel.aadharNo,
      "pan_number": documentVerificationModel.panNumber,
      "pan_front": panFront,
      "pan_back": panBack,
      "aadhar_front": aadharFront,
      "aadhar_back": aadharBack,
      "driving_number": documentVerificationModel.drivingNumber,
      "driving_front": drivingFront ?? "",
      "driving_back": drivingBack ?? ""
    };

    try {
      await dio.post(path, options: Options(headers: header), data: data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
