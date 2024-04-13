import 'dart:developer';

import 'package:jmoov/core/apis/subscriptions_api.dart';
import 'package:jmoov/core/models/bundle.dart';
import 'package:jmoov/core/models/subscription.dart';

class SubscriptionsService {
  final SubscriptionsApi _subscriptions = SubscriptionsApi.instance;
  static final SubscriptionsService _instance = SubscriptionsService._();

  SubscriptionsService._();

  static SubscriptionsService get instance => _instance;

  Future<List<Pass>> getBundles() async {
    Map<String, dynamic> data = await _subscriptions.getPasses();
    List<Pass> passes = [];

    data['passes'].forEach((category) {
      log(category.toString());
      passes.add(Pass.fromJson(category));
    });
    return passes;
  }

  Future<List<Subscription>> getSubscriptions(String token) async {
    Map<String, dynamic> data = await _subscriptions.getSubscriptions(token);
    List<Subscription> subscriptions = [];

    data['subscriptions'].forEach((subscription) {
      subscriptions.add(Subscription.fromJson(subscription));
    });
    return subscriptions;
  }
}
