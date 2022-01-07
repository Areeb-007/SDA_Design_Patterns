class TaxCalculator {
  double gstPercentage;
  double servicesTaxPercentage;
  double otherTaxPercentage;
  TaxCalculator(
      {required this.gstPercentage,
      required this.servicesTaxPercentage,
      required this.otherTaxPercentage});
  double calculateActualFeeIncludingTax(double fee) {
    return ((gstPercentage / 100) * fee) +
        ((servicesTaxPercentage / 100) * fee) +
        ((otherTaxPercentage / 100) * fee);
  }
}
