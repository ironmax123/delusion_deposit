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
      // FutureBuilderで初回起動フラグを確認
      home: FutureBuilder<bool>(
        future: _checkFirstLaunch(),
        builder: (context, snapshot) {
          // ロード中に表示するウィジェット
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 初回起動かどうかで遷移先を決定
          if (snapshot.hasData && snapshot.data == true) {
            return const TargetInput(); // 初回起動ならTargetInputページを表示
          } else {
            return const HomePage(); // それ以降はHomePageを表示
          }
        },
      ),
    );
  }

  // 初回起動かどうかをSharedPreferencesで確認
  Future<bool> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('is_first_launch') ?? true;

    // 初回起動の場合はフラグをfalseに更新
    if (isFirstLaunch) {
      await prefs.setBool('is_first_launch', false);
    }

    return isFirstLaunch;
  }
}
