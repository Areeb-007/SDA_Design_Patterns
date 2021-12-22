import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:flutter/material.dart';

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
}
