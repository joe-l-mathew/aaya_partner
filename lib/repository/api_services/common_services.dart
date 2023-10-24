import 'package:aaya_partner/main.dart';
import 'package:aaya_partner/repository/routes/api_routes.dart';
import 'package:aaya_partner/services/token_services.dart';
import 'package:dio/dio.dart';

class CommonService {
  static Future<String?> uploadFile({required String filePath}) async {
    Dio dio = dioInstance!;
    String path = ApiRoutes.baseUrl + ApiRoutes.uploadFile;
    Map<String, String> header = await TokenServices.getHeader();
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    try {
      Response response = await dio.post(path,
          options: Options(headers: header), data: formData);
      return response.data['file_url'];
    } on Exception {
      return null;
    }
  }
}
