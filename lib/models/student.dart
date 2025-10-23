import 'enrollment.dart';

/// Represents a student in the system
class Student {
  final String id;
  String name;
  String email;
  String? phoneNumber;
  final List<Enrollment> enrollments;

  Student({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
  }) : enrollments = [];

  /// Calculate the student's GPA based on enrolled courses with grades
  double calculateGPA() {
    if (enrollments.isEmpty) return 0.0;

    var gradedEnrollments = enrollments.where((e) => e.grade != null).toList();
    if (gradedEnrollments.isEmpty) return 0.0;

    double totalPoints = 0.0;
    int totalCredits = 0;

    for (var enrollment in gradedEnrollments) {
      totalPoints += enrollment.grade!.gradePoint * enrollment.course.creditHours;
      totalCredits += enrollment.course.creditHours;
    }

    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  /// Get total credit hours enrolled
  int getTotalCreditHours() {
    return enrollments.fold(0, (sum, e) => sum + e.course.creditHours);
  }

  /// Check if student is enrolled in a specific course
  bool isEnrolledIn(String courseCode) {
    return enrollments.any((e) => e.course.courseCode == courseCode);
  }

  /// Get enrollment for a specific course
  Enrollment? getEnrollment(String courseCode) {
    try {
      return enrollments.firstWhere((e) => e.course.courseCode == courseCode);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return 'Student[ID: $id, Name: $name, Email: $email, Phone: ${phoneNumber ?? 'N/A'}, GPA: ${calculateGPA().toStringAsFixed(2)}]';
  }

  /// Display detailed student information
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('╔════════════════════════════════════════════╗');
    buffer.writeln('║          STUDENT INFORMATION               ║');
    buffer.writeln('╠════════════════════════════════════════════╣');
    buffer.writeln('  ID:           $id');
    buffer.writeln('  Name:         $name');
    buffer.writeln('  Email:        $email');
    buffer.writeln('  Phone:        ${phoneNumber ?? 'N/A'}');
    buffer.writeln('  GPA:          ${calculateGPA().toStringAsFixed(2)}');
    buffer.writeln('  Credits:      ${getTotalCreditHours()}');
    buffer.writeln('╚════════════════════════════════════════════╝');
    return buffer.toString();
  }
}

