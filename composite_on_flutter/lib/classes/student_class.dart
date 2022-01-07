import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:composite_on_flutter/classes/strategy/i_eligibility.dart';
import 'package:flutter/material.dart';

class StudentFields {
  static final List<String> values = [name, id, age, rollNumber, semester];
  static final String name = 'Name';
  static final String id = 'Id';
  static final String age = 'Age';
  static final String rollNumber = 'RollNumber';
  static final String semester = 'Semester';
}

final studentTable = 'StudentTable';

class Student implements Person {
  String name;
  int age;
  int id;
  String rollNumber;
  int semester;
  Student(
      {required this.id,
      required this.name,
      required this.age,
      required this.rollNumber,
      required this.semester});

  Map<String, dynamic> toMap() {
    return {
      StudentFields.id: id,
      StudentFields.name: name,
      StudentFields.age: age,
      StudentFields.rollNumber: rollNumber,
      StudentFields.semester: semester,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age, rollNumber: $rollNumber, semester: $semester}';
  }

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
        Text('Student RollNumber : $rollNumber'),
        Text('Student Semester : $semester'),
      ],
    );
  }

  @override
  IEligibility eligibility = StudentEligiblity();

  @override
  String getEliblity() {
    // TODO: implement getEliblity
    return eligibility.getEligibility();
  }
}
