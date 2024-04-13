import 'package:jmoov/core/http_client.dart';
import 'package:jmoov/core/models/user.dart';
import 'package:jmoov/helpers.dart';

class AuthApi {
  static final AuthApi _instance = AuthApi._();
  final Http _http = Http.instance;

  AuthApi._();

  static AuthApi get instance => _instance;

  Future<Map<String, dynamic>> login(String phone, String password) async {
    return performApiCall(await _http.post("/login", body: {
      "mobile": phone,
      "password": password,
      "id": "1",
    }));
  }

  Future<Map<String, dynamic>> ping(String token) async {
    return performApiCall(await _http
        .get("/get-home-infos", headers: {"Authorization": "Bearer $token"}));
  }

  Future<Map<String, dynamic>> getUser(String token) async {
    return performApiCall(
        await _http.get('/user', headers: {"Authorization": "Bearer $token"}));
  }

  Future<void> logout(String token) async {
    await _http.post("/logout", headers: {"Authorization": "Bearer $token"});
  }

  Future<Map<String, dynamic>> register(
      String phone, String password, String name) async {
    return performApiCall(await _http.post("/register", body: {
      "mobile": phone,
      "password": password,
      "name": name,
      "id": "1",
    }));
  }

  Future<Map<String, dynamic>> resetPassword(String phone) async {
    return performApiCall(
        await _http.post("/reset-password", body: {"mobile": phone}));
  }

  Future<Map<String, dynamic>> verifyCode(String phone, String code) async {
    return performApiCall(await _http.post("/verify-code", body: {
      "mobile": phone,
      "code": code,
    }));
  }

  Future<Map<String, dynamic>> updateGeneralInfo(
    User user,
    String token,
  ) async {
    return performApiCall(
      await _http.post(
        "/update-general-info",
        body: user.generalInfoToJson(),
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  Future<Map<String, dynamic>> updatePassword(
    String oldPassword,
    String password,
    String passwordConfirmation,
    String token,
  ) async {
    return performApiCall(
      await _http.post(
        "/update-password",
        body: {
          "old_password": oldPassword,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }

  Future<Map<String, dynamic>> updateMobile(
    String mobile,
    String password,
    String token,
  ) async {
    return performApiCall(
      await _http.post(
        "/update-phone",
        body: {
          "mobile": mobile,
          "password": password,
        },
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }
}
