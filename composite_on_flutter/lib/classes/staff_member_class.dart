import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:composite_on_flutter/classes/strategy/i_eligibility.dart';
import 'package:flutter/material.dart';

class StaffMembersFields {
  static final List<String> values = [name, id, age, designation];
  static final String name = 'Name';
  static final String id = 'Id';
  static final String age = 'Age';
  static final String designation = 'Designation';
  // static final String semester = 'Semester';
}

final staffMemberTable = 'StaffMemberTable';

class StaffMembers implements Person {
  int id;
  String name;
  int age;
  String designation;
  StaffMembers(
      {required this.id,
      required this.name,
      required this.age,
      required this.designation});
  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Age': age,
      'Designation': designation,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age, designation: $designation}';
  }

  @override
  Widget displayPerson() {
    return Column(children: [
      const Divider(
        endIndent: 22,
        indent: 22,
      ),
      Text('Staff Member Id : $id'),
      Text('Staff Member Name : $name'),
      Text('Staff Member Age : $age'),
      Text('Staff Member Designation : $designation'),
    ]);
  }

  @override
  IEligibility eligibility = StaffEligiblity();

  @override
  String getEliblity() {
    return eligibility.getEligibility();
  }
}
