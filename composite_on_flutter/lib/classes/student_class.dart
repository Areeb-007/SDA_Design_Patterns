import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:flutter/material.dart';

class Student implements Person {
  String name;
  int age;
  int id;
  Student({required this.id, required this.name, required this.age});
  @override
  Widget displayPerson() {
    return Column(
      children: [
        const Divider(
          endIndent: 22,
          indent: 22,
        ),
        Text('Student Id : $id'),
        Text('Student Name : $name'),
        Text('Student Age : $age'),
      ],
    );
  }
}
