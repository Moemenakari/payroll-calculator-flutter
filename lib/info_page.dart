import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Info")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Payroll Calculator App\n\n"
              "Features:\n"
              "- Real-time tax calculation\n"
              "- Net salary breakdown\n"
              "- Optional Social Security deduction\n"
              "- Works fully offline\n\n"
              "Created by: Student CSCI410",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
