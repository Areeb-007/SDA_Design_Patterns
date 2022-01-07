import 'package:composite_on_flutter/classes/composite_pattern/i_scholarship.dart';
import 'package:composite_on_flutter/classes/composite_pattern/scholarship_strategies.dart';

class CompositeBestForScholarShip {
  List<IScholarShip> strategies = [];

  void addStrategy(IScholarShip ss) {
    strategies.add(ss);
  }

  double getScholarShip(String rollNumber, double semesterFee) {
    double sum = double.maxFinite;
    for (int i = 0; i < strategies.length; i++) {
      double temp = strategies[i].calculateScholarShip(rollNumber, semesterFee);
      if (temp < sum) {
        sum = temp;
      }
    }
    return sum;
  }
}
