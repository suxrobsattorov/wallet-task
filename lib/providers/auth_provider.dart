import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/login_response.dart';
import '../data/model/register_response.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  bool get isAuth {
    // return true;
    return _token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<LoginResponse?> login(String username, String password) async {
    final url = Uri.parse('https://online.atomic.uz/api/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "username": username,
            "password": password,
          },
        ),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == false) {
        throw HttpException(data['error']['message']);
      }
      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(data);
        _token = loginResponse.token!;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        notifyListeners();
        return loginResponse;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<RegisterResponse?> register(
      String name, String surname, String username, String password) async {
    final url = Uri.parse('https://online.atomic.uz/api/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": name,
            "surname": surname,
            "username": username,
            "password": password,
          },
        ),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        final registerResponse = RegisterResponse.fromJson(data);
        notifyListeners();
        return registerResponse;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return false;
    }
    _token = jsonDecode(prefs.getString('token')!) as String;

    notifyListeners();
    return true;
  }

  void logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
