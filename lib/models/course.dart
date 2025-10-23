import 'enrollment.dart';
import 'grade.dart';

/// Represents a course in the system
class Course {
  final String courseCode;
  String courseName;
  int creditHours;
  final List<Enrollment> enrollments;

  Course({
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
  }) : enrollments = [];

  /// Get total number of students enrolled
  int getEnrollmentCount() => enrollments.length;

  /// Calculate average grade for the course
  double calculateAverageGrade() {
    var gradedEnrollments = enrollments.where((e) => e.grade != null).toList();
    if (gradedEnrollments.isEmpty) return 0.0;

    double totalGradePoints = gradedEnrollments.fold(
      0.0,
      (sum, e) => sum + e.grade!.gradePoint,
    );

    return totalGradePoints / gradedEnrollments.length;
  }

  /// Get grade distribution for the course
  Map<Grade, int> getGradeDistribution() {
    Map<Grade, int> distribution = {};
    for (var enrollment in enrollments) {
      if (enrollment.grade != null) {
        distribution[enrollment.grade!] = (distribution[enrollment.grade!] ?? 0) + 1;
      }
    }
    return distribution;
  }

  /// Check if a student is enrolled in this course
  bool hasStudent(String studentId) {
    return enrollments.any((e) => e.student.id == studentId);
  }

  @override
  String toString() {
    return 'Course[Code: $courseCode, Name: $courseName, Credits: $creditHours, Enrolled: ${getEnrollmentCount()}]';
  }

  /// Display detailed course information
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('╔════════════════════════════════════════════╗');
    buffer.writeln('║          COURSE INFORMATION                ║');
    buffer.writeln('╠════════════════════════════════════════════╣');
    buffer.writeln('  Code:         $courseCode');
    buffer.writeln('  Name:         $courseName');
    buffer.writeln('  Credits:      $creditHours');
    buffer.writeln('  Enrolled:     ${getEnrollmentCount()} students');
    buffer.writeln('  Avg Grade:    ${calculateAverageGrade().toStringAsFixed(2)}');
    buffer.writeln('╚════════════════════════════════════════════╝');
    return buffer.toString();
  }
}

