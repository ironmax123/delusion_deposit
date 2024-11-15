import 'package:delusion_deposit/mock_data/mock_deposit.dart';
import 'package:delusion_deposit/pages/dining-out_list/duingout.dart';
import 'package:delusion_deposit/pages/home/BottomSheetWidget/add_diningout.dart';
import 'package:delusion_deposit/pages/home/deposit/deposit.dart';
import 'package:delusion_deposit/pages/target-input/target_input.dart';
import 'package:delusion_deposit/pages/home/show-save.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'deposit/save_deposit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Deposit deposit;
  List<Map<String, dynamic>> savedData = [];
  List<Map<String, dynamic>> savedDataDeposit = [];
  List<Map<String, dynamic>> savedDataTarget = [];
  int loadInt = 0, loadIntDeposit = 0, loadIntTarget = 0;
  late ShowSave showsave;
  String date = '';
  String target = '';

  bool _hasRunToday = false;

  int TargetPrice = 0;
  @override
  void initState() {
    super.initState();
    loadingDeposit();
    checkAndRunDeposit();
    loadRunStatus();
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
                Navigator.pushReplacement(
                  context,
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

  void loadingDeposit() async {
    deposit = Deposit();
    await deposit.dataLoading("standard");
    savedData = deposit.standardData;

    await deposit.dataLoading("deposit");
    savedDataDeposit = deposit.depositData;

    await deposit.dataLoading("difference");
    savedDataTarget = deposit.targetData;

    setState(() {
      //基準と保存された貯金額を設定
      loadInt = deposit.loadInt;
      loadIntDeposit = deposit.loadIntDeposit;
      double result = loadInt / 3;
      loadInt = result.round();
      //保存された目標との差額
      debugPrint('${deposit.loadIntTarget}円');
      loadIntTarget = deposit.loadIntTarget;
    });
  }

  void addDeposit() async {
    final prefs = await SharedPreferences.getInstance();

    int currentPrice = prefs.getInt('addhistory_price') ?? 0;
    setState(() {
      loadIntDeposit += loadInt * currentPrice;
      savedeposit(context, loadIntDeposit, 'deposit');
      loadIntTarget -= loadIntDeposit * currentPrice;
      if (loadIntTarget <= 0) {
        loadIntTarget = 0;
        // _showNoTargetDialog();
      }
      savedeposit(context, loadIntTarget, 'difference');
    });
  }

  Future<void> loadRunStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _hasRunToday = prefs.getBool('hasRunToday') ?? false; // フラグの読み込み
  }

  Future<void> saveRunStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasRunToday', status); // フラグの保存
  }

  void checkAndRunDeposit() async {
    DateTime now = DateTime.now();

    // 日曜日かどうかチェックし、_hasRunToday が false の場合のみ実行
    if (now.weekday == 7 && !_hasRunToday) {
      addDeposit();
      _hasRunToday = true;
      await saveRunStatus(true); // フラグを true にして保存
      //removeAddHistoryPrice();
    }

    // 月曜日から土曜日の場合はフラグをリセット
    if (now.weekday != 7) {
      _hasRunToday = false;
      await saveRunStatus(false); // フラグを false にして保存
    }
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
          automaticallyImplyLeading: false,
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
                      height: 128,
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
                              '$loadIntDeposit円',
                              //'${deposit.loadedData}円',
                              style: const TextStyle(
                                color: Color(0xFFFF8C00),
                                fontSize: 32,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$loadIntTarget円',
                                    style: const TextStyle(
                                      color: Color(0xFF2F5C8A),
                                      fontSize: 16,
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
                              '$dateまでに\n$target',
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
              /* ElevatedButton(onPressed: () {}, child: const Text('追加')),
              ElevatedButton(

                  onPressed: () {
                    addDeposit();
                  },
                  child: const Text('追加')),*/
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
