import '../models/student.dart';
import '../models/course.dart';
import '../models/enrollment.dart';
import '../models/grade.dart';

/// Exception thrown when validation fails
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

/// Main manager class for the Course Enrollment Management System
class CEMSManager {
  // Use Maps for O(1) lookup performance
  final Map<String, Student> _students = {};
  final Map<String, Course> _courses = {};
  final List<Enrollment> _enrollments = [];

  // Getters
  List<Student> get students => _students.values.toList();
  List<Course> get courses => _courses.values.toList();
  List<Enrollment> get enrollments => _enrollments;

  // ==================== STUDENT MANAGEMENT ====================

  /// Add a new student to the system
  void addStudent({
    required String id,
    required String name,
    required String email,
    String? phoneNumber,
  }) {
    // Validate inputs
    if (id.trim().isEmpty) {
      throw ValidationException('Student ID cannot be empty');
    }
    if (name.trim().isEmpty) {
      throw ValidationException('Student name cannot be empty');
    }
    if (email.trim().isEmpty || !_isValidEmail(email)) {
      throw ValidationException('Invalid email address');
    }

    // Check for duplicate ID
    if (_students.containsKey(id)) {
      throw ValidationException('Student with ID $id already exists');
    }

    // Check for duplicate email
    if (_students.values.any((s) => s.email.toLowerCase() == email.toLowerCase())) {
      throw ValidationException('Student with email $email already exists');
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
      throw ValidationException('Student with ID $id not found');
    }

    if (name != null && name.trim().isNotEmpty) {
      student.name = name;
    }

    if (email != null) {
      if (!_isValidEmail(email)) {
        throw ValidationException('Invalid email address');
      }
      // Check if email is already used by another student
      if (_students.values.any((s) => s.id != id && s.email.toLowerCase() == email.toLowerCase())) {
        throw ValidationException('Email $email is already in use');
      }
      student.email = email;
    }

    if (phoneNumber != null) {
      student.phoneNumber = phoneNumber.trim().isEmpty ? null : phoneNumber;
    }
  }

  /// Delete a student from the system
  void deleteStudent(String id) {
    final student = _students[id];
    if (student == null) {
      throw ValidationException('Student with ID $id not found');
    }

    // Remove all enrollments for this student
    _enrollments.removeWhere((e) => e.student.id == id);
    
    // Remove from courses
    for (var course in _courses.values) {
      course.enrollments.removeWhere((e) => e.student.id == id);
    }

    _students.remove(id);
  }

  /// Get student by ID
  Student? getStudent(String id) => _students[id];

  /// Search students by name
  List<Student> searchStudentsByName(String query) {
    final lowerQuery = query.toLowerCase();
    return _students.values
        .where((s) => s.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // ==================== COURSE MANAGEMENT ====================

  /// Add a new course to the system
  void addCourse({
    required String courseCode,
    required String courseName,
    required int creditHours,
  }) {
    // Validate inputs
    if (courseCode.trim().isEmpty) {
      throw ValidationException('Course code cannot be empty');
    }
    if (courseName.trim().isEmpty) {
      throw ValidationException('Course name cannot be empty');
    }
    if (creditHours <= 0) {
      throw ValidationException('Credit hours must be greater than 0');
    }

    // Check for duplicate course code
    if (_courses.containsKey(courseCode)) {
      throw ValidationException('Course with code $courseCode already exists');
    }

    final course = Course(
      courseCode: courseCode,
      courseName: courseName,
      creditHours: creditHours,
    );

    _courses[courseCode] = course;
  }

  /// Update an existing course
  void updateCourse({
    required String courseCode,
    String? courseName,
    int? creditHours,
  }) {
    final course = _courses[courseCode];
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }

    if (courseName != null && courseName.trim().isNotEmpty) {
      course.courseName = courseName;
    }

    if (creditHours != null) {
      if (creditHours <= 0) {
        throw ValidationException('Credit hours must be greater than 0');
      }
      course.creditHours = creditHours;
    }
  }

  /// Delete a course from the system
  void deleteCourse(String courseCode) {
    final course = _courses[courseCode];
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }

    // Remove all enrollments for this course
    _enrollments.removeWhere((e) => e.course.courseCode == courseCode);
    
    // Remove from students
    for (var student in _students.values) {
      student.enrollments.removeWhere((e) => e.course.courseCode == courseCode);
    }

    _courses.remove(courseCode);
  }

  /// Get course by code
  Course? getCourse(String courseCode) => _courses[courseCode];

  /// Search courses by code or name
  List<Course> searchCourses(String query) {
    final lowerQuery = query.toLowerCase();
    return _courses.values
        .where((c) =>
            c.courseCode.toLowerCase().contains(lowerQuery) ||
            c.courseName.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // ==================== ENROLLMENT MANAGEMENT ====================

  /// Enroll a student in a course
  Enrollment enrollStudent({
    required String studentId,
    required String courseCode,
  }) {
    final student = _students[studentId];
    final course = _courses[courseCode];

    if (student == null) {
      throw ValidationException('Student with ID $studentId not found');
    }
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }

    // Check for duplicate enrollment
    if (student.isEnrolledIn(courseCode)) {
      throw ValidationException('Student ${student.name} is already enrolled in ${course.courseName}');
    }

    final enrollment = Enrollment(
      student: student,
      course: course,
    );

    _enrollments.add(enrollment);
    student.enrollments.add(enrollment);
    course.enrollments.add(enrollment);

    return enrollment;
  }

  /// Assign or update a grade for an enrollment
  void assignGrade({
    required String studentId,
    required String courseCode,
    required Grade grade,
  }) {
    final student = _students[studentId];
    final course = _courses[courseCode];

    if (student == null) {
      throw ValidationException('Student with ID $studentId not found');
    }
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }

    final enrollment = student.getEnrollment(courseCode);
    if (enrollment == null) {
      throw ValidationException('Student ${student.name} is not enrolled in ${course.courseName}');
    }

    enrollment.assignGrade(grade);
  }

  /// Unenroll a student from a course
  void unenrollStudent({
    required String studentId,
    required String courseCode,
  }) {
    final student = _students[studentId];
    final course = _courses[courseCode];

    if (student == null) {
      throw ValidationException('Student with ID $studentId not found');
    }
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }

    _enrollments.removeWhere(
      (e) => e.student.id == studentId && e.course.courseCode == courseCode,
    );
    student.enrollments.removeWhere((e) => e.course.courseCode == courseCode);
    course.enrollments.removeWhere((e) => e.student.id == studentId);
  }

  // ==================== REPORTS & ANALYTICS ====================

  /// Get all students sorted by GPA (descending)
  List<Student> getStudentsByGPA() {
    final sortedStudents = students.toList();
    sortedStudents.sort((a, b) => b.calculateGPA().compareTo(a.calculateGPA()));
    return sortedStudents;
  }

  /// Get all students sorted by name
  List<Student> getStudentsByName() {
    final sortedStudents = students.toList();
    sortedStudents.sort((a, b) => a.name.compareTo(b.name));
    return sortedStudents;
  }

  /// Get top performing students
  List<Student> getTopStudents({int limit = 5}) {
    return getStudentsByGPA().take(limit).toList();
  }

  /// Get course roster (all students enrolled in a course)
  List<Enrollment> getCourseRoster(String courseCode) {
    final course = _courses[courseCode];
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }
    return course.enrollments;
  }

  /// Get student transcript (all courses with grades)
  List<Enrollment> getStudentTranscript(String studentId) {
    final student = _students[studentId];
    if (student == null) {
      throw ValidationException('Student with ID $studentId not found');
    }
    return student.enrollments;
  }

  /// Get course statistics
  Map<String, dynamic> getCourseStatistics(String courseCode) {
    final course = _courses[courseCode];
    if (course == null) {
      throw ValidationException('Course with code $courseCode not found');
    }

    return {
      'courseCode': course.courseCode,
      'courseName': course.courseName,
      'totalStudents': course.getEnrollmentCount(),
      'averageGrade': course.calculateAverageGrade(),
      'gradeDistribution': course.getGradeDistribution(),
    };
  }

  /// Get overall system statistics
  Map<String, dynamic> getSystemStatistics() {
    int totalGradedEnrollments = _enrollments.where((e) => e.grade != null).length;
    double overallGPA = 0.0;

    if (_students.isNotEmpty) {
      double totalGPA = _students.values.fold(0.0, (sum, s) => sum + s.calculateGPA());
      overallGPA = totalGPA / _students.length;
    }

    return {
      'totalStudents': _students.length,
      'totalCourses': _courses.length,
      'totalEnrollments': _enrollments.length,
      'gradedEnrollments': totalGradedEnrollments,
      'overallGPA': overallGPA,
    };
  }

  // ==================== HELPER METHODS ====================

  /// Validate email format
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Clear all data (for testing purposes)
  void clearAll() {
    _students.clear();
    _courses.clear();
    _enrollments.clear();
  }
}

