import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deposit {
  late List<Map<String, dynamic>> standardData = [];
  late List<Map<String, dynamic>> depositData = [];
  late List<Map<String, dynamic>> targetData = [];
  Future<void> dataLoading(String targetStr) async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('${targetStr}_data');
    debugPrint('読み込んだデータ: $savedData');

    if (savedData != null) {
      List<dynamic> items = jsonDecode(savedData);
      List<Map<String, dynamic>> data = [];

      for (var item in items) {
        data.add({
          '${targetStr}_price': item['${targetStr}_price'],
        });
      }
      if (targetStr == 'standard') {
        standardData = data;
        debugPrint('読み込み完了: $standardData');
      } else if (targetStr == 'deposit') {
        depositData = data;
        debugPrint('読み込み完了: $depositData');
      } else if (targetStr == 'difference') {
        targetData = data;
        debugPrint('読み込み完了: $targetData');
      } else {
        debugPrint('データが存在しません!!');
      }
    } else {
      debugPrint('データが存在しません');
    }
  }

  int get loadInt {
    if (standardData.isNotEmpty && standardData[0]['standard_price'] is int) {
      return standardData[0]['standard_price'];
    }
    return 0;
  }

  int get loadIntDeposit {
    if (depositData.isNotEmpty && depositData[0]['deposit_price'] is int) {
      return depositData[0]['deposit_price'];
    }
    return 0;
  }

  int get loadIntTarget {
    if (targetData.isNotEmpty && targetData[0]['difference_price'] is int) {
      return targetData[0]['difference_price'];
    }
    return 3000;
  }
}

Future<void> deleteData(String targetStr) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('${targetStr}_data');
  debugPrint('データが削除されました');
}
