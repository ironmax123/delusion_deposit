import 'package:delusion_deposit/pages/target-input/target_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delusion Deposit App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkTarget(),
        builder: (context, snapshot) {
          // ロード中の場合に表示するウィジェット
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 目標が設定されているかどうかで遷移先を決定
          if (snapshot.hasData && snapshot.data == true) {
            return const HomePage(); // 目標が設定されていればHomePageを表示
          } else {
            return const TargetInput(); // 目標が設定されていなければTargetInputを表示
          }
        },
      ),
    );
  }

  // 目標が設定されているかどうかをSharedPreferencesで確認
  Future<bool> checkTarget() async {
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferencesに保存された目標情報を確認
    bool isGoalSet =
        prefs.getBool('is_goal_set') ?? false; // 'is_goal_set'のキーで設定状態を確認
    return isGoalSet;
  }
}
