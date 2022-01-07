import 'package:composite_on_flutter/classes/employees_class.dart';
import 'package:composite_on_flutter/classes/staff_member_class.dart';
import 'package:composite_on_flutter/classes/student_class.dart';
import 'package:composite_on_flutter/classes/teacher_class.dart';
import 'package:composite_on_flutter/screens/add_student.dart';
import 'package:composite_on_flutter/screens/patterns/patterns.dart';
import 'package:flutter/material.dart';

import 'data/database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late DatabaseHelper db;

  @override
  void initState() {
    super.initState();
    assignDb();
    addStudents();
    printStudents();
  }

  void assignDb() {
    setState(() {
      db = DatabaseHelper.instance;
    });
  }

  void printStudents() async {
    print(await db.getStudents());
  }

  void addStudents() async {
    Student s1 = Student(
        id: 1, name: 'Ali', age: 22, rollNumber: 'bsef18a007', semester: 7);
    db = DatabaseHelper.instance;
    await db.addStudent(s1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarShip(
                                    title: 'Composite',
                                  )));
                    },
                    child: const Text('Get Scholarship')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarShip(
                                    title: 'Adapter',
                                  )));
                    },
                    child: const Text('Get Actual Fee')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarShip(
                                    title: 'Strategy',
                                  )));
                    },
                    child: const Text('Get Elibities')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarShip(
                                    title: 'Mediator',
                                  )));
                    },
                    child: const Text('Book the room')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarShip(
                                    title: 'Pure Fabrication',
                                  )));
                    },
                    child: const Text('Add Student, Teacher or StaffMember')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScholarShip(
                                    title: 'View Data',
                                  )));
                    },
                    child: const Text('View Student, Teacher or StaffMember')),
              ),
              // Expanded(child: employees.displayPerson()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddStudent()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
