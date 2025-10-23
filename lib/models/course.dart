import 'enrollment.dart';
import 'grade.dart';

/// Represents a course in the system
class Course {
  final String courseCode;
  String courseName;
  int creditHours;
  final List<Enrollment> enrollments = [];

  Course({
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
  }) {
    _validateCreditHours(creditHours);
  }

  /// Validate credit hours
  void _validateCreditHours(int hours) {
    if (hours < 1 || hours > 6) {
      throw ArgumentError('Credit hours must be between 1 and 6');
    }
  }

  /// Add an enrollment for this course
  void addEnrollment(Enrollment enrollment) {
    enrollments.add(enrollment);
  }

  /// Remove an enrollment
  bool removeEnrollment(Enrollment enrollment) {
    return enrollments.remove(enrollment);
  }

  /// Get total number of students enrolled
  int get totalStudents => enrollments.length;

  /// Calculate average grade for this course
  double calculateAverageGrade() {
    final gradedEnrollments = enrollments.where((e) => e.grade != null).toList();
    
    if (gradedEnrollments.isEmpty) {
      return 0.0;
    }

    double totalGradePoints = gradedEnrollments
        .fold(0.0, (sum, e) => sum + e.grade!.gradePoint);
    
    return totalGradePoints / gradedEnrollments.length;
  }

  /// Get grade distribution as a map
  Map<Grade, int> getGradeDistribution() {
    final distribution = <Grade, int>{};
    
    for (var enrollment in enrollments) {
      if (enrollment.grade != null) {
        distribution[enrollment.grade!] = 
            (distribution[enrollment.grade!] ?? 0) + 1;
      }
    }
    
    return distribution;
  }

  /// Get list of students who passed (grade >= D)
  List<String> getPassingStudents() {
    return enrollments
        .where((e) => e.grade != null && e.grade!.gradePoint >= 1.0)
        .map((e) => e.student.name)
        .toList();
  }

  /// Get list of students who failed (grade = F)
  List<String> getFailingStudents() {
    return enrollments
        .where((e) => e.grade != null && e.grade!.gradePoint == 0.0)
        .map((e) => e.student.name)
        .toList();
  }

  @override
  String toString() {
    return 'Course{code: $courseCode, name: $courseName, credits: $creditHours}';
  }

  /// Detailed string representation with enrollments
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('━' * 60);
    buffer.writeln('Course Code: $courseCode');
    buffer.writeln('Course Name: $courseName');
    buffer.writeln('Credit Hours: $creditHours');
    buffer.writeln('Total Students: $totalStudents');
    buffer.writeln('Average Grade: ${calculateAverageGrade().toStringAsFixed(2)}');
    
    if (enrollments.isNotEmpty) {
      buffer.writeln('\nEnrolled Students:');
      for (var enrollment in enrollments) {
        final grade = enrollment.grade?.coloredString ?? 'Not Graded';
        buffer.writeln('  • ${enrollment.student.name} (${enrollment.student.id}) - Grade: $grade');
      }
      
      // Grade distribution
      final distribution = getGradeDistribution();
      if (distribution.isNotEmpty) {
        buffer.writeln('\nGrade Distribution:');
        for (var entry in distribution.entries) {
          buffer.writeln('  ${entry.key.coloredString}: ${entry.value} student(s)');
        }
      }
    }
    buffer.writeln('━' * 60);
    
    return buffer.toString();
  }
}

