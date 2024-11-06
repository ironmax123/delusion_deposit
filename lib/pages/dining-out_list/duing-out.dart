import 'package:delusion_deposit/pages/dining-out_list/LIst.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Duing_out extends StatelessWidget {
  Duing_out({super.key});
  outList ListItem = outList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('外食リスト')),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: ListItem.duingList.length,
                    itemBuilder: (context, index) => Column(children: [
                          ListTile(
                            title: Text(ListItem.duingList[index]),
                            onTap: () {},
                          ),
                        ])))
          ],
        ));
  }
}
