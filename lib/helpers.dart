import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jmoov/core/http_client.dart';
import 'package:provider/provider.dart';

ThemeData theme(BuildContext context) => Theme.of(context);

String avatarUrl(String name) =>
    "https://ui-avatars.com/api/?name=$name&background=6D12C4&color=fff";

Map<String, dynamic> performApiCall(Response response) {
  Map<String, dynamic> data = jsonDecode(response.body);

  if (data['status_code'] != 200) {
    throw Exception(data['status_message']);
  }
  return data['data'];
}

T getProvider<T>(BuildContext context, [bool listen = false]) =>
    Provider.of<T>(context, listen: listen);
