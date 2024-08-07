import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/model/category_list.dart';
import '../data/model/category_response.dart';
import '../data/model/category_updated_response.dart';

class CategoryProvider with ChangeNotifier {
  late List<Categories> _list = [];
  String? _authToken;

  void setParams(String? authToken) {
    _authToken = authToken;
  }

  List<Categories> get list {
    return [..._list];
  }

  Future<CategoryList?> get() async {
    final url = Uri.parse('https://online.atomic.uz/api/categories');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken'
        },
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final categoryList = CategoryList.fromJson(data);
        _list = categoryList.categories!;
        return categoryList;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<CategoryResponse?> create(String categoryName) async {
    final url = Uri.parse('https://online.atomic.uz/api/categories');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken'
        },
        body: jsonEncode(
          {
            "name": categoryName,
          },
        ),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 201) {
        final categoryResponse = CategoryResponse.fromJson(data);
        return categoryResponse;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<CategoryUpdatedResponse?> update(int id, String categoryName) async {
    final url = Uri.parse('https://online.atomic.uz/api/categories/$id');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken'
        },
        body: jsonEncode(
          {
            "name": categoryName,
          },
        ),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final categoryUpdatedResponse = CategoryUpdatedResponse.fromJson(data);
        return categoryUpdatedResponse;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<String?> delete(int id) async {
    final url = Uri.parse('https://online.atomic.uz/api/categories/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken'
        },
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return data['message'];
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Categories findById(int categoryId) {
    return _list.firstWhere((category) => category.id == categoryId);
  }
}
