import 'student.dart';
import 'course.dart';
import 'grade.dart';

/// Represents an enrollment connecting a student to a course
class Enrollment {
  final Student student;
  final Course course;
  Grade? grade;
  final DateTime enrollmentDate;

  Enrollment({
    required this.student,
    required this.course,
    this.grade,
  }) : enrollmentDate = DateTime.now();

  /// Assign or update grade for this enrollment
  void assignGrade(Grade newGrade) {
    grade = newGrade;
  }

  /// Check if this enrollment has been graded
  bool get isGraded => grade != null;

  /// Check if student passed (grade >= D)
  bool get isPassing {
    return grade != null && grade!.gradePoint >= 1.0;
  }

  @override
  String toString() {
    final gradeStr = grade?.letter ?? 'Not Graded';
    return 'Enrollment{student: ${student.name}, course: ${course.courseCode}, grade: $gradeStr}';
  }

  /// Short string representation for display
  String toShortString() {
    final gradeStr = grade?.coloredString ?? '\x1B[90mNot Graded\x1B[0m';
    return '${course.courseCode}: ${course.courseName} (${course.creditHours} credits) - Grade: $gradeStr';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Enrollment &&
        other.student.id == student.id &&
        other.course.courseCode == course.courseCode;
  }

  @override
  int get hashCode => student.id.hashCode ^ course.courseCode.hashCode;
}

