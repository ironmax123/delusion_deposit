import 'dart:convert';

import 'package:delusion_deposit/test/test_target.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetInput extends HookWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context) {
    // 保存するデータを管理するフック
    final textFieldValue = useState<int>(0);
    final DayText = useState<String>('');
    final targetText = useState<String>('');

    // データを保存する関数
    Future<void> savetarget() async {
      final prefs = await SharedPreferences.getInstance();

      // 既存の保存データを取得してリストに変換
      String? savedData = prefs.getString('saved_data');
      List<dynamic> courses = savedData != null ? jsonDecode(savedData) : [];

      // 新しいデータを作成
      final courseData = {
        'target_date': DayText.value, // 目標の日付
        'target_price': textFieldValue.value, // 入力された数値
        'target': targetText.value,
      };

      // 新しいデータを追加して保存
      courses.add(courseData);
      await prefs.setString('saved_data', jsonEncode(courses));

      // 保存完了メッセージ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('情報が保存されました')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('データ保存テスト'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => DayText.value,
            decoration: const InputDecoration(
              labelText: '期限を入力してください',
            ),
          ),
          TextField(
            onChanged: (value) => targetText.value,
            decoration: const InputDecoration(
              labelText: '目標を入力してください',
            ),
          ),
          TextField(
            onChanged: (value) =>
                textFieldValue.value = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '金額を入力してください',
            ),
          ),
          ElevatedButton(
            onPressed: savetarget,
            child: const Text('保存'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestTarget(),
                  ),
                );
              },
              child: const Text('テスト用'))
        ],
      ),
    );
  }
}
