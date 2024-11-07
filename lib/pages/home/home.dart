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
          backgroundColor: const Color.fromARGB(255, 176, 224, 230),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const ColoredBox(
                    color: Color.fromARGB(255, 176, 224, 230),
                    child: SizedBox(
                      height: 160,
                      width: 400,
                      child: Column(
                        children: [
                          Align(
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
                              style: TextStyle(
                                color: Color(0xFFFF8C00),
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(left: 160),
                              child: Row(
                                children: [
                                  Text(
                                    'あと',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '99990000円',
                                    style: TextStyle(
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
                onPressed: () {},
                child: const Text(
                  '外食履歴を見る',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 176, 224, 230),
          child: const Icon(Icons.add),
        ),
      );
}
