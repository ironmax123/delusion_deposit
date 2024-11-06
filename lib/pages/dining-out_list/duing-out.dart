import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Duing_out extends HookWidget {
  const Duing_out({super.key});

  @override
  Widget build(BuildContext context) {
    final loadedData = useState<List<Map<String, dynamic>>>([]); // データをListに変更

    Future<void> loadSavedData() async {
      final prefs = await SharedPreferences.getInstance();
      final String? savedData = prefs.getString('saved_data');
      debugPrint('読み込んだデータ: $savedData');

      if (savedData != null) {
        List<dynamic> items = jsonDecode(savedData);
        List<Map<String, dynamic>> data = [];

        for (var item in items) {
          data.add({
            'date': item['date'],
            'price': item['price'],
          });
        }

        loadedData.value = data;
        debugPrint('読み込み完了: ${loadedData.value}');
      } else {
        debugPrint('データが存在しません');
      }
    }

    useEffect(() {
      debugPrint("データ読み込みを開始します");
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
                String date = loadedData.value[index]['date'];
                int price = loadedData.value[index]['price'];

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
