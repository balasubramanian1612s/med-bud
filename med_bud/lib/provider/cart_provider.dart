import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_bud/pages/MedicineShopping.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {
  Future<String> placeOrder(List<MedicinesInCart> order, double total) async {
    Map<String, Map<String, dynamic>> content = {};

    order.forEach((element) {
      final Map<String, dynamic> medInfo = {
        "expiryDate": element.expiryDate,
        "qty": element.quantity
      };
      content.putIfAbsent(element.medId, () => medInfo);
    });

    Map<String, dynamic> body = {
      "amount": total.toInt(),
      "deliveryDate": "27-02-2021",
      "content": content
    };

    var response = await http.post(
        'https://med-bud.herokuapp.com/order/6039fb8a194c020cc6c75f92',
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));
    return (jsonDecode(response.body))['name'];
  }
}
