import 'package:composite_on_flutter/classes/strategy/i_eligibility.dart';
import 'package:flutter/material.dart';

abstract class Person {
  late IEligibility eligibility;
  Widget displayPerson();
  String getEliblity();
}
