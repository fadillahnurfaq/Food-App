import 'package:foodapp/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeader;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl; // attribute from GetConnect
    timeout = const Duration(seconds: 30); // attribute from GetConnect
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  //* Optional headers
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      //* kalau headearsnya kosong diisi sama mainheaders
      Response response = await get(
        uri,
        headers: headers ?? _mainHeader,
      );
      return response;
    } catch (e) {
      // ignore: avoid_print
      print('Error apiClient.getData');
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeader);
      print(response.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
