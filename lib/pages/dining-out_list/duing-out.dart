// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Duing_out extends HookWidget {
  const Duing_out({super.key});

  @override
  Widget build(BuildContext context) {
    // ロードされたデータを管理するフック
    final loadedData = useState<Map<String, int>>({});

    // データのロードを行う非同期関数
    Future<void> loadSavedData() async {
      final prefs = await SharedPreferences.getInstance();
      final String? savedData = prefs.getString('saved_data');

      if (savedData != null) {
        // 保存されたデータをデコードして Map に変換
        List<dynamic> items = jsonDecode(savedData);
        Map<String, int> data = {};

        // 各項目を日付と金額で分類
        for (var item in items) {
          String date = item['date']; // yy/mm/dd 形式の日付
          int price = item['price'];

          // データを直接日付をキーにして保存
          data[date] = price;
        }

        // ロードしたデータを更新
        loadedData.value = data;
        debugPrint('読み込み：${loadedData.value}');
      }
    }

    // 初回レンダリング時にデータをロード
    useEffect(() {
      loadSavedData();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('外食履歴'),
        backgroundColor: const Color(0xFFB0E0E6),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: loadedData.value.length,
              itemBuilder: (context, index) {
                // ロードされたデータから日付と金額を取得
                String date = loadedData.value.keys.elementAt(index);
                int price = loadedData.value[date] ?? 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFB0E0F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(date),
                      subtitle: Text('$price円'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
