import 'student.dart';
import 'course.dart';
import 'grade.dart';

/// Represents the enrollment of a student in a course
class Enrollment {
  final Student student;
  final Course course;
  Grade? grade;
  final DateTime enrollmentDate;

  Enrollment({
    required this.student,
    required this.course,
    this.grade,
    DateTime? enrollmentDate,
  }) : enrollmentDate = enrollmentDate ?? DateTime.now();

  /// Assign or update the grade for this enrollment
  void assignGrade(Grade newGrade) {
    grade = newGrade;
  }

  /// Check if the enrollment has been graded
  bool isGraded() => grade != null;

  @override
  String toString() {
    return 'Enrollment[Student: ${student.name}, Course: ${course.courseCode}, Grade: ${grade?.letter ?? 'Not Graded'}]';
  }

  /// Display detailed enrollment information
  String toDetailedString() {
    return '  ${student.name} (${student.id}) → ${course.courseName} (${course.courseCode}) - Grade: ${grade?.coloredString ?? 'Not Graded'}';
  }
}

