import 'payroll_model.dart';

class PayrollUtils {
  static PayrollResult calculate({
    required double salary,
    required double taxPercent,
    required double otherDeductions,
    required bool includeSocialSecurity,
  }) {
    final taxAmount = salary * (taxPercent / 100);
    final socialSecurity = includeSocialSecurity ? salary * 0.035 : 0;
    final netSalary = salary - taxAmount - otherDeductions - socialSecurity;

    return PayrollResult(
      salary: salary.toDouble(),
      taxAmount: taxAmount.toDouble(),
      otherDeductions: otherDeductions.toDouble(),
      socialSecurity: socialSecurity.toDouble(),
      netSalary: netSalary.toDouble(),
    );
  }

}
