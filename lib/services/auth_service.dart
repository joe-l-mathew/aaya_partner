import 'package:aaya_partner/repository/api_services/auth_services.dart';
import 'package:aaya_partner/services/token_services.dart';

Future<bool> isLoggedIn() async {
  String? token = await TokenServices.getToken();
  if (token == null) {
    return false;
  }
  return await AuthServices.getUser();
}
