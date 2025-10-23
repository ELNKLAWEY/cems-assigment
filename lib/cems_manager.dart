import 'models/student.dart';
import 'models/course.dart';
import 'models/enrollment.dart';
import 'models/grade.dart';

/// Main manager class for the Course Enrollment Management System
class CEMSManager {
  final Map<String, Student> _students = {};
  final Map<String, Course> _courses = {};
  final List<Enrollment> _enrollments = [];

  // Getters
  List<Student> get students => _students.values.toList();
  List<Course> get courses => _courses.values.toList();
  List<Enrollment> get enrollments => _enrollments;

  /// Add a new student to the system
  void addStudent({
    required String id,
    required String name,
    required String email,
    String? phoneNumber,
  }) {
    // Check for duplicate ID
    if (_students.containsKey(id)) {
      throw ArgumentError('Student with ID $id already exists');
    }

    // Check for duplicate email
    if (_students.values.any((s) => s.email.toLowerCase() == email.toLowerCase())) {
      throw ArgumentError('Student with email $email already exists');
    }

    final student = Student(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
    );

    _students[id] = student;
  }

  /// Update an existing student
  void updateStudent({
    required String id,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    final student = _students[id];
    if (student == null) {
      throw ArgumentError('Student with ID $id not found');
    }

    // Check for duplicate email if email is being changed
    if (email != null && email != student.email) {
      if (_students.values.any((s) => s.id != id && s.email.toLowerCase() == email.toLowerCase())) {
        throw ArgumentError('Student with email $email already exists');
      }
      student.email = email;
    }

    if (name != null) student.name = name;
    if (phoneNumber != null) student.phoneNumber = phoneNumber;
  }

  /// Delete a student from the system
  bool deleteStudent(String id) {
    final student = _students[id];
    if (student == null) return false;

    // Remove all enrollments for this student
    _enrollments.removeWhere((e) => e.student.id == id);
    
    // Remove student from courses
    for (var course in _courses.values) {
      course.enrollments.removeWhere((e) => e.student.id == id);
    }

    _students.remove(id);
    return true;
  }

  /// Get a student by ID
  Student? getStudent(String id) => _students[id];

  /// Search students by name (case-insensitive partial match)
  List<Student> searchStudents(String query) {
    final lowerQuery = query.toLowerCase();
    return _students.values
        .where((s) => s.name.toLowerCase().contains(lowerQuery) ||
                     s.email.toLowerCase().contains(lowerQuery) ||
                     s.id.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Add a new course to the system
  void addCourse({
    required String courseCode,
    required String courseName,
    required int creditHours,
  }) {
    // Check for duplicate course code
    if (_courses.containsKey(courseCode.toUpperCase())) {
      throw ArgumentError('Course with code $courseCode already exists');
    }

    final course = Course(
      courseCode: courseCode.toUpperCase(),
      courseName: courseName,
      creditHours: creditHours,
    );

    _courses[course.courseCode] = course;
  }

  /// Update an existing course
  void updateCourse({
    required String courseCode,
    String? courseName,
    int? creditHours,
  }) {
    final course = _courses[courseCode.toUpperCase()];
    if (course == null) {
      throw ArgumentError('Course with code $courseCode not found');
    }

    if (courseName != null) course.courseName = courseName;
    if (creditHours != null) {
      if (creditHours < 1 || creditHours > 6) {
        throw ArgumentError('Credit hours must be between 1 and 6');
      }
      course.creditHours = creditHours;
    }
  }

  /// Delete a course from the system
  bool deleteCourse(String courseCode) {
    final course = _courses[courseCode.toUpperCase()];
    if (course == null) return false;

    // Remove all enrollments for this course
    _enrollments.removeWhere((e) => e.course.courseCode == courseCode.toUpperCase());
    
    // Remove course from students
    for (var student in _students.values) {
      student.enrollments.removeWhere((e) => e.course.courseCode == courseCode.toUpperCase());
    }

    _courses.remove(courseCode.toUpperCase());
    return true;
  }

  /// Get a course by code
  Course? getCourse(String courseCode) => _courses[courseCode.toUpperCase()];

  /// Search courses by code or name (case-insensitive partial match)
  List<Course> searchCourses(String query) {
    final lowerQuery = query.toLowerCase();
    return _courses.values
        .where((c) => c.courseCode.toLowerCase().contains(lowerQuery) ||
                     c.courseName.toLowerCase().contains(lowerQuery))
        .toList();
  }

  /// Enroll a student in a course
  Enrollment enrollStudent({
    required String studentId,
    required String courseCode,
  }) {
    final student = _students[studentId];
    if (student == null) {
      throw ArgumentError('Student with ID $studentId not found');
    }

    final course = _courses[courseCode.toUpperCase()];
    if (course == null) {
      throw ArgumentError('Course with code $courseCode not found');
    }

    // Check for duplicate enrollment
    if (_enrollments.any((e) => e.student.id == studentId && 
                                e.course.courseCode == courseCode.toUpperCase())) {
      throw ArgumentError('Student $studentId is already enrolled in course $courseCode');
    }

    final enrollment = Enrollment(student: student, course: course);
    
    _enrollments.add(enrollment);
    student.addEnrollment(enrollment);
    course.addEnrollment(enrollment);

    return enrollment;
  }

  /// Unenroll a student from a course
  bool unenrollStudent({
    required String studentId,
    required String courseCode,
  }) {
    final enrollment = _enrollments.firstWhere(
      (e) => e.student.id == studentId && 
             e.course.courseCode == courseCode.toUpperCase(),
      orElse: () => throw ArgumentError('Enrollment not found'),
    );

    _enrollments.remove(enrollment);
    enrollment.student.removeEnrollment(enrollment);
    enrollment.course.removeEnrollment(enrollment);

    return true;
  }

  /// Assign a grade to a student's enrollment
  void assignGrade({
    required String studentId,
    required String courseCode,
    required Grade grade,
  }) {
    final enrollment = _enrollments.firstWhere(
      (e) => e.student.id == studentId && 
             e.course.courseCode == courseCode.toUpperCase(),
      orElse: () => throw ArgumentError('Enrollment not found for student $studentId in course $courseCode'),
    );

    enrollment.assignGrade(grade);
  }

  /// Get all enrollments for a specific student
  List<Enrollment> getStudentEnrollments(String studentId) {
    return _enrollments.where((e) => e.student.id == studentId).toList();
  }

  /// Get all enrollments for a specific course
  List<Enrollment> getCourseEnrollments(String courseCode) {
    return _enrollments.where((e) => e.course.courseCode == courseCode.toUpperCase()).toList();
  }

  /// Get top performing students by GPA
  List<Student> getTopStudents({int limit = 10}) {
    final studentList = _students.values.toList();
    studentList.sort((a, b) => b.calculateGPA().compareTo(a.calculateGPA()));
    return studentList.take(limit).toList();
  }

  /// Get students sorted by name
  List<Student> getStudentsSortedByName() {
    final studentList = _students.values.toList();
    studentList.sort((a, b) => a.name.compareTo(b.name));
    return studentList;
  }

  /// Get courses sorted by enrollment count
  List<Course> getCoursesSortedByEnrollment() {
    final courseList = _courses.values.toList();
    courseList.sort((a, b) => b.totalStudents.compareTo(a.totalStudents));
    return courseList;
  }

  /// Get system statistics
  Map<String, dynamic> getSystemStatistics() {
    final totalStudents = _students.length;
    final totalCourses = _courses.length;
    final totalEnrollments = _enrollments.length;
    final totalGradedEnrollments = _enrollments.where((e) => e.isGraded).length;

    double avgGPA = 0.0;
    if (totalStudents > 0) {
      final studentList = _students.values.toList();
      final totalGPA = studentList.fold(0.0, (sum, s) => sum + s.calculateGPA());
      avgGPA = totalGPA / totalStudents;
    }

    return {
      'totalStudents': totalStudents,
      'totalCourses': totalCourses,
      'totalEnrollments': totalEnrollments,
      'totalGradedEnrollments': totalGradedEnrollments,
      'averageGPA': avgGPA,
      'averageEnrollmentsPerStudent': totalStudents > 0 ? totalEnrollments / totalStudents : 0.0,
      'averageStudentsPerCourse': totalCourses > 0 ? totalEnrollments / totalCourses : 0.0,
    };
  }

  /// Clear all data (useful for testing)
  void clearAll() {
    _students.clear();
    _courses.clear();
    _enrollments.clear();
  }
}

