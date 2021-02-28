import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PillStockProvider extends ChangeNotifier {
  Future<void> placeOrder(Map<String, dynamic> orderInfo) async {
    Map<String, dynamic> finalOrderInfo = {};
    for (String key in orderInfo.keys.toList()) {
      finalOrderInfo[key] = orderInfo[key] * 30;
    }

    var response = await http.post(
        'https://med-bud.herokuapp.com/order/month/6039fb8a194c020cc6c75f92',
        headers: {"Content-Type": "application/json"},
        body: json.encode(finalOrderInfo));
    print(response.body);
  }
}
