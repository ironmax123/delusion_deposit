import 'package:delusion_deposit/pages/dining-out_list/duingout.dart';
import 'package:delusion_deposit/pages/home/add_diningout.dart';
import 'package:delusion_deposit/pages/home/show-save.dart';
import 'package:delusion_deposit/pages/target-input/target_input.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ShowSave showsave;
  String date = ''; // 初期値を空文字に設定
  String target = ''; // targetの初期値も設定

  int TargetPrice = 0;

  @override
  void initState() {
    super.initState();
    showsave = ShowSave();
    // データの読み込みを開始
    showsave.loadSavedData().then((_) {
      // データが読み込まれたら、UIを更新
      if (showsave.loadedData.isNotEmpty) {
        setState(() {
          // 最初のアイテムのtarget_dateを取得
          date = showsave.loadedData[0]['target_date'] ?? '不明な日付';
          target = showsave.loadedData[0]['target'] ?? '不明な目標';
          TargetPrice = showsave.loadedData[0]['target_price'];
        });
      } else {
        // 目標データがない場合、ダイアログを表示
        _showNoTargetDialog();
      }
    });
  }

  void _showNoTargetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('目標達成おめでとう！'),
          content: const Text('次の目標を決めてがんばろう'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, // 必ず context を渡す
                  MaterialPageRoute(
                      builder: (context) =>
                          const TargetInput()), // TargetInput 画面への遷移
                );
              },
              child: const Text('次へ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '妄想貯金箱',
            style: TextStyle(
              color: Color(0xFF2F5C8A),
            ),
          ),
          centerTitle: true, // タイトルを中央に配置
          backgroundColor: const Color.fromARGB(255, 176, 224, 230),
          actions: [
            // アイコンボタンを右端に配置
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DuingOut(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ColoredBox(
                    color: const Color.fromARGB(255, 176, 224, 230),
                    child: SizedBox(
                      height: 160,
                      width: 400,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                              child: Text(
                                '貯金額',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            child: Text(
                              '10000円',
                              //'${deposit.loadedData}円',
                              style: const TextStyle(
                                color: Color(0xFFFF8C00),
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 160),
                              child: Row(
                                children: [
                                  const Text(
                                    'あと',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '10000円',
                                    style: const TextStyle(
                                      color: Color(0xFF2F5C8A),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ColoredBox(
                    color: const Color.fromARGB(255, 176, 224, 230),
                    child: SizedBox(
                      height: 160,
                      width: 400,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            '目標',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              '$dateまでに$target',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '$TargetPrice円',
                            style: const TextStyle(
                              color: Color(0xFF2F5C8A),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('追加')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TargetInput(),
                      ),
                    );
                  },
                  child: const Text('目標入力'))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 250 + MediaQuery.of(context).viewInsets.bottom,
                  child: const AddDiningOut(),
                );
              },
            );
          },
          backgroundColor: const Color.fromARGB(255, 176, 224, 230),
          child: const Icon(Icons.add),
        ),
      );
}
