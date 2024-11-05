import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final title = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Text(title)の前のconstは不要です
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
