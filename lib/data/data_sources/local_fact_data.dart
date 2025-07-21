import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/fact_model.dart';

class LocalFactData {
  static Future<List<FactModel>> loadFacts() async {
    final data = await rootBundle.loadString('assets/files/fun_facts.json');
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => FactModel.fromJson(json)).toList();
  }
}
