import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> savedeposit(
    BuildContext context, int depositNum, String targetStr) async {
  if (targetStr == 'difference') {
    await deleteData(targetStr);
  } else if (targetStr == 'deposit') {
    await deleteData(targetStr);
  }
  await deleteData(targetStr);
  final prefs = await SharedPreferences.getInstance();

  // 既存の保存データを取得してリストに変換
  String? savedData = prefs.getString('${targetStr}_data');
  List<dynamic> courses = savedData != null ? jsonDecode(savedData) : [];

  // 新しいデータを作成
  final courseData = {'${targetStr}_price': depositNum};

  // 新しいデータを追加して保存
  courses.add(courseData);
  await prefs.setString('${targetStr}_data', jsonEncode(courses));
  print("保存したデータ: ${jsonEncode(courses)}");

  // context を渡して ScaffoldMessenger を使用
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('情報が保存されました')),
  );
}

Future<void> deleteData(targetStr) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('${targetStr}_data');
  debugPrint('全データが削除されました');
}
