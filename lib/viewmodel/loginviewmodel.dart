import 'package:proplus/constants/constants.dart';
import 'package:proplus/constants/urlconstants.dart';
import 'package:proplus/service/apiservice.dart';


class LoginViewModel {
  DioService dioService = DioService();

  Future<String> getLoginURl(String email, String password) async {
    Map<String, dynamic> result = {"username": email, "password": password};
    var response = await dioService.getHttp(
        UrlConstants.loginURL, RequestType.postRequestType,
        result: result);
    if (response != null) {
      return "SUCCESS";
    } else {
      return "FAILURE";
    }
  }
}
