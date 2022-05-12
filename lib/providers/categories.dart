import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CategoriesProv with ChangeNotifier {
  final List<Category> _categories = [];

  List<Category> get getCategories => [..._categories];

  Future<void> fetchCategories() async {
    http.Client client = http.Client();

    try {
      final res = await client.get(
        Uri.http(serverUri, '/categories'),
      );

      Map<String, dynamic> data = jsonDecode(res.body);

      for (var entry in data['categories']) {
        _categories.add(Category.fromJson(entry));
      }
    } finally {
      client.close();
    }

    notifyListeners();
  }
}
