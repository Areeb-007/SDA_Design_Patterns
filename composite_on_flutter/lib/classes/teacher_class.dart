import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:composite_on_flutter/classes/strategy/i_eligibility.dart';
import 'package:flutter/material.dart';

class TeachersFields {
  static final List<String> values = [name, id, age, course];
  static final String name = 'Name';
  static final String id = 'Id';
  static final String age = 'Age';
  static final String course = 'Course';
  // static final String semester = 'Semester';
}

final teacherTable = 'TeacherTable';

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
  Map<String, dynamic> toMap() {
    return {
      TeachersFields.id: id,
      TeachersFields.name: name,
      TeachersFields.age: age,
      TeachersFields.course: course,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age, course: $course}';
  }

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

  @override
  IEligibility eligibility = TeacherEligiblity();

  @override
  String getEliblity() {
    return eligibility.getEligibility();
  }
}
