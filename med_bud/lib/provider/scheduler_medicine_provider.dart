import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:med_bud/pages/scheduler_medicine_list.dart';

class SchedulerMedicineProvider extends ChangeNotifier {
  List<Medicine> allMedicines = [];

  Future<void> fetchMedicines() async {
    allMedicines.clear();
    var response = await http.get('https://med-bud.herokuapp.com/med');
    var parsedMeds = jsonDecode(response.body) as List<dynamic>;
    parsedMeds.forEach((element) {
      allMedicines.add(Medicine(element['_id'], element['name']));
    });
    notifyListeners();
  }
}
