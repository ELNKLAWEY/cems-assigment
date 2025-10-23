import 'enrollment.dart';

/// Represents a student in the system
class Student {
  final String id;
  String name;
  String email;
  String? phoneNumber;
  final List<Enrollment> enrollments = [];

  Student({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
  }) {
    _validateEmail(email);
  }

  /// Validate email format
  void _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      throw ArgumentError('Invalid email format: $email');
    }
  }

  /// Add an enrollment for this student
  void addEnrollment(Enrollment enrollment) {
    enrollments.add(enrollment);
  }

  /// Remove an enrollment
  bool removeEnrollment(Enrollment enrollment) {
    return enrollments.remove(enrollment);
  }

  /// Calculate GPA based on all enrollments with grades
  double calculateGPA() {
    final gradedEnrollments = enrollments.where((e) => e.grade != null).toList();
    
    if (gradedEnrollments.isEmpty) {
      return 0.0;
    }

    double totalPoints = 0.0;
    int totalCredits = 0;

    for (var enrollment in gradedEnrollments) {
      totalPoints += enrollment.grade!.gradePoint * enrollment.course.creditHours;
      totalCredits += enrollment.course.creditHours;
    }

    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  /// Get total credit hours enrolled
  int get totalCreditHours {
    return enrollments.fold(0, (sum, e) => sum + e.course.creditHours);
  }

  /// Get completed credit hours (courses with grades)
  int get completedCreditHours {
    return enrollments
        .where((e) => e.grade != null)
        .fold(0, (sum, e) => sum + e.course.creditHours);
  }

  /// Check if student is enrolled in a specific course
  bool isEnrolledIn(String courseCode) {
    return enrollments.any((e) => e.course.courseCode == courseCode);
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, email: $email, phone: ${phoneNumber ?? "N/A"}}';
  }

  /// Detailed string representation with enrollments
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('━' * 60);
    buffer.writeln('Student ID: $id');
    buffer.writeln('Name: $name');
    buffer.writeln('Email: $email');
    buffer.writeln('Phone: ${phoneNumber ?? "N/A"}');
    buffer.writeln('GPA: ${calculateGPA().toStringAsFixed(2)}');
    buffer.writeln('Total Credits: $totalCreditHours');
    buffer.writeln('Completed Credits: $completedCreditHours');
    buffer.writeln('Enrollments: ${enrollments.length}');
    
    if (enrollments.isNotEmpty) {
      buffer.writeln('\nEnrolled Courses:');
      for (var enrollment in enrollments) {
        buffer.writeln('  • ${enrollment.toShortString()}');
      }
    }
    buffer.writeln('━' * 60);
    
    return buffer.toString();
  }
}

