import 'dart:convert';
import 'package:delusion_deposit/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetInput extends HookWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldValue = useState<int>(0);
    final targetText = useState<String>('');
    final selectedDate = useState<DateTime>(DateTime.now());

    // データを保存する関数
    Future<void> saveTarget() async {
      final prefs = await SharedPreferences.getInstance();

      // 既存の保存データを取得してリストに変換
      String? savedData = prefs.getString('saved_data');
      List<dynamic> courses = savedData != null ? jsonDecode(savedData) : [];

      // 新しいデータを作成
      final courseData = {
        'target_date':
            "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}", // 目標の日付
        'target_price': textFieldValue.value, // 入力された数値
        'target': targetText.value, // 目的入力
      };

      // 新しいデータを追加して保存
      courses.add(courseData);
      await prefs.setString('saved_data', jsonEncode(courses));
      debugPrint("保存したデータ: ${jsonEncode(courses)}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('情報が保存されました')),
      );
    }

    // 日付選択ダイアログを表示する関数
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2024),
        lastDate: DateTime(2050),
      );

      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
      }
    }

    // 全データを削除する関数
    Future<void> deleteAllData() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('saved_data');
      await prefs.remove('saved_out');
      debugPrint('全データが削除されました');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('目標入力'),
        backgroundColor: const Color(0xFFB0E0E6),
      ),
      body: Column(
        children: [
          Text(
            '選択した日付: \n ${selectedDate.value.year}/${selectedDate.value.month}/${selectedDate.value.day}',
            style: const TextStyle(fontSize: 30),
          ),
          ElevatedButton(
            onPressed: () => selectDate(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB0E0F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '日付選択',
              style: TextStyle(color: Color(0xFF000000), fontSize: 15),
            ),
          ),
          TextField(
            onChanged: (value) => targetText.value = value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue[200],
              labelText: '貯金の目的を入力してください',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            onChanged: (value) =>
                textFieldValue.value = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue[200],
              labelText: '目標金額を入力してください',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              await deleteAllData();
              await saveTarget();
              // TODO：頻度入力へ変更
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('次へ',
                style: TextStyle(color: Color(0xFFB0E0F6), fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
