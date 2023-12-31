import 'package:aaya_partner/constants/enums.dart';
import 'package:aaya_partner/controller/worker_controller.dart';
import 'package:aaya_partner/functions/get_fmc_token.dart';
import 'package:aaya_partner/main.dart';
import 'package:aaya_partner/models/api_models/worker_data.dart';
import 'package:aaya_partner/repository/routes/api_routes.dart';
import 'package:aaya_partner/screens/home/home_screen.dart';
import 'package:aaya_partner/screens/onboarding/onboarding_screen.dart';
import 'package:aaya_partner/screens/onboarding/verification_pending_screen.dart';
import 'package:aaya_partner/services/token_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class AuthServices {
  static Future<bool> sentOtp({required String phoneNumber}) async {
    Map<String, dynamic> data = {"phone_number": phoneNumber};
    Dio dio = dioInstance!;
    String path = ApiRoutes.baseUrl + ApiRoutes.sentOtp;
    Response res = await dio.post(path, data: data);
    return res.statusCode == 200;
  }

  static Future<bool> submitOtp(
      {required String phoneNumber, required String otp}) async {
    WorkerController workerController = Get.find();
    Map<String, dynamic> data = {"phone_number": phoneNumber, "otp": otp};
    Dio dio = dioInstance!;
    String path = ApiRoutes.baseUrl + ApiRoutes.submitOtp;
    try {
      Response res = await dio.post(path, data: data);
      WorkerData workerData = WorkerData.fromJson(res.data);
      workerController.userData(workerData);
      TokenServices.saveToken(workerData.token);
      await AuthServices.getUser();
      return res.statusCode == 200;
    } on Exception {
      return false;
    }
  }

  static Future<bool> getUser() async {
    WorkerController workerController = Get.find();
    Dio dio = dioInstance!;
    String path = ApiRoutes.baseUrl + ApiRoutes.getuser;
    Map<String, String> header = await TokenServices.getHeader();
    String? fcm = await getFCMToken();
    var data = {"fcm_token": fcm};
    try {
      Response res =
          await dio.post(path, options: Options(headers: header), data: data);
      WorkerData workerData = WorkerData.fromJson(res.data);
      workerController.userData(workerData);
      TokenServices.saveToken(workerData.token);
      if (workerData.workerVerificationStatus.isVerified ==
          VerificationStatus.pending.name) {
        Get.offAll(
          () => const VerificationPendingScreen(),
        );
      } else if (workerData.workerVerificationStatus.isVerified !=
          VerificationStatus.verified.name) {
        //get to add personal details
        Get.offAll(
          () => const WorkerOnboardingScreen(),
        );
      } else {
        //get to home screen
        Get.offAll(() => const HomeScreen());
      }
      return res.statusCode == 200;
    } on Exception {
      return false;
    }
  }
}
