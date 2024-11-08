import 'package:delusion_deposit/pages/dining-out_list/duingout.dart';
import 'package:delusion_deposit/pages/home/BottomSheetWidget/add_diningout.dart';
import 'package:delusion_deposit/pages/home/deposit/deposit.dart';
import 'package:delusion_deposit/pages/target-input/target_input.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    loadingDeposit();
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
      print('${deposit.loadIntTarget}円');
      loadIntTarget = deposit.loadIntTarget;
    });
  }

  void addDeposit() async {
    setState(() {
      loadIntDeposit += loadInt;
      savedeposit(context, loadIntDeposit, 'deposit');
      loadIntTarget -= loadIntDeposit;
      savedeposit(context, loadIntTarget, 'difference');
    });
  }

  void loadTarget() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '妄想貯金箱',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 176, 224, 230),
        ),
        body: Center(
          child: Column(
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
                              '$loadIntDeposit円',
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
                                    '$loadIntTarget円',
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
                  child: const ColoredBox(
                    color: Color.fromARGB(255, 176, 224, 230),
                    child: SizedBox(
                      height: 160,
                      width: 400,
                      child: Column(
                        children: [
                          Text(
                            '目標',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              '11/2までに沖縄の別荘',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '1000000000円',
                            style: TextStyle(
                              color: Color(0xFF2F5C8A),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: const Color.fromARGB(255, 176, 224, 230),
                  foregroundColor: Colors.white,
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DuingOut(),
                    ),
                  );
                },
                child: const Text(
                  '外食履歴を見る',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    addDeposit();
                  },
                  child: const Text('追加')),
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
