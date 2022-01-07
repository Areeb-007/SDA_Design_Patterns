import 'package:composite_on_flutter/classes/adapter_pattern/fee_adapter.dart';
import 'package:composite_on_flutter/classes/composite_pattern/best_scholarship.dart';
import 'package:composite_on_flutter/classes/composite_pattern/scholarship_strategies.dart';
import 'package:composite_on_flutter/classes/mediator_pattern/i_room_allocator.dart';
import 'package:composite_on_flutter/classes/mediator_pattern/room.dart';
import 'package:composite_on_flutter/classes/mediator_pattern/room_allocator.dart';
import 'package:composite_on_flutter/classes/person_class.dart';
import 'package:composite_on_flutter/classes/staff_member_class.dart';
import 'package:composite_on_flutter/classes/student_class.dart';
import 'package:composite_on_flutter/classes/teacher_class.dart';
import 'package:composite_on_flutter/data/database_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScholarShip extends StatefulWidget {
  ScholarShip({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  _ScholarShipState createState() => _ScholarShipState();
}

class _ScholarShipState extends State<ScholarShip> {
  String rollNumber = '';
  double semesterFee = 0;
  double academicsFee = 0;
  double updatedFee = 0;
  bool showUpdatedFee = false;
  ScholarShipStrategyOnDegree onDegree = ScholarShipStrategyOnDegree(
      discountPercentageForSE: 25,
      discountPercentageForCS: 30,
      discountPercentageForIT: 20);
  ScholarShipStrategyOnSection onSection = ScholarShipStrategyOnSection(
      discountPercentageForAfternoon: 50, discountPercentageForMorning: 30);
  bool isLoading = false;
  CompositeBestForScholarShip bestForScholarShip =
      CompositeBestForScholarShip();
  IRoomAllocator ira = RoomAllocator();
  late Room room1;
  bool showTheButton = false;
  bool showAddStudent = false;
  bool showAddTeacher = false;
  bool showAddStaffMember = false;
  bool showStudentData = false;
  bool showTeacherData = false;
  bool showStaffMemberData = false;
  List<Student> students = [];
  List<Teacher> teachers = [];
  List<StaffMembers> staffMembers = [];
  void loadUpStudents() async {
    DatabaseHelper dbh = DatabaseHelper.instance;
    students = await dbh.getStudents();
  }

  void loadUpTeachers() async {
    DatabaseHelper dbh = DatabaseHelper.instance;

    teachers = await dbh.getTeachers();
  }

  void loadUpStaffMembers() async {
    DatabaseHelper dbh = DatabaseHelper.instance;

    staffMembers = await dbh.getStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: showBody(widget.title));
  }

  Widget showBody(String title) {
    if (title == 'Composite') {
      return getScholarShip();
    } else if (title == 'Adapter') {
      return calcuateFee();
    } else if (title == 'Strategy') {
      return getEligiblities();
    } else if (title == 'Mediator') {
      return bookARoom();
    } else if (title == 'Pure Fabrication') {
      return addStudentTeacherStaffMember();
    } else if (title == 'View Data') {
      return viewStudentTeacherStaffMember();
    } else {
      return Container();
    }
  }

  Widget bookARoom() {
    room1 = Room(ira);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                bool status = room1.bookTheRoom();
                if (status) {
                  setState(() {
                    showTheButton = true;
                  });
                  Fluttertoast.showToast(
                      msg: "Room Booked",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: "Room not available",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Text('Click to book a room'),
            ),
          ),
          showTheButton
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      room1.freeTheRom();
                      setState(() {
                        showTheButton = false;
                      });
                    },
                    child: Text('Click to unalocate the room'),
                  ))
              : Container()
        ],
      ),
    );
  }

  Widget viewStudentTeacherStaffMember() {
    return Container(
        child: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                // isLoading = true;
                showStudentData = true;
                showTeacherData = false;
                showStaffMemberData = false;
              });
            },
            child: const Text('View Students')),
        ElevatedButton(
            onPressed: () {
              setState(() {
                showStudentData = false;
                showTeacherData = true;
                showStaffMemberData = false;
              });
            },
            child: const Text('View Teachers')),
        ElevatedButton(
            onPressed: () {
              setState(() {
                showStudentData = false;
                showTeacherData = false;
                showStaffMemberData = true;
              });
            },
            child: const Text('View StaffMembers')),
        showStudentData
            ? studentData()
            : showTeacherData
                ? teacherData()
                : showStaffMemberData
                    ? staffMemberData()
                    : Container()
      ],
    ));
  }

  Widget studentData() {
    loadUpStudents();
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: students[index].displayPerson(),
          );
        },
      ),
    );
  }

  Widget teacherData() {
    loadUpTeachers();
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: teachers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: teachers[index].displayPerson(),
          );
        },
      ),
    );
  }

  Widget staffMemberData() {
    loadUpStaffMembers();
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: staffMembers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: staffMembers[index].displayPerson(),
          );
        },
      ),
    );
  }

  Widget addStudentTeacherStaffMember() {
    late int id;
    late String name;
    late int age;
    late String rollNumber;
    late int semester;
    late String designation;
    late String course;
    Widget forStudent() {
      return Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Roll Numbers')),
            onChanged: (val) {
              rollNumber = (val);
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Semester')),
            onChanged: (val) {
              semester = int.parse(val);
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                if (id < 1 ||
                    name.isEmpty ||
                    age < 1 ||
                    rollNumber.isEmpty ||
                    semester < 1) {
                  Fluttertoast.showToast(
                      msg: "Invalid Fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Student s1 = Student(
                    id: id,
                    age: age,
                    name: name,
                    rollNumber: rollNumber,
                    semester: semester,
                  );
                  DatabaseHelper databaseHelper = DatabaseHelper.instance;
                  databaseHelper.addStudent(s1);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'))
        ],
      );
    }

    Widget forTeacher() {
      return Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Course')),
            onChanged: (val) {
              course = (val);
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
              ),
              onPressed: () {
                if (id < 1 || name.isEmpty || age < 1 || course.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Invalid Fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Teacher t1 = Teacher(
                    id: id,
                    age: age,
                    name: name,
                    course: course,
                  );
                  DatabaseHelper databaseHelper = DatabaseHelper.instance;
                  databaseHelper.addTeacher(t1);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'))
        ],
      );
    }

    Widget forStaffMembers() {
      return Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Designation')),
            onChanged: (val) {
              designation = (val);
            },
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                if (id < 1 || name.isEmpty || age < 1 || designation.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Invalid Fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  StaffMembers st1 = StaffMembers(
                    id: id,
                    age: age,
                    name: name,
                    designation: designation,
                  );
                  DatabaseHelper databaseHelper = DatabaseHelper.instance;
                  databaseHelper.addStaffMember(st1);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'))
        ],
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    showAddStudent = true;
                    showAddTeacher = false;
                    showAddStaffMember = false;
                  });
                },
                child: const Text('Add Student')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    showAddStudent = false;
                    showAddTeacher = true;
                    showAddStaffMember = false;
                    isLoading = true;
                  });
                },
                child: const Text('Add Teacher')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    showAddStudent = false;
                    showAddTeacher = false;
                    showAddStaffMember = true;
                  });
                },
                child: const Text('Add StaffMembers')),
            isLoading
                ? Card(
                    elevation: 10,
                    shadowColor: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(label: Text('ID')),
                            onChanged: (val) {
                              id = int.parse(val);
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(label: Text('Name')),
                            onChanged: (val) {
                              name = (val);
                            },
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(label: Text('Age')),
                            onChanged: (val) {
                              age = int.parse(val);
                            },
                          ),
                          showAddStudent
                              ? forStudent()
                              : showAddTeacher
                                  ? forTeacher()
                                  : showAddStaffMember
                                      ? forStaffMembers()
                                      : Container()
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget calcuateFee() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Academics Fee')),
              onChanged: (val) {
                academicsFee = double.parse(val);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : showUpdatedFee
                    ? Text('Your actual semester fee will be : RS $updatedFee')
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          if (academicsFee <= 0) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Fee invalid",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            FeeAdapter feeAdapter = FeeAdapter();
                            updatedFee = academicsFee +
                                feeAdapter.calculateFee(academicsFee);
                            setState(() {
                              showUpdatedFee = true;
                              isLoading = false;
                            });
                          }
                        },
                        child: const Text('Calculate new Fee'))
          ],
        ),
      ),
    );
  }

  Widget getEligiblities() {
    Student s1 = Student(
        id: 1, name: 'Ali', age: 22, rollNumber: 'bsef18a007', semester: 7);
    Teacher t1 = Teacher(id: 2, name: 'Teacher 1', age: 30, course: 'PF');
    Teacher t2 = Teacher(id: 3, name: 'Teacher 2', age: 32, course: 'OOP');
    StaffMembers stf1 = StaffMembers(
        id: 4, name: 'Staff Member 1', age: 35, designation: 'Exam Brach');
    StaffMembers stf2 = StaffMembers(
        id: 5, name: 'Staff Member 2', age: 36, designation: 'Account Brach');
    List<Person> persons = [s1, t1, t2, stf1, stf2];
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Elibility : ' + persons[index].getEliblity()),
            );
          },
        ),
      ),
    );
  }

  Widget getScholarShip() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Roll Number')),
              onChanged: (val) {
                rollNumber = val;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Semester Fee')),
              onChanged: (val) {
                semesterFee = double.parse(val);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : showUpdatedFee
                    ? Text('Your new semester fee will be : RS $updatedFee')
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          if (rollNumber.isEmpty || semesterFee <= 0) {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Roll Number or semester fee invalid",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            bestForScholarShip.addStrategy(onDegree);
                            bestForScholarShip.addStrategy(onSection);
                            updatedFee = semesterFee -
                                bestForScholarShip.getScholarShip(
                                    rollNumber, semesterFee);
                            setState(() {
                              showUpdatedFee = true;
                              isLoading = false;
                            });
                          }
                        },
                        child: const Text('Calculate new Fee'))
          ],
        ),
      ),
    );
  }
}
