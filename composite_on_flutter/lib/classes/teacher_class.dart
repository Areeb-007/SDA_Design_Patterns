import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:flutter/material.dart';

class Teacher implements Person {
  int id;
  String name;
  int age;
  String course;

  Teacher(
      {required this.id,
      required this.name,
      required this.age,
      required this.course});

  @override
  Widget displayPerson() {
    return Column(
      children: [
        const Divider(
          endIndent: 22,
          indent: 22,
        ),
        Text('Teacher Id : $id'),
        Text('Teacher Name : $name'),
        Text('Teacher Age : $age'),
        Text('Teacher Course : $course'),
      ],
    );
  }
}
