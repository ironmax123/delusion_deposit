import 'package:delusion_deposit/pages/dining-out_list/LIst.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Duing_out extends StatelessWidget {
  Duing_out({super.key});
  outList ListItem = outList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('外食履歴'),
          backgroundColor: const Color(0xFFB0E0E6),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: ListItem.duingList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFB0E0F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      title: Text(ListItem.duingList[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
