import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDiningOut extends HookWidget {
  const AddDiningOut({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldValue = useState<int>(0);
    final textFieldController = useTextEditingController();
    final day = DateTime.now().toString().split(' ')[0]; // yyyy-mm-dd形式の日付を取得

    Future<void> saveCourseInfo() async {
      final prefs = await SharedPreferences.getInstance();

      // 既存の保存データを取得してリストに変換
      String? savedData = prefs.getString('saved_out');
      List<dynamic> courses = savedData != null ? jsonDecode(savedData) : [];

      // 新しいデータを作成
      final courseData = {
        'date': day, // 自動取得した日付を使用
        'price': textFieldValue.value, // 入力された数値
      };

      courses.add(courseData);
      await prefs.setString('saved_out', jsonEncode(courses));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('情報が保存されました')),
      );
      textFieldController.clear();
      textFieldValue.value = 0;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textFieldController,
            onChanged: (value) =>
                textFieldValue.value = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue[200],
              labelText: '金額を入力してください',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(size: 32),
              const SizedBox(
                width: 24,
              ),
              ElevatedButton(
                onPressed: saveCourseInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB0E0F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('データを保存',
                    style: TextStyle(color: Color(0xFF000000), fontSize: 15)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
