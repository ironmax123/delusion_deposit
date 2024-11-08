import 'dart:convert';
import 'package:delusion_deposit/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StandardInput extends HookWidget {
  const StandardInput({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldValue = useState<int>(0);
    final standardText = useState<String>('');
    final selectedDate = useState<DateTime>(DateTime.now());
    final textFieldController = useTextEditingController();
    final standardFieldController = useTextEditingController();

    // データを保存する関数
    Future<void> saveStandard() async {
      final prefs = await SharedPreferences.getInstance();

      // 既存の保存データを取得してリストに変換
      String? savedData = prefs.getString('saved_data');
      List<dynamic> courses = savedData != null ? jsonDecode(savedData) : [];

      // 新しいデータを作成
      final courseData = {
        'standard_date':
            "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}", // 目標の日付
        'target_price': textFieldValue.value, // 入力された数値
        'standard': standardText.value, // 目的入力
      };

      // 新しいデータを追加して保存
      courses.add(courseData);
      await prefs.setString('saved_data', jsonEncode(courses));
      debugPrint("保存したデータ: ${jsonEncode(courses)}");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('情報が保存されました')),
      );
      textFieldController.clear();
      standardFieldController.clear();
      textFieldValue.value = 0;
      standardText.value = '';
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
        title: const Text('基準を入力'),
        backgroundColor: const Color(0xFFB0E0E6),
      ),
      body: Column(
        children: [
          TextField(
            controller: textFieldController,
            onChanged: (value) => standardText.value = value,
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
            controller: standardFieldController,
            onChanged: (value) =>
                textFieldValue.value = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue[200],
              labelText: '1週間の外食費用を入力してください',
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
              await saveStandard();
              Navigator.push(
                // ignore: use_build_context_synchronously
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
            child: const Text('始める',
                style: TextStyle(color: Color(0xFFB0E0F6), fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
