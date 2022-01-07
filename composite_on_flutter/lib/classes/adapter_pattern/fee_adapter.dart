import 'package:composite_on_flutter/classes/adapter_pattern/i_fee_calculator.dart';
import 'package:composite_on_flutter/classes/adapter_pattern/tax_calculater.dart';

class FeeAdapter implements IFeeCalculator {
  TaxCalculator taxCalculator = TaxCalculator(
      gstPercentage: 17, servicesTaxPercentage: 5, otherTaxPercentage: 2.5);

  @override
  double calculateFee(double academicsFee) {
    // TODO: implement calculateFee
    return taxCalculator.calculateActualFeeIncludingTax(academicsFee);
  }
}
