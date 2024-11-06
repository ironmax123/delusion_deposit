import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: ColoredBox(
                  color: Colors.blue,
                  child: SizedBox(
                    height: 160,
                    width: 400,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft, // 左詰め
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                            child: Text(
                              '貯金額',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            '10000円',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight, // 右詰め
                          child: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              'あと99990000円',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: ColoredBox(
                  color: Colors.blue,
                  child: SizedBox(
                    height: 160,
                    width: 400,
                    child: Column(
                      children: [
                        Text('目標'),
                        Row(
                          children: [
                            Text('11/2までに'),
                            Text('沖縄の別荘'),
                          ],
                        ),
                        Text('1000000000円'),
                      ],
                    ),
                  ),
                ),
              ),
              const ColoredBox(
                color: Colors.blue,
                child: SizedBox(
                  height: 80,
                  width: 240,
                  child: Center(
                    child: Text(
                      '外食履歴遷移',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {},
                child: const Text(
                  '外食履歴遷移',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
