class PayrollResult {
  final double salary;
  final double taxAmount;
  final double otherDeductions;
  final double socialSecurity;
  final double netSalary;

  PayrollResult({
    required this.salary,
    required this.taxAmount,
    required this.otherDeductions,
    required this.socialSecurity,
    required this.netSalary,
  });
}
