import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> mockData() async {
  final prefs = await SharedPreferences.getInstance();

  // データを直接SharedPreferencesに保存
  await prefs.setString(
    'saved_data',
    jsonEncode([
      {"target_date": "2024-11-07", "target_price": 1000, "target": "hogehoge"}
    ]),
  );

  print('データが端末に保存されました');
}
