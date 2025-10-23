import '../services/cems_manager.dart';
import '../models/grade.dart';

/// Utility class to populate the system with sample data for testing
class SampleData {
  /// Load sample data into the CEMS manager
  static void loadSampleData(CEMSManager manager) {
    try {
      // Add sample students
      manager.addStudent(
        id: 'S001',
        name: 'Alice Johnson',
        email: 'alice.johnson@university.edu',
        phoneNumber: '+1-555-0101',
      );

      manager.addStudent(
        id: 'S002',
        name: 'Bob Smith',
        email: 'bob.smith@university.edu',
        phoneNumber: '+1-555-0102',
      );

      manager.addStudent(
        id: 'S003',
        name: 'Charlie Brown',
        email: 'charlie.brown@university.edu',
        phoneNumber: '+1-555-0103',
      );

      manager.addStudent(
        id: 'S004',
        name: 'Diana Prince',
        email: 'diana.prince@university.edu',
      );

      manager.addStudent(
        id: 'S005',
        name: 'Ethan Hunt',
        email: 'ethan.hunt@university.edu',
        phoneNumber: '+1-555-0105',
      );

      // Add sample courses
      manager.addCourse(
        courseCode: 'CS101',
        courseName: 'Introduction to Computer Science',
        creditHours: 3,
      );

      manager.addCourse(
        courseCode: 'CS201',
        courseName: 'Data Structures and Algorithms',
        creditHours: 4,
      );

      manager.addCourse(
        courseCode: 'CS301',
        courseName: 'Database Systems',
        creditHours: 3,
      );

      manager.addCourse(
        courseCode: 'MATH101',
        courseName: 'Calculus I',
        creditHours: 4,
      );

      manager.addCourse(
        courseCode: 'MATH201',
        courseName: 'Linear Algebra',
        creditHours: 3,
      );

      manager.addCourse(
        courseCode: 'ENG101',
        courseName: 'English Composition',
        creditHours: 3,
      );

      // Enroll students in courses
      // Alice Johnson enrollments
      manager.enrollStudent(studentId: 'S001', courseCode: 'CS101');
      manager.assignGrade(studentId: 'S001', courseCode: 'CS101', grade: Grade.aPlus);

      manager.enrollStudent(studentId: 'S001', courseCode: 'MATH101');
      manager.assignGrade(studentId: 'S001', courseCode: 'MATH101', grade: Grade.a);

      manager.enrollStudent(studentId: 'S001', courseCode: 'ENG101');
      manager.assignGrade(studentId: 'S001', courseCode: 'ENG101', grade: Grade.aMinus);

      // Bob Smith enrollments
      manager.enrollStudent(studentId: 'S002', courseCode: 'CS101');
      manager.assignGrade(studentId: 'S002', courseCode: 'CS101', grade: Grade.bPlus);

      manager.enrollStudent(studentId: 'S002', courseCode: 'CS201');
      manager.assignGrade(studentId: 'S002', courseCode: 'CS201', grade: Grade.b);

      manager.enrollStudent(studentId: 'S002', courseCode: 'MATH101');
      manager.assignGrade(studentId: 'S002', courseCode: 'MATH101', grade: Grade.bMinus);

      // Charlie Brown enrollments
      manager.enrollStudent(studentId: 'S003', courseCode: 'CS201');
      manager.assignGrade(studentId: 'S003', courseCode: 'CS201', grade: Grade.a);

      manager.enrollStudent(studentId: 'S003', courseCode: 'CS301');
      manager.assignGrade(studentId: 'S003', courseCode: 'CS301', grade: Grade.aMinus);

      manager.enrollStudent(studentId: 'S003', courseCode: 'MATH201');
      manager.assignGrade(studentId: 'S003', courseCode: 'MATH201', grade: Grade.bPlus);

      // Diana Prince enrollments
      manager.enrollStudent(studentId: 'S004', courseCode: 'CS101');
      manager.assignGrade(studentId: 'S004', courseCode: 'CS101', grade: Grade.aPlus);

      manager.enrollStudent(studentId: 'S004', courseCode: 'CS201');
      manager.assignGrade(studentId: 'S004', courseCode: 'CS201', grade: Grade.a);

      manager.enrollStudent(studentId: 'S004', courseCode: 'ENG101');
      manager.assignGrade(studentId: 'S004', courseCode: 'ENG101', grade: Grade.a);

      manager.enrollStudent(studentId: 'S004', courseCode: 'MATH101');
      manager.assignGrade(studentId: 'S004', courseCode: 'MATH101', grade: Grade.aPlus);

      // Ethan Hunt enrollments
      manager.enrollStudent(studentId: 'S005', courseCode: 'CS301');
      manager.assignGrade(studentId: 'S005', courseCode: 'CS301', grade: Grade.c);

      manager.enrollStudent(studentId: 'S005', courseCode: 'ENG101');
      manager.assignGrade(studentId: 'S005', courseCode: 'ENG101', grade: Grade.cPlus);

      manager.enrollStudent(studentId: 'S005', courseCode: 'MATH201');
      // No grade assigned yet for this enrollment

      print('✓ Sample data loaded successfully!');
      print('  - 5 students added');
      print('  - 6 courses added');
      print('  - 16 enrollments created');
      print('  - 15 grades assigned\n');
    } catch (e) {
      print('Error loading sample data: $e');
    }
  }
}

