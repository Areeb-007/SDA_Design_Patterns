import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:composite_on_flutter/classes/strategy/i_eligibility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class Employees implements Person {
  List<Person> persons = [];
  BuildContext context;
  Employees({required this.persons, required this.context});
  @override
  Widget displayPerson() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: persons.length,
      itemBuilder: (context, index) {
        return persons[index].displayPerson();
      },
    );
  }

  @override
  IEligibility eligibility = StudentEligiblity();

  @override
  String getEliblity() {
    return eligibility.getEligibility();
  }
}
