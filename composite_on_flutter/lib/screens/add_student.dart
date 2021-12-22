import 'package:composite_on_flutter/classes/student_class.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  Student student = Student(id: 0, name: '', age: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('ID')),
                onChanged: (val) {
                  student.id = int.parse(val);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Name')),
                onChanged: (val) {
                  student.name = (val);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text('Age')),
                onChanged: (val) {
                  student.age = int.parse(val);
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
