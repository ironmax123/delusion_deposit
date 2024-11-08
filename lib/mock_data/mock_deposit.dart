import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> mockDeposit() async {
  final prefs = await SharedPreferences.getInstance();

  // データを直接SharedPreferencesに保存
  await prefs.setString(
    'saved_deposit',
    jsonEncode([
      {
        "deposit": 1000,
      } //毎週の使用金額
    ]),
  );

  print('データが端末に保存されました');
}
