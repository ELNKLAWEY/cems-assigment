import '../cems_manager.dart';
import '../models/grade.dart';
import '../utils/input_validator.dart';
import '../utils/console_colors.dart';

/// Main console user interface for CEMS
class ConsoleUI {
  final CEMSManager _manager = CEMSManager();

  /// Start the application
  void run() {
    _loadSampleData();
    _showWelcome();
    
    while (true) {
      try {
        _showMainMenu();
        final choice = InputValidator.readInt('\n${ConsoleColors.cyan}Enter your choice: ${ConsoleColors.reset}', min: 0, max: 11);
        
        print(''); // Empty line for spacing
        
        switch (choice) {
          case 1:
            _addStudent();
            break;
          case 2:
            _addCourse();
            break;
          case 3:
            _enrollStudent();
            break;
          case 4:
            _assignGrade();
            break;
          case 5:
            _viewAllStudents();
            break;
          case 6:
            _viewAllCourses();
            break;
          case 7:
            _viewStudentDetails();
            break;
          case 8:
            _viewCourseDetails();
            break;
          case 9:
            _viewStatistics();
            break;
          case 10:
            _viewTopStudents();
            break;
          case 11:
            _searchMenu();
            break;
          case 0:
            _exit();
            return;
        }
        
        InputValidator.waitForEnter();
      } catch (e) {
        print('${ConsoleColors.red}✗ Error: $e${ConsoleColors.reset}');
        InputValidator.waitForEnter();
      }
    }
  }

  /// Show welcome screen
  void _showWelcome() {
    InputValidator.clearScreen();
    print('''
${ConsoleColors.bold}${ConsoleColors.cyan}
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║     Course Enrollment Management System (CEMS)            ║
║                                                            ║
║          Welcome to the Student Portal                    ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
${ConsoleColors.reset}
''');
    InputValidator.waitForEnter('Press Enter to start...');
  }

  /// Show main menu
  void _showMainMenu() {
    InputValidator.clearScreen();
    print('''
${ConsoleColors.bold}${ConsoleColors.cyan}╔════════════════════════════════════════════════════════════╗
║                      MAIN MENU                             ║
╚════════════════════════════════════════════════════════════╝${ConsoleColors.reset}

${ConsoleColors.green}Student Management:${ConsoleColors.reset}
  ${ConsoleColors.bold}1.${ConsoleColors.reset} Add New Student
  ${ConsoleColors.bold}2.${ConsoleColors.reset} Add New Course

${ConsoleColors.yellow}Enrollment Management:${ConsoleColors.reset}
  ${ConsoleColors.bold}3.${ConsoleColors.reset} Enroll Student in Course
  ${ConsoleColors.bold}4.${ConsoleColors.reset} Assign Grade to Student

${ConsoleColors.blue}View & Reports:${ConsoleColors.reset}
  ${ConsoleColors.bold}5.${ConsoleColors.reset} View All Students
  ${ConsoleColors.bold}6.${ConsoleColors.reset} View All Courses
  ${ConsoleColors.bold}7.${ConsoleColors.reset} View Student Details
  ${ConsoleColors.bold}8.${ConsoleColors.reset} View Course Details

${ConsoleColors.magenta}Statistics & Analysis:${ConsoleColors.reset}
  ${ConsoleColors.bold}9.${ConsoleColors.reset} View System Statistics
  ${ConsoleColors.bold}10.${ConsoleColors.reset} View Top Performing Students
  ${ConsoleColors.bold}11.${ConsoleColors.reset} Search (Students/Courses)

${ConsoleColors.red}${ConsoleColors.bold}0.${ConsoleColors.reset} Exit System
''');
  }

  /// Add new student
  void _addStudent() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Add New Student ═══${ConsoleColors.reset}\n');
    
    try {
      final id = InputValidator.readString('Student ID: ');
      final name = InputValidator.readString('Student Name: ');
      final email = InputValidator.readEmail('Email: ');
      final phone = InputValidator.readOptionalString('Phone Number (optional): ');
      
      _manager.addStudent(
        id: id,
        name: name,
        email: email,
        phoneNumber: phone,
      );
      
      print('\n${ConsoleColors.green}✓ Student added successfully!${ConsoleColors.reset}');
    } catch (e) {
      print('\n${ConsoleColors.red}✗ Error: $e${ConsoleColors.reset}');
    }
  }

  /// Add new course
  void _addCourse() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Add New Course ═══${ConsoleColors.reset}\n');
    
    try {
      final code = InputValidator.readString('Course Code (e.g., CS101): ');
      final name = InputValidator.readString('Course Name: ');
      final credits = InputValidator.readInt('Credit Hours (1-6): ', min: 1, max: 6);
      
      _manager.addCourse(
        courseCode: code,
        courseName: name,
        creditHours: credits,
      );
      
      print('\n${ConsoleColors.green}✓ Course added successfully!${ConsoleColors.reset}');
    } catch (e) {
      print('\n${ConsoleColors.red}✗ Error: $e${ConsoleColors.reset}');
    }
  }

  /// Enroll student in course
  void _enrollStudent() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Enroll Student in Course ═══${ConsoleColors.reset}\n');
    
    try {
      // Show available students
      if (_manager.students.isEmpty) {
        print('${ConsoleColors.yellow}⚠ No students available. Please add students first.${ConsoleColors.reset}');
        return;
      }
      
      if (_manager.courses.isEmpty) {
        print('${ConsoleColors.yellow}⚠ No courses available. Please add courses first.${ConsoleColors.reset}');
        return;
      }
      
      print('${ConsoleColors.bold}Available Students:${ConsoleColors.reset}');
      for (var student in _manager.students) {
        print('  • ${student.id}: ${student.name}');
      }
      
      final studentId = InputValidator.readString('\nEnter Student ID: ');
      
      print('\n${ConsoleColors.bold}Available Courses:${ConsoleColors.reset}');
      for (var course in _manager.courses) {
        print('  • ${course.courseCode}: ${course.courseName} (${course.creditHours} credits)');
      }
      
      final courseCode = InputValidator.readString('\nEnter Course Code: ');
      
      _manager.enrollStudent(studentId: studentId, courseCode: courseCode);
      
      print('\n${ConsoleColors.green}✓ Student enrolled successfully!${ConsoleColors.reset}');
    } catch (e) {
      print('\n${ConsoleColors.red}✗ Error: $e${ConsoleColors.reset}');
    }
  }

  /// Assign grade to student
  void _assignGrade() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Assign Grade ═══${ConsoleColors.reset}\n');
    
    try {
      final studentId = InputValidator.readString('Student ID: ');
      final student = _manager.getStudent(studentId);
      
      if (student == null) {
        print('${ConsoleColors.red}✗ Student not found${ConsoleColors.reset}');
        return;
      }
      
      if (student.enrollments.isEmpty) {
        print('${ConsoleColors.yellow}⚠ Student is not enrolled in any courses${ConsoleColors.reset}');
        return;
      }
      
      print('\n${ConsoleColors.bold}Student Enrollments:${ConsoleColors.reset}');
      for (var i = 0; i < student.enrollments.length; i++) {
        final e = student.enrollments[i];
        final gradeStr = e.grade?.coloredString ?? '${ConsoleColors.gray}Not Graded${ConsoleColors.reset}';
        print('  ${i + 1}. ${e.course.courseCode}: ${e.course.courseName} - Grade: $gradeStr');
      }
      
      final choice = InputValidator.readInt('\nSelect enrollment (1-${student.enrollments.length}): ', 
                                           min: 1, max: student.enrollments.length);
      final enrollment = student.enrollments[choice - 1];
      
      print('\n${ConsoleColors.bold}Available Grades:${ConsoleColors.reset}');
      print('A+, A, A-, B+, B, B-, C+, C, C-, D+, D, F');
      
      final gradeStr = InputValidator.readString('\nEnter Grade: ');
      final grade = Grade.fromString(gradeStr);
      
      if (grade == null) {
        print('${ConsoleColors.red}✗ Invalid grade${ConsoleColors.reset}');
        return;
      }
      
      _manager.assignGrade(
        studentId: studentId,
        courseCode: enrollment.course.courseCode,
        grade: grade,
      );
      
      print('\n${ConsoleColors.green}✓ Grade assigned successfully!${ConsoleColors.reset}');
    } catch (e) {
      print('\n${ConsoleColors.red}✗ Error: $e${ConsoleColors.reset}');
    }
  }

  /// View all students
  void _viewAllStudents() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ All Students ═══${ConsoleColors.reset}\n');
    
    if (_manager.students.isEmpty) {
      print('${ConsoleColors.yellow}⚠ No students found${ConsoleColors.reset}');
      return;
    }
    
    final sortedStudents = _manager.getStudentsSortedByName();
    
    print('${ConsoleColors.bold}Total Students: ${sortedStudents.length}${ConsoleColors.reset}\n');
    
    for (var student in sortedStudents) {
      final gpa = student.calculateGPA();
      final gpaColor = gpa >= 3.5 ? ConsoleColors.green : 
                       gpa >= 2.5 ? ConsoleColors.yellow : 
                       ConsoleColors.red;
      
      print('${ConsoleColors.bold}${student.id}${ConsoleColors.reset} - ${student.name}');
      print('  Email: ${student.email}');
      print('  GPA: $gpaColor${gpa.toStringAsFixed(2)}${ConsoleColors.reset}');
      print('  Enrollments: ${student.enrollments.length} course(s)');
      print('');
    }
  }

  /// View all courses
  void _viewAllCourses() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ All Courses ═══${ConsoleColors.reset}\n');
    
    if (_manager.courses.isEmpty) {
      print('${ConsoleColors.yellow}⚠ No courses found${ConsoleColors.reset}');
      return;
    }
    
    final sortedCourses = _manager.getCoursesSortedByEnrollment();
    
    print('${ConsoleColors.bold}Total Courses: ${sortedCourses.length}${ConsoleColors.reset}\n');
    
    for (var course in sortedCourses) {
      final avgGrade = course.calculateAverageGrade();
      
      print('${ConsoleColors.bold}${course.courseCode}${ConsoleColors.reset} - ${course.courseName}');
      print('  Credit Hours: ${course.creditHours}');
      print('  Enrolled Students: ${course.totalStudents}');
      print('  Average Grade: ${avgGrade.toStringAsFixed(2)}');
      print('');
    }
  }

  /// View student details
  void _viewStudentDetails() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Student Details ═══${ConsoleColors.reset}\n');
    
    final studentId = InputValidator.readString('Enter Student ID: ');
    final student = _manager.getStudent(studentId);
    
    if (student == null) {
      print('${ConsoleColors.red}✗ Student not found${ConsoleColors.reset}');
      return;
    }
    
    print('\n${student.toDetailedString()}');
  }

  /// View course details
  void _viewCourseDetails() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Course Details ═══${ConsoleColors.reset}\n');
    
    final courseCode = InputValidator.readString('Enter Course Code: ');
    final course = _manager.getCourse(courseCode);
    
    if (course == null) {
      print('${ConsoleColors.red}✗ Course not found${ConsoleColors.reset}');
      return;
    }
    
    print('\n${course.toDetailedString()}');
  }

  /// View system statistics
  void _viewStatistics() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ System Statistics ═══${ConsoleColors.reset}\n');
    
    final stats = _manager.getSystemStatistics();
    
    print('${ConsoleColors.bold}Overview:${ConsoleColors.reset}');
    print('  Total Students: ${stats['totalStudents']}');
    print('  Total Courses: ${stats['totalCourses']}');
    print('  Total Enrollments: ${stats['totalEnrollments']}');
    print('  Graded Enrollments: ${stats['totalGradedEnrollments']}');
    
    print('\n${ConsoleColors.bold}Averages:${ConsoleColors.reset}');
    print('  System-wide GPA: ${(stats['averageGPA'] as double).toStringAsFixed(2)}');
    print('  Enrollments per Student: ${(stats['averageEnrollmentsPerStudent'] as double).toStringAsFixed(2)}');
    print('  Students per Course: ${(stats['averageStudentsPerCourse'] as double).toStringAsFixed(2)}');
  }

  /// View top students
  void _viewTopStudents() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Top Performing Students ═══${ConsoleColors.reset}\n');
    
    if (_manager.students.isEmpty) {
      print('${ConsoleColors.yellow}⚠ No students found${ConsoleColors.reset}');
      return;
    }
    
    final limit = InputValidator.readInt('How many top students to display? (1-50): ', min: 1, max: 50);
    final topStudents = _manager.getTopStudents(limit: limit);
    
    print('\n${ConsoleColors.bold}Rank  ID        Name                      GPA      Courses${ConsoleColors.reset}');
    print('─' * 70);
    
    for (var i = 0; i < topStudents.length; i++) {
      final student = topStudents[i];
      final gpa = student.calculateGPA();
      final rank = '${i + 1}.'.padRight(6);
      final id = student.id.padRight(10);
      final name = student.name.length > 25 
          ? '${student.name.substring(0, 22)}...' 
          : student.name.padRight(25);
      final gpaStr = gpa.toStringAsFixed(2).padLeft(8);
      final courses = student.enrollments.length.toString().padLeft(7);
      
      final gpaColor = gpa >= 3.5 ? ConsoleColors.green : 
                       gpa >= 2.5 ? ConsoleColors.yellow : 
                       ConsoleColors.red;
      
      print('$rank$id$name$gpaColor$gpaStr${ConsoleColors.reset}$courses');
    }
  }

  /// Search menu
  void _searchMenu() {
    print('${ConsoleColors.bold}${ConsoleColors.cyan}═══ Search ═══${ConsoleColors.reset}\n');
    print('1. Search Students');
    print('2. Search Courses');
    
    final choice = InputValidator.readInt('\nEnter your choice (1-2): ', min: 1, max: 2);
    
    if (choice == 1) {
      _searchStudents();
    } else {
      _searchCourses();
    }
  }

  /// Search students
  void _searchStudents() {
    print('\n${ConsoleColors.bold}Search Students${ConsoleColors.reset}');
    final query = InputValidator.readString('Enter search query (name, email, or ID): ');
    
    final results = _manager.searchStudents(query);
    
    if (results.isEmpty) {
      print('\n${ConsoleColors.yellow}⚠ No students found matching "$query"${ConsoleColors.reset}');
      return;
    }
    
    print('\n${ConsoleColors.green}Found ${results.length} student(s):${ConsoleColors.reset}\n');
    
    for (var student in results) {
      print('${ConsoleColors.bold}${student.id}${ConsoleColors.reset} - ${student.name}');
      print('  Email: ${student.email}');
      print('  GPA: ${student.calculateGPA().toStringAsFixed(2)}');
      print('');
    }
  }

  /// Search courses
  void _searchCourses() {
    print('\n${ConsoleColors.bold}Search Courses${ConsoleColors.reset}');
    final query = InputValidator.readString('Enter search query (code or name): ');
    
    final results = _manager.searchCourses(query);
    
    if (results.isEmpty) {
      print('\n${ConsoleColors.yellow}⚠ No courses found matching "$query"${ConsoleColors.reset}');
      return;
    }
    
    print('\n${ConsoleColors.green}Found ${results.length} course(s):${ConsoleColors.reset}\n');
    
    for (var course in results) {
      print('${ConsoleColors.bold}${course.courseCode}${ConsoleColors.reset} - ${course.courseName}');
      print('  Credits: ${course.creditHours}');
      print('  Students: ${course.totalStudents}');
      print('');
    }
  }

  /// Exit the system
  void _exit() {
    print('''
${ConsoleColors.bold}${ConsoleColors.cyan}
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║          Thank you for using CEMS!                        ║
║          Goodbye!                                          ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
${ConsoleColors.reset}
''');
  }

  /// Load sample data for demonstration
  void _loadSampleData() {
    try {
      // Add sample students
      _manager.addStudent(id: 'S001', name: 'Alice Johnson', email: 'alice.j@university.edu', phoneNumber: '555-0101');
      _manager.addStudent(id: 'S002', name: 'Bob Smith', email: 'bob.smith@university.edu', phoneNumber: '555-0102');
      _manager.addStudent(id: 'S003', name: 'Charlie Brown', email: 'charlie.b@university.edu');
      _manager.addStudent(id: 'S004', name: 'Diana Prince', email: 'diana.p@university.edu', phoneNumber: '555-0104');
      _manager.addStudent(id: 'S005', name: 'Ethan Hunt', email: 'ethan.h@university.edu');
      
      // Add sample courses
      _manager.addCourse(courseCode: 'CS101', courseName: 'Introduction to Programming', creditHours: 3);
      _manager.addCourse(courseCode: 'CS201', courseName: 'Data Structures', creditHours: 4);
      _manager.addCourse(courseCode: 'MATH101', courseName: 'Calculus I', creditHours: 4);
      _manager.addCourse(courseCode: 'ENG101', courseName: 'English Composition', creditHours: 3);
      _manager.addCourse(courseCode: 'PHY101', courseName: 'Physics I', creditHours: 4);
      
      // Enroll students and assign grades
      _manager.enrollStudent(studentId: 'S001', courseCode: 'CS101');
      _manager.assignGrade(studentId: 'S001', courseCode: 'CS101', grade: Grade.a);
      
      _manager.enrollStudent(studentId: 'S001', courseCode: 'MATH101');
      _manager.assignGrade(studentId: 'S001', courseCode: 'MATH101', grade: Grade.aMinus);
      
      _manager.enrollStudent(studentId: 'S002', courseCode: 'CS101');
      _manager.assignGrade(studentId: 'S002', courseCode: 'CS101', grade: Grade.bPlus);
      
      _manager.enrollStudent(studentId: 'S002', courseCode: 'CS201');
      _manager.assignGrade(studentId: 'S002', courseCode: 'CS201', grade: Grade.b);
      
      _manager.enrollStudent(studentId: 'S003', courseCode: 'ENG101');
      _manager.assignGrade(studentId: 'S003', courseCode: 'ENG101', grade: Grade.c);
      
      _manager.enrollStudent(studentId: 'S004', courseCode: 'CS101');
      _manager.assignGrade(studentId: 'S004', courseCode: 'CS101', grade: Grade.aPlus);
      
      _manager.enrollStudent(studentId: 'S004', courseCode: 'PHY101');
      _manager.assignGrade(studentId: 'S004', courseCode: 'PHY101', grade: Grade.a);
      
      _manager.enrollStudent(studentId: 'S005', courseCode: 'CS201');
      // Leave S005 without a grade
      
    } catch (e) {
      // Silently ignore errors in sample data loading
    }
  }
}

