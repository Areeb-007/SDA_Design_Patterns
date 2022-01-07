import 'package:composite_on_flutter/classes/composite_pattern/i_scholarship.dart';

class ScholarShipStrategyOnSection implements IScholarShip {
  double discountPercentageForAfternoon;
  double discountPercentageForMorning;

  ScholarShipStrategyOnSection(
      {required this.discountPercentageForAfternoon,
      required this.discountPercentageForMorning});
  @override
  double calculateScholarShip(String rollNumber, double semesterFee) {
    if (rollNumber.contains('a') || rollNumber.contains('A')) {
      return semesterFee * (discountPercentageForAfternoon / 100);
    } else {
      return semesterFee * (discountPercentageForMorning / 100);
    }
  }
}

class ScholarShipStrategyOnDegree implements IScholarShip {
  double discountPercentageForSE;
  double discountPercentageForCS;
  double discountPercentageForIT;

  ScholarShipStrategyOnDegree(
      {required this.discountPercentageForSE,
      required this.discountPercentageForCS,
      required this.discountPercentageForIT});
  @override
  double calculateScholarShip(String rollNumber, double semesterFee) {
    if (rollNumber.contains('SE') || rollNumber.contains('se')) {
      return semesterFee * (discountPercentageForSE / 100);
    } else if (rollNumber.contains('CS') || rollNumber.contains('cs')) {
      return semesterFee * (discountPercentageForCS / 100);
    } else {
      return semesterFee * (discountPercentageForIT / 100);
    }
  }
}
