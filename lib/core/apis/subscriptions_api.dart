import 'package:jmoov/core/http_client.dart';
import 'package:jmoov/helpers.dart';

class SubscriptionsApi {
  static final SubscriptionsApi _instance = SubscriptionsApi._();
  final Http _http = Http.instance;

  SubscriptionsApi._();

  static SubscriptionsApi get instance => _instance;

  Future<Map<String, dynamic>> getPasses() async {
    return performApiCall(await _http.get("/internet-passes"));
  }

  Future<Map<String, dynamic>> getSubscriptions(String token) async {
    return performApiCall(await _http.get(
      "/user-subscriptions",
      headers: {"Authorization": "Bearer $token"},
    ));
  }
}
