import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_bud/pages/MedicineShopping.dart';
import 'package:http/http.dart' as http;

class MedicineShopProvider extends ChangeNotifier {
  List<MedicinesInShop> medicines = [];

  Future<void> fetchMedicines() async {
    medicines.clear();
    var response = await http.get('https://med-bud.herokuapp.com/med');
    var parsedMeds = jsonDecode(response.body) as List<dynamic>;
    parsedMeds.forEach((element) {
      medicines.add(MedicinesInShop(
          medId: element['_id'],
          medName: element['name'],
          price: element['price'].toDouble(),
          expiryDate: element['expDate'],
          quantity: 0));
    });
    notifyListeners();
  }
}
