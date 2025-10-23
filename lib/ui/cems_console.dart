import '../models/grade.dart';
import '../services/cems_manager.dart';
import '../utils/console_helper.dart';

/// Main console UI for the CEMS application
class CEMSConsole {
  final CEMSManager _manager = CEMSManager();

  /// Start the application
  void run() {
    ConsoleHelper.clearConsole();
    _showWelcome();
    
    bool running = true;
    while (running) {
      try {
        _showMainMenu();
        final choice = ConsoleHelper.readInt('Enter your choice:');
        
        if (choice == null) continue;
        
        ConsoleHelper.clearConsole();
        
        switch (choice) {
          case 1:
            _studentManagementMenu();
            break;
          case 2:
            _courseManagementMenu();
            break;
          case 3:
            _enrollmentManagementMenu();
            break;
          case 4:
            _reportsMenu();
            break;
          case 5:
            _searchMenu();
            break;
          case 0:
            _exitSystem();
            running = false;
            break;
          default:
            ConsoleHelper.printError('Invalid choice. Please try again.');
        }
      } catch (e) {
        ConsoleHelper.printError('An error occurred: $e');
        ConsoleHelper.pause();
      }
    }
  }

  /// Show welcome message
  void _showWelcome() {
    ConsoleHelper.printColored('''
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║   📚 COURSE ENROLLMENT MANAGEMENT SYSTEM (CEMS) 📚        ║
║                                                           ║
║            Manage Students, Courses & Enrollments         ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
''', ConsoleHelper.cyan);
  }

  /// Show main menu
  void _showMainMenu() {
    print('');
    ConsoleHelper.printDivider();
    ConsoleHelper.printColored('MAIN MENU', ConsoleHelper.bold);
    ConsoleHelper.printDivider();
    print('  1. 👨‍🎓 Student Management');
    print('  2. 📖 Course Management');
    print('  3. 📝 Enrollment Management');
    print('  4. 📊 Reports & Analytics');
    print('  5. 🔍 Search');
    print('  0. 🚪 Exit');
    ConsoleHelper.printDivider();
  }

  // ==================== STUDENT MANAGEMENT ====================

  void _studentManagementMenu() {
    ConsoleHelper.printHeader('STUDENT MANAGEMENT');
    print('  1. Add New Student');
    print('  2. View All Students');
    print('  3. Update Student');
    print('  4. Delete Student');
    print('  5. View Student Details');
    print('  0. Back to Main Menu');
    
    final choice = ConsoleHelper.readInt('\nEnter your choice:');
    if (choice == null) return;
    
    ConsoleHelper.clearConsole();
    
    switch (choice) {
      case 1:
        _addStudent();
        break;
      case 2:
        _viewAllStudents();
        break;
      case 3:
        _updateStudent();
        break;
      case 4:
        _deleteStudent();
        break;
      case 5:
        _viewStudentDetails();
        break;
      case 0:
        return;
    }
    
    ConsoleHelper.pause();
  }

  void _addStudent() {
    ConsoleHelper.printHeader('ADD NEW STUDENT');
    
    try {
      final id = ConsoleHelper.readInput('Enter Student ID:');
      if (id == null) return;
      
      final name = ConsoleHelper.readInput('Enter Student Name:');
      if (name == null) return;
      
      final email = ConsoleHelper.readInput('Enter Email:');
      if (email == null) return;
      
      final phone = ConsoleHelper.readInput('Enter Phone Number (optional):', required: false);
      
      _manager.addStudent(
        id: id,
        name: name,
        email: email,
        phoneNumber: phone?.isEmpty ?? true ? null : phone,
      );
      
      ConsoleHelper.printSuccess('Student added successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewAllStudents() {
    ConsoleHelper.printHeader('ALL STUDENTS');
    
    if (_manager.students.isEmpty) {
      ConsoleHelper.printWarning('No students found.');
      return;
    }
    
    print('Sort by: 1. Name  2. GPA');
    final sortChoice = ConsoleHelper.readInt('Enter choice:');
    
    final students = sortChoice == 2 
        ? _manager.getStudentsByGPA() 
        : _manager.getStudentsByName();
    
    final headers = ['ID', 'Name', 'Email', 'Phone', 'GPA', 'Credits'];
    final rows = students.map((s) => [
      s.id,
      s.name,
      s.email,
      s.phoneNumber ?? 'N/A',
      s.calculateGPA().toStringAsFixed(2),
      s.getTotalCreditHours().toString(),
    ]).toList();
    
    ConsoleHelper.printTable(headers, rows);
    print('\nTotal Students: ${students.length}');
  }

  void _updateStudent() {
    ConsoleHelper.printHeader('UPDATE STUDENT');
    
    final id = ConsoleHelper.readInput('Enter Student ID:');
    if (id == null) return;
    
    final student = _manager.getStudent(id);
    if (student == null) {
      ConsoleHelper.printError('Student not found.');
      return;
    }
    
    print('\nCurrent Details:');
    print(student.toDetailedString());
    
    print('\nLeave blank to keep current value');
    final name = ConsoleHelper.readInput('New Name:', required: false);
    final email = ConsoleHelper.readInput('New Email:', required: false);
    final phone = ConsoleHelper.readInput('New Phone:', required: false);
    
    try {
      _manager.updateStudent(
        id: id,
        name: name?.isEmpty ?? true ? null : name,
        email: email?.isEmpty ?? true ? null : email,
        phoneNumber: phone,
      );
      ConsoleHelper.printSuccess('Student updated successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _deleteStudent() {
    ConsoleHelper.printHeader('DELETE STUDENT');
    
    final id = ConsoleHelper.readInput('Enter Student ID:');
    if (id == null) return;
    
    final student = _manager.getStudent(id);
    if (student == null) {
      ConsoleHelper.printError('Student not found.');
      return;
    }
    
    print(student.toDetailedString());
    
    final confirm = ConsoleHelper.readInput('Are you sure you want to delete this student? (yes/no):');
    if (confirm?.toLowerCase() != 'yes') {
      ConsoleHelper.printInfo('Deletion cancelled.');
      return;
    }
    
    try {
      _manager.deleteStudent(id);
      ConsoleHelper.printSuccess('Student deleted successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewStudentDetails() {
    ConsoleHelper.printHeader('STUDENT DETAILS');
    
    final id = ConsoleHelper.readInput('Enter Student ID:');
    if (id == null) return;
    
    final student = _manager.getStudent(id);
    if (student == null) {
      ConsoleHelper.printError('Student not found.');
      return;
    }
    
    print(student.toDetailedString());
    
    if (student.enrollments.isEmpty) {
      ConsoleHelper.printWarning('No enrollments found.');
      return;
    }
    
    print('\n${ConsoleHelper.cyan}Enrolled Courses:${ConsoleHelper.reset}');
    ConsoleHelper.printDivider();
    
    for (var enrollment in student.enrollments) {
      final gradeStr = enrollment.grade?.coloredString ?? 'Not Graded';
      print('  📖 ${enrollment.course.courseName} (${enrollment.course.courseCode})');
      print('     Credits: ${enrollment.course.creditHours} | Grade: $gradeStr');
    }
  }

  // ==================== COURSE MANAGEMENT ====================

  void _courseManagementMenu() {
    ConsoleHelper.printHeader('COURSE MANAGEMENT');
    print('  1. Add New Course');
    print('  2. View All Courses');
    print('  3. Update Course');
    print('  4. Delete Course');
    print('  5. View Course Details');
    print('  0. Back to Main Menu');
    
    final choice = ConsoleHelper.readInt('\nEnter your choice:');
    if (choice == null) return;
    
    ConsoleHelper.clearConsole();
    
    switch (choice) {
      case 1:
        _addCourse();
        break;
      case 2:
        _viewAllCourses();
        break;
      case 3:
        _updateCourse();
        break;
      case 4:
        _deleteCourse();
        break;
      case 5:
        _viewCourseDetails();
        break;
      case 0:
        return;
    }
    
    ConsoleHelper.pause();
  }

  void _addCourse() {
    ConsoleHelper.printHeader('ADD NEW COURSE');
    
    try {
      final code = ConsoleHelper.readInput('Enter Course Code:');
      if (code == null) return;
      
      final name = ConsoleHelper.readInput('Enter Course Name:');
      if (name == null) return;
      
      final credits = ConsoleHelper.readInt('Enter Credit Hours:');
      if (credits == null) return;
      
      _manager.addCourse(
        courseCode: code,
        courseName: name,
        creditHours: credits,
      );
      
      ConsoleHelper.printSuccess('Course added successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewAllCourses() {
    ConsoleHelper.printHeader('ALL COURSES');
    
    if (_manager.courses.isEmpty) {
      ConsoleHelper.printWarning('No courses found.');
      return;
    }
    
    final headers = ['Code', 'Name', 'Credits', 'Enrolled', 'Avg Grade'];
    final rows = _manager.courses.map((c) => [
      c.courseCode,
      c.courseName,
      c.creditHours.toString(),
      c.getEnrollmentCount().toString(),
      c.calculateAverageGrade().toStringAsFixed(2),
    ]).toList();
    
    ConsoleHelper.printTable(headers, rows);
    print('\nTotal Courses: ${_manager.courses.length}');
  }

  void _updateCourse() {
    ConsoleHelper.printHeader('UPDATE COURSE');
    
    final code = ConsoleHelper.readInput('Enter Course Code:');
    if (code == null) return;
    
    final course = _manager.getCourse(code);
    if (course == null) {
      ConsoleHelper.printError('Course not found.');
      return;
    }
    
    print('\nCurrent Details:');
    print(course.toDetailedString());
    
    print('\nLeave blank to keep current value');
    final name = ConsoleHelper.readInput('New Name:', required: false);
    final creditsStr = ConsoleHelper.readInput('New Credit Hours:', required: false);
    final credits = creditsStr?.isEmpty ?? true ? null : int.tryParse(creditsStr!);
    
    try {
      _manager.updateCourse(
        courseCode: code,
        courseName: name?.isEmpty ?? true ? null : name,
        creditHours: credits,
      );
      ConsoleHelper.printSuccess('Course updated successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _deleteCourse() {
    ConsoleHelper.printHeader('DELETE COURSE');
    
    final code = ConsoleHelper.readInput('Enter Course Code:');
    if (code == null) return;
    
    final course = _manager.getCourse(code);
    if (course == null) {
      ConsoleHelper.printError('Course not found.');
      return;
    }
    
    print(course.toDetailedString());
    
    final confirm = ConsoleHelper.readInput('Are you sure you want to delete this course? (yes/no):');
    if (confirm?.toLowerCase() != 'yes') {
      ConsoleHelper.printInfo('Deletion cancelled.');
      return;
    }
    
    try {
      _manager.deleteCourse(code);
      ConsoleHelper.printSuccess('Course deleted successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewCourseDetails() {
    ConsoleHelper.printHeader('COURSE DETAILS');
    
    final code = ConsoleHelper.readInput('Enter Course Code:');
    if (code == null) return;
    
    final course = _manager.getCourse(code);
    if (course == null) {
      ConsoleHelper.printError('Course not found.');
      return;
    }
    
    print(course.toDetailedString());
    
    if (course.enrollments.isEmpty) {
      ConsoleHelper.printWarning('No students enrolled.');
      return;
    }
    
    print('\n${ConsoleHelper.cyan}Enrolled Students:${ConsoleHelper.reset}');
    ConsoleHelper.printDivider();
    
    final headers = ['Student ID', 'Name', 'Email', 'Grade'];
    final rows = course.enrollments.map((e) => [
      e.student.id,
      e.student.name,
      e.student.email,
      e.grade?.letter ?? 'Not Graded',
    ]).toList();
    
    ConsoleHelper.printTable(headers, rows);
    
    // Show grade distribution
    final distribution = course.getGradeDistribution();
    if (distribution.isNotEmpty) {
      print('\n${ConsoleHelper.cyan}Grade Distribution:${ConsoleHelper.reset}');
      for (var entry in distribution.entries) {
        print('  ${entry.key.coloredString}: ${entry.value} student(s)');
      }
    }
  }

  // ==================== ENROLLMENT MANAGEMENT ====================

  void _enrollmentManagementMenu() {
    ConsoleHelper.printHeader('ENROLLMENT MANAGEMENT');
    print('  1. Enroll Student in Course');
    print('  2. Assign/Update Grade');
    print('  3. Unenroll Student from Course');
    print('  4. View All Enrollments');
    print('  0. Back to Main Menu');
    
    final choice = ConsoleHelper.readInt('\nEnter your choice:');
    if (choice == null) return;
    
    ConsoleHelper.clearConsole();
    
    switch (choice) {
      case 1:
        _enrollStudent();
        break;
      case 2:
        _assignGrade();
        break;
      case 3:
        _unenrollStudent();
        break;
      case 4:
        _viewAllEnrollments();
        break;
      case 0:
        return;
    }
    
    ConsoleHelper.pause();
  }

  void _enrollStudent() {
    ConsoleHelper.printHeader('ENROLL STUDENT IN COURSE');
    
    try {
      final studentId = ConsoleHelper.readInput('Enter Student ID:');
      if (studentId == null) return;
      
      final courseCode = ConsoleHelper.readInput('Enter Course Code:');
      if (courseCode == null) return;
      
      final enrollment = _manager.enrollStudent(
        studentId: studentId,
        courseCode: courseCode,
      );
      
      ConsoleHelper.printSuccess('Student enrolled successfully!');
      print('  ${enrollment.student.name} → ${enrollment.course.courseName}');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _assignGrade() {
    ConsoleHelper.printHeader('ASSIGN/UPDATE GRADE');
    
    try {
      final studentId = ConsoleHelper.readInput('Enter Student ID:');
      if (studentId == null) return;
      
      final courseCode = ConsoleHelper.readInput('Enter Course Code:');
      if (courseCode == null) return;
      
      print('\nAvailable Grades:');
      for (var i = 0; i < Grade.values.length; i++) {
        final grade = Grade.values[i];
        print('  ${i + 1}. ${grade.coloredString} (${grade.gradePoint})');
      }
      
      final gradeChoice = ConsoleHelper.readInt('\nSelect grade:');
      if (gradeChoice == null || gradeChoice < 1 || gradeChoice > Grade.values.length) {
        ConsoleHelper.printError('Invalid grade selection.');
        return;
      }
      
      final grade = Grade.values[gradeChoice - 1];
      
      _manager.assignGrade(
        studentId: studentId,
        courseCode: courseCode,
        grade: grade,
      );
      
      ConsoleHelper.printSuccess('Grade assigned successfully!');
      print('  Grade: ${grade.coloredString}');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _unenrollStudent() {
    ConsoleHelper.printHeader('UNENROLL STUDENT FROM COURSE');
    
    try {
      final studentId = ConsoleHelper.readInput('Enter Student ID:');
      if (studentId == null) return;
      
      final courseCode = ConsoleHelper.readInput('Enter Course Code:');
      if (courseCode == null) return;
      
      final confirm = ConsoleHelper.readInput('Are you sure? (yes/no):');
      if (confirm?.toLowerCase() != 'yes') {
        ConsoleHelper.printInfo('Unenrollment cancelled.');
        return;
      }
      
      _manager.unenrollStudent(
        studentId: studentId,
        courseCode: courseCode,
      );
      
      ConsoleHelper.printSuccess('Student unenrolled successfully!');
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewAllEnrollments() {
    ConsoleHelper.printHeader('ALL ENROLLMENTS');
    
    if (_manager.enrollments.isEmpty) {
      ConsoleHelper.printWarning('No enrollments found.');
      return;
    }
    
    final headers = ['Student ID', 'Student Name', 'Course Code', 'Course Name', 'Grade'];
    final rows = _manager.enrollments.map((e) => [
      e.student.id,
      e.student.name,
      e.course.courseCode,
      e.course.courseName,
      e.grade?.letter ?? 'Not Graded',
    ]).toList();
    
    ConsoleHelper.printTable(headers, rows);
    print('\nTotal Enrollments: ${_manager.enrollments.length}');
  }

  // ==================== REPORTS & ANALYTICS ====================

  void _reportsMenu() {
    ConsoleHelper.printHeader('REPORTS & ANALYTICS');
    print('  1. System Statistics');
    print('  2. Top Performing Students');
    print('  3. Course Statistics');
    print('  4. Student Transcript');
    print('  5. Course Roster');
    print('  0. Back to Main Menu');
    
    final choice = ConsoleHelper.readInt('\nEnter your choice:');
    if (choice == null) return;
    
    ConsoleHelper.clearConsole();
    
    switch (choice) {
      case 1:
        _viewSystemStatistics();
        break;
      case 2:
        _viewTopStudents();
        break;
      case 3:
        _viewCourseStatistics();
        break;
      case 4:
        _viewStudentTranscript();
        break;
      case 5:
        _viewCourseRoster();
        break;
      case 0:
        return;
    }
    
    ConsoleHelper.pause();
  }

  void _viewSystemStatistics() {
    ConsoleHelper.printHeader('SYSTEM STATISTICS');
    
    final stats = _manager.getSystemStatistics();
    
    print('📊 Overall Statistics:');
    ConsoleHelper.printDivider();
    print('  Total Students:       ${stats['totalStudents']}');
    print('  Total Courses:        ${stats['totalCourses']}');
    print('  Total Enrollments:    ${stats['totalEnrollments']}');
    print('  Graded Enrollments:   ${stats['gradedEnrollments']}');
    print('  Overall GPA:          ${(stats['overallGPA'] as double).toStringAsFixed(2)}');
  }

  void _viewTopStudents() {
    ConsoleHelper.printHeader('TOP PERFORMING STUDENTS');
    
    final limit = ConsoleHelper.readInt('How many top students to display? (default: 5):') ?? 5;
    final topStudents = _manager.getTopStudents(limit: limit);
    
    if (topStudents.isEmpty) {
      ConsoleHelper.printWarning('No students found.');
      return;
    }
    
    print('\n🏆 Top $limit Students by GPA:\n');
    
    for (var i = 0; i < topStudents.length; i++) {
      final student = topStudents[i];
      final rank = i + 1;
      final medal = rank == 1 ? '🥇' : rank == 2 ? '🥈' : rank == 3 ? '🥉' : '  ';
      
      print('$medal $rank. ${student.name} (${student.id})');
      print('     GPA: ${ConsoleHelper.green}${student.calculateGPA().toStringAsFixed(2)}${ConsoleHelper.reset} | Credits: ${student.getTotalCreditHours()}');
      print('');
    }
  }

  void _viewCourseStatistics() {
    ConsoleHelper.printHeader('COURSE STATISTICS');
    
    final courseCode = ConsoleHelper.readInput('Enter Course Code:');
    if (courseCode == null) return;
    
    try {
      final stats = _manager.getCourseStatistics(courseCode);
      
      print('\n📊 Course: ${stats['courseName']} (${stats['courseCode']})');
      ConsoleHelper.printDivider();
      print('  Total Students:   ${stats['totalStudents']}');
      print('  Average Grade:    ${(stats['averageGrade'] as double).toStringAsFixed(2)}');
      
      final distribution = stats['gradeDistribution'] as Map<Grade, int>;
      if (distribution.isNotEmpty) {
        print('\n  Grade Distribution:');
        for (var entry in distribution.entries) {
          final percentage = (entry.value / (stats['totalStudents'] as int) * 100).toStringAsFixed(1);
          print('    ${entry.key.coloredString}: ${entry.value} ($percentage%)');
        }
      }
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewStudentTranscript() {
    ConsoleHelper.printHeader('STUDENT TRANSCRIPT');
    
    final studentId = ConsoleHelper.readInput('Enter Student ID:');
    if (studentId == null) return;
    
    try {
      final transcript = _manager.getStudentTranscript(studentId);
      final student = _manager.getStudent(studentId)!;
      
      print(student.toDetailedString());
      
      if (transcript.isEmpty) {
        ConsoleHelper.printWarning('No enrollments found.');
        return;
      }
      
      print('\n📝 Transcript:');
      ConsoleHelper.printDivider();
      
      final headers = ['Course Code', 'Course Name', 'Credits', 'Grade', 'Points'];
      final rows = transcript.map((e) => [
        e.course.courseCode,
        e.course.courseName,
        e.course.creditHours.toString(),
        e.grade?.letter ?? 'N/A',
        e.grade?.gradePoint.toString() ?? 'N/A',
      ]).toList();
      
      ConsoleHelper.printTable(headers, rows);
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  void _viewCourseRoster() {
    ConsoleHelper.printHeader('COURSE ROSTER');
    
    final courseCode = ConsoleHelper.readInput('Enter Course Code:');
    if (courseCode == null) return;
    
    try {
      final roster = _manager.getCourseRoster(courseCode);
      final course = _manager.getCourse(courseCode)!;
      
      print(course.toDetailedString());
      
      if (roster.isEmpty) {
        ConsoleHelper.printWarning('No students enrolled.');
        return;
      }
      
      print('\n👥 Enrolled Students:');
      ConsoleHelper.printDivider();
      
      final headers = ['Student ID', 'Name', 'Email', 'Grade', 'GPA'];
      final rows = roster.map((e) => [
        e.student.id,
        e.student.name,
        e.student.email,
        e.grade?.letter ?? 'N/A',
        e.student.calculateGPA().toStringAsFixed(2),
      ]).toList();
      
      ConsoleHelper.printTable(headers, rows);
    } on ValidationException catch (e) {
      ConsoleHelper.printError(e.message);
    }
  }

  // ==================== SEARCH ====================

  void _searchMenu() {
    ConsoleHelper.printHeader('SEARCH');
    print('  1. Search Students');
    print('  2. Search Courses');
    print('  0. Back to Main Menu');
    
    final choice = ConsoleHelper.readInt('\nEnter your choice:');
    if (choice == null) return;
    
    ConsoleHelper.clearConsole();
    
    switch (choice) {
      case 1:
        _searchStudents();
        break;
      case 2:
        _searchCourses();
        break;
      case 0:
        return;
    }
    
    ConsoleHelper.pause();
  }

  void _searchStudents() {
    ConsoleHelper.printHeader('SEARCH STUDENTS');
    
    final query = ConsoleHelper.readInput('Enter student name:');
    if (query == null) return;
    
    final results = _manager.searchStudentsByName(query);
    
    if (results.isEmpty) {
      ConsoleHelper.printWarning('No students found matching "$query"');
      return;
    }
    
    print('\n🔍 Found ${results.length} student(s):\n');
    
    final headers = ['ID', 'Name', 'Email', 'GPA'];
    final rows = results.map((s) => [
      s.id,
      s.name,
      s.email,
      s.calculateGPA().toStringAsFixed(2),
    ]).toList();
    
    ConsoleHelper.printTable(headers, rows);
  }

  void _searchCourses() {
    ConsoleHelper.printHeader('SEARCH COURSES');
    
    final query = ConsoleHelper.readInput('Enter course code or name:');
    if (query == null) return;
    
    final results = _manager.searchCourses(query);
    
    if (results.isEmpty) {
      ConsoleHelper.printWarning('No courses found matching "$query"');
      return;
    }
    
    print('\n🔍 Found ${results.length} course(s):\n');
    
    final headers = ['Code', 'Name', 'Credits', 'Enrolled'];
    final rows = results.map((c) => [
      c.courseCode,
      c.courseName,
      c.creditHours.toString(),
      c.getEnrollmentCount().toString(),
    ]).toList();
    
    ConsoleHelper.printTable(headers, rows);
  }

  // ==================== EXIT ====================

  void _exitSystem() {
    ConsoleHelper.clearConsole();
    ConsoleHelper.printColored('''
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║              Thank you for using CEMS! 👋                 ║
║                                                           ║
║                  See you next time! 📚                    ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
''', ConsoleHelper.green);
  }
}

