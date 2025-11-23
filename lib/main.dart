import 'package:flutter/material.dart';
import 'info_page.dart';
import 'payroll_model.dart';
import 'payroll_utils.dart';

void main() {
  runApp(const PayrollApp());
}

class PayrollApp extends StatelessWidget {
  const PayrollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payroll Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const PayrollHomePage(),
    );
  }
}

class PayrollHomePage extends StatefulWidget {
  const PayrollHomePage({super.key});

  @override
  State<PayrollHomePage> createState() => _PayrollHomePageState();
}

class _PayrollHomePageState extends State<PayrollHomePage> {
  final salaryController = TextEditingController();
  final taxController = TextEditingController();
  final deductionController = TextEditingController();

  bool includeSocialSecurity = false;

  PayrollResult? result;

  void updateCalculation() {
    final salary = double.tryParse(salaryController.text) ?? 0;
    final tax = double.tryParse(taxController.text) ?? 0;
    final deduction = double.tryParse(deductionController.text) ?? 0;

    setState(() {
      result = PayrollUtils.calculate(
        salary: salary,
        taxPercent: tax,
        otherDeductions: deduction,
        includeSocialSecurity: includeSocialSecurity,
      );
    });
  }

  void clearAll() {
    salaryController.clear();
    taxController.clear();
    deductionController.clear();
    setState(() => result = null);
  }

  @override
  Widget build(BuildContext context) {
    updateCalculation(); // Real-time calculation

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payroll Calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InfoPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Enter Salary Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Monthly Salary",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => updateCalculation(),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: taxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tax % (example: 10)",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => updateCalculation(),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: deductionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Other Deductions",
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => updateCalculation(),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              title: const Text("Include Social Security (3.5%)"),
              value: includeSocialSecurity,
              onChanged: (value) {
                setState(() {
                  includeSocialSecurity = value;
                  updateCalculation();
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: clearAll,
              child: const Text("Clear"),
            ),

            const SizedBox(height: 20),

            if (result != null) _buildResultCard(result!),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(PayrollResult result) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Salary Breakdown",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 16),

            _line("Gross Salary", result.salary),
            _line("Tax Amount", result.taxAmount),
            _line("Other Deductions", result.otherDeductions),
            if (result.socialSecurity > 0)
              _line("Social Security", result.socialSecurity),

            Divider(height: 30),

            Text(
              "Net Salary: \$${result.netSalary.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _line(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text("\$${value.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
