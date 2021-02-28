import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  Future<bool> login(String email, String password) async {
    Map<String, String> creds = {'email': email, 'password': password};

    print(creds);

    var response =
        await http.post('https://med-bud.herokuapp.com/auth', body: creds);

    var decodedRes = jsonDecode(response.body);
    if (decodedRes['err'] == false) {
      return true;
    } else {
      return false;
    }
  }
}
