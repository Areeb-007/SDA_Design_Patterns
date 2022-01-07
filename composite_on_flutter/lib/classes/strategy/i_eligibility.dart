class IEligibility {
  String getEligibility() {
    throw Exception('Some arbitrary error');
  }
}

class StudentEligiblity implements IEligibility {
  @override
  String getEligibility() {
    return 'This is a student and is eligible for using lab, libraries and cafe';
  }
}

class TeacherEligiblity implements IEligibility {
  @override
  String getEligibility() {
    return 'This is a teacher and is eligible for using lab, libraries, internet and also eligible to become prinicple';
  }
}

class StaffEligiblity implements IEligibility {
  @override
  String getEligibility() {
    return 'This is a staff member and is eligible for using lab, libraries, internet and hostels';
  }
}
