# Course Enrollment Management System (CEMS)

A comprehensive Dart console application for managing students, courses, and their enrollments. This system simulates how a university tracks student enrollments, grades, and performance statistics.

## 🎯 Features

### Student Management
- ✅ Add, edit, and delete students
- ✅ Each student has: ID, name, email, and optional phone number
- ✅ Automatic GPA calculation
- ✅ Track enrolled courses and completed credits
- ✅ Email validation

### Course Management
- ✅ Add, edit, and delete courses
- ✅ Each course has: course code, name, and credit hours (1-6)
- ✅ View course rosters with enrolled students
- ✅ Calculate average grades per course
- ✅ Grade distribution statistics

### Enrollment Management
- ✅ Enroll students in multiple courses
- ✅ Prevent duplicate enrollments
- ✅ Assign grades (A+, A, A-, B+, B, B-, C+, C, C-, D+, D, F)
- ✅ Grade enum with point values
- ✅ Track enrollment dates

### Reports & Analytics
- ✅ View all students with their GPA and enrollments
- ✅ View all courses with enrollment statistics
- ✅ Detailed student profiles with course list
- ✅ Detailed course rosters with grade distribution
- ✅ System-wide statistics (total students, courses, average GPA)
- ✅ Top-performing students by GPA
- ✅ Search functionality for students and courses

### Bonus Features Implemented
- ✅ Sort students by name or GPA
- ✅ Sort courses by enrollment count
- ✅ Color-coded grade output (A = green, F = red, etc.)
- ✅ Grade enums instead of raw strings
- ✅ ANSI color codes for enhanced console UI
- ✅ Comprehensive error handling
- ✅ Input validation with helpful error messages
- ✅ Sample data pre-loaded for demonstration

## 🏗️ Architecture

### Data Model Classes

1. **Student** (`lib/models/student.dart`)
   - Properties: id, name, email, phoneNumber, enrollments
   - Methods: calculateGPA(), isEnrolledIn(), addEnrollment()

2. **Course** (`lib/models/course.dart`)
   - Properties: courseCode, courseName, creditHours, enrollments
   - Methods: calculateAverageGrade(), getGradeDistribution()

3. **Enrollment** (`lib/models/enrollment.dart`)
   - Properties: student, course, grade, enrollmentDate
   - Methods: assignGrade(), isPassing()

4. **Grade Enum** (`lib/models/grade.dart`)
   - All grade levels with point values
   - Color-coded display
   - String parsing

### Manager Class

**CEMSManager** (`lib/cems_manager.dart`)
- Central business logic handler
- Uses Maps and Lists for efficient data storage
- Manages relationships between students and courses
- Implements all CRUD operations
- Provides statistics and reporting functions

### User Interface

**ConsoleUI** (`lib/ui/console_ui.dart`)
- Interactive menu system
- Color-coded output for better readability
- Input validation and error handling
- Sample data pre-loaded

## 🚀 Getting Started

### Prerequisites

- Dart SDK 3.0.0 or higher

### Installation

1. Clone or download this repository
2. Navigate to the project directory:
   ```bash
   cd cems
   ```

3. Get dependencies:
   ```bash
   dart pub get
   ```

### Running the Application

```bash
dart run
```

Or use the main entry point directly:
```bash
dart bin/main.dart
```

## 📖 Usage Guide

### Main Menu Options

1. **Add New Student** - Register a new student with ID, name, email, and phone
2. **Add New Course** - Create a new course with code, name, and credit hours
3. **Enroll Student in Course** - Enroll an existing student in an existing course
4. **Assign Grade to Student** - Assign a letter grade to a student's enrollment
5. **View All Students** - List all students sorted by name with GPA
6. **View All Courses** - List all courses sorted by enrollment count
7. **View Student Details** - See detailed information about a specific student
8. **View Course Details** - See detailed information about a specific course including roster
9. **View System Statistics** - View overall system statistics
10. **View Top Performing Students** - See leaderboard of students by GPA
11. **Search** - Search for students or courses

### Sample Data

The system comes pre-loaded with sample data:
- 5 students (S001-S005)
- 5 courses (CS101, CS201, MATH101, ENG101, PHY101)
- Multiple enrollments with grades

### Grade System

| Grade | Grade Points |
|-------|--------------|
| A+, A | 4.0          |
| A-    | 3.7          |
| B+    | 3.3          |
| B     | 3.0          |
| B-    | 2.7          |
| C+    | 2.3          |
| C     | 2.0          |
| C-    | 1.7          |
| D+    | 1.3          |
| D     | 1.0          |
| F     | 0.0          |

## 🎨 Color Coding

The system uses ANSI color codes for enhanced visual experience:
- 🟢 **Green** - A grades, success messages
- 🔵 **Blue** - B grades, informational text
- 🟡 **Yellow** - C grades, warnings
- 🟣 **Purple** - D grades
- 🔴 **Red** - F grades, errors
- ⚪ **Gray** - Not graded, secondary info

## 🔍 Key OOP Concepts Demonstrated

1. **Encapsulation** - Private fields with public getters/methods
2. **Composition** - Enrollment connects Student and Course
3. **Null Safety** - Optional phone numbers and grades
4. **Collections** - Lists, Maps, Sets for data management
5. **Enums** - Type-safe grade representation
6. **Error Handling** - Try-catch blocks throughout
7. **Input Validation** - Comprehensive validation with helpful messages
8. **Separation of Concerns** - Models, Manager, UI, and Utilities

## 📁 Project Structure

```
cems/
├── bin/
│   └── main.dart                 # Application entry point
├── lib/
│   ├── models/
│   │   ├── student.dart          # Student model
│   │   ├── course.dart           # Course model
│   │   ├── enrollment.dart       # Enrollment model
│   │   └── grade.dart            # Grade enum
│   ├── utils/
│   │   ├── console_colors.dart   # ANSI color utilities
│   │   └── input_validator.dart  # Input validation utilities
│   ├── ui/
│   │   └── console_ui.dart       # Console user interface
│   └── cems_manager.dart         # Business logic manager
├── pubspec.yaml                   # Package configuration
├── analysis_options.yaml          # Dart analyzer settings
└── README.md                      # This file
```

## 🧪 Testing the System

Try these workflows:

1. **Add a new student and enroll them**
   - Menu Option 1: Add student
   - Menu Option 3: Enroll in a course
   - Menu Option 4: Assign a grade
   - Menu Option 7: View student details

2. **View statistics**
   - Menu Option 9: System statistics
   - Menu Option 10: Top students

3. **Search functionality**
   - Menu Option 11: Search students by name
   - Menu Option 11: Search courses by code

## 🛡️ Error Handling

The system handles:
- ✅ Duplicate student IDs
- ✅ Duplicate email addresses
- ✅ Duplicate course codes
- ✅ Duplicate enrollments
- ✅ Invalid email formats
- ✅ Invalid credit hours
- ✅ Invalid grades
- ✅ Missing students or courses
- ✅ Invalid numeric inputs
- ✅ Empty required fields

## 📊 Statistics Available

- Total students and courses
- Total enrollments (graded and ungraded)
- System-wide average GPA
- Average enrollments per student
- Average students per course
- Grade distribution per course
- Top performing students

## 👨‍💻 Author

Created as a comprehensive demonstration of Dart OOP concepts for the Course Enrollment Management System project.

## 📝 License

This project is created for educational purposes.

## 🚀 Future Enhancements

Potential improvements:
- Persistent storage (JSON/SQLite)
- Export reports to files
- Import students/courses from CSV
- Prerequisite course validation
- Academic calendar support
- Attendance tracking
- Financial information (tuition, payments)
- Professor assignment to courses
- Course capacity limits
- Waiting lists for full courses

---

**Happy Learning! 📚**

