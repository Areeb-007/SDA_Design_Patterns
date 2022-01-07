import 'dart:async';
import 'package:composite_on_flutter/classes/staff_member_class.dart';
import 'package:composite_on_flutter/classes/student_class.dart';
import 'package:composite_on_flutter/classes/teacher_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _DBNAME = "myDatabase.db";
  static final _DBVERSION = 1;
  Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get dataBase async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), _DBNAME),
        onCreate: _onCreate, version: _DBVERSION);
  }

  _onCreate(Database db, int dbVersion) async {
    const idType = 'INTEGER PRIMARY KEY';
    const idAutoType = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const doubleType = 'DOUBLE';

    await db.execute(
        'CREATE TABLE $studentTable (${StudentFields.id} $idType , ${StudentFields.name} $textType, ${StudentFields.age} $intType , ${StudentFields.rollNumber} $textType , ${StudentFields.semester} $intType)');
    await db.execute(
        'CREATE TABLE $staffMemberTable (${StaffMembersFields.id} $idType , ${StaffMembersFields.name} $textType, ${StaffMembersFields.age} $intType , ${StaffMembersFields.designation} $textType )');
    await db.execute(
        'CREATE TABLE $teacherTable (${TeachersFields.id} $idType , ${TeachersFields.name} $textType, ${TeachersFields.age} $intType , ${TeachersFields.course} $textType )');
  }

//-------------------------------------------------  Student  --------------------------------------------------
  Future<void> addStudent(Student student) async {
    Database? db = await instance.dataBase;
    await db!.insert(
      studentTable,
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> getStudents() async {
    Database? db = await instance.dataBase;
    final List<Map<String, dynamic>> maps = await db!.query(studentTable);
    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i][StudentFields.id],
        name: maps[i][StudentFields.name],
        age: maps[i][StudentFields.age],
        rollNumber: maps[i][StudentFields.rollNumber],
        semester: maps[i][StudentFields.semester],
      );
    });
  }

//-------------------------------------------------  Teacher  --------------------------------------------------
  Future<void> addTeacher(Teacher teacher) async {
    print('Adding teacher');
    Database? db = await instance.dataBase;
    await db!
        .insert(
          teacherTable,
          teacher.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .whenComplete(() => print('Teacher added'));
  }

  Future<List<Teacher>> getTeachers() async {
    Database? db = await instance.dataBase;
    final List<Map<String, dynamic>> maps = await db!.query(studentTable);
    return List.generate(maps.length, (i) {
      return Teacher(
        id: maps[i][TeachersFields.id],
        name: maps[i][TeachersFields.name],
        age: maps[i][TeachersFields.age],
        course: maps[i][TeachersFields.course],
      );
    });
  }

//-------------------------------------------------  StaffMembers  --------------------------------------------------
  Future<void> addStaffMember(StaffMembers staffMembers) async {
    Database? db = await instance.dataBase;
    await db!.insert(
      staffMemberTable,
      staffMembers.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StaffMembers>> getStaff() async {
    Database? db = await instance.dataBase;
    final List<Map<String, dynamic>> maps = await db!.query(studentTable);
    return List.generate(maps.length, (i) {
      return StaffMembers(
        id: maps[i][StaffMembersFields.id],
        name: maps[i][StaffMembersFields.name],
        age: maps[i][StaffMembersFields.age],
        designation: maps[i][StaffMembersFields.designation],
      );
    });
  }
}
