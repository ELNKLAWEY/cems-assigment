# Course Enrollment Management System (CEMS)

A comprehensive console-based application for managing students, courses, and enrollments with grades and performance analytics.

## 🎯 Features

### Student Management
- ✅ Add, edit, and delete students
- ✅ Each student has: ID, name, email, and optional phone number
- ✅ Automatic GPA calculation
- ✅ Track enrolled courses and credit hours
- ✅ Duplicate email validation

### Course Management
- ✅ Add, edit, and delete courses
- ✅ Each course has: course code, name, and credit hours
- ✅ Track enrolled students
- ✅ Calculate average grades and grade distribution
- ✅ Duplicate course code validation

### Enrollment Management
- ✅ Enroll students in courses
- ✅ Prevent duplicate enrollments
- ✅ Assign and update grades (A+ to F)
- ✅ Unenroll students from courses

### Reports & Analytics
- ✅ View all students and their enrolled courses with grades
- ✅ View course rosters (students enrolled in each course)
- ✅ System statistics (total students, courses, enrollments, overall GPA)
- ✅ Top performing students by GPA
- ✅ Course statistics (enrollment count, average grade, grade distribution)
- ✅ Student transcripts
- ✅ Course rosters

### Search Functionality
- ✅ Search students by name
- ✅ Search courses by code or name

### Bonus Features Implemented
- ✅ Sort students by GPA or name
- ✅ Update grades dynamically
- ✅ Color-coded grade outputs using ANSI codes
  - A/A+ = Green
  - A-/B+ = Cyan
  - B/B- = Blue
  - C+/C = Yellow
  - C-/D+/D = Magenta
  - F = Red
- ✅ Grade enum for type-safe grade representation
- ✅ Beautiful console UI with formatted tables and boxes
- ✅ Comprehensive error handling and validation

## 🏗️ Architecture

### Project Structure
```
lib/
├── models/
│   ├── grade.dart          # Grade enum with GPA calculation
│   ├── student.dart        # Student class with enrollments
│   ├── course.dart         # Course class with rosters
│   └── enrollment.dart     # Enrollment linking students and courses
├── services/
│   └── cems_manager.dart   # Main business logic and CRUD operations
├── ui/
│   └── cems_console.dart   # Console UI with interactive menu
└── utils/
    ├── console_helper.dart # Console formatting and color utilities
    └── sample_data.dart    # Sample data generator for testing

bin/
├── cems_main.dart              # Main entry point (empty system)
└── cems_with_sample_data.dart  # Entry point with pre-loaded data
```

### Key Design Patterns
- **Object-Oriented Programming**: Proper use of classes, encapsulation, and inheritance
- **Separation of Concerns**: Models, business logic, UI, and utilities are separated
- **Null Safety**: Full null safety with proper use of nullable types
- **Error Handling**: Custom ValidationException for business logic errors
- **Collections**: Efficient use of Maps for O(1) lookups, Lists for ordered data

## 🚀 Running the Application

### Prerequisites
- Dart SDK installed (comes with Flutter)

### Option 1: Empty System (Start Fresh)
```bash
# Navigate to the project directory
cd c:\Users\alaa_\Documents\flutter\lms

# Run the application with empty system
dart run bin/cems_main.dart
```

### Option 2: With Sample Data (Recommended for Testing)
```bash
# Navigate to the project directory
cd c:\Users\alaa_\Documents\flutter\lms

# Run the application with pre-loaded sample data
dart run bin/cems_with_sample_data.dart
```

## 📊 Sample Data

When running with sample data, the system includes:

### Students (5)
- S001: Alice Johnson (alice.johnson@university.edu)
- S002: Bob Smith (bob.smith@university.edu)
- S003: Charlie Brown (charlie.brown@university.edu)
- S004: Diana Prince (diana.prince@university.edu)
- S005: Ethan Hunt (ethan.hunt@university.edu)

### Courses (6)
- CS101: Introduction to Computer Science (3 credits)
- CS201: Data Structures and Algorithms (4 credits)
- CS301: Database Systems (3 credits)
- MATH101: Calculus I (4 credits)
- MATH201: Linear Algebra (3 credits)
- ENG101: English Composition (3 credits)

### Enrollments (16)
- Multiple students enrolled in various courses
- Most enrollments include grades (15 out of 16)
- Grades range from A+ to C

## 🎓 Technical Concepts Demonstrated

### OOP Concepts
- ✅ **Encapsulation**: Private fields with public getters/setters
- ✅ **Constructors**: Named parameters, default values, initializer lists
- ✅ **Methods**: Instance methods, getters, toString overrides
- ✅ **Composition**: Enrollment connects Student and Course

### Collections
- ✅ **Lists**: Ordered collections for enrollments
- ✅ **Maps**: Fast lookups for students and courses by ID
- ✅ **Sets**: Used implicitly for unique constraint checking

### Dart Features
- ✅ **Null Safety**: Proper use of `?`, `??`, `?.` operators
- ✅ **Enums**: Type-safe grade representation
- ✅ **Extension Methods**: Could be added for enhanced functionality
- ✅ **Try-Catch**: Comprehensive error handling
- ✅ **String Interpolation**: Clean string formatting
- ✅ **DateTime**: Enrollment date tracking

### Control Flow
- ✅ **Conditionals**: Extensive if/else and switch statements
- ✅ **Loops**: for, while, and collection operations
- ✅ **Functions**: Modular function design
- ✅ **Higher-order functions**: map, fold, where, any operations

## 🎨 User Interface Features

### Color-Coded Output
- Headers and dividers in cyan
- Success messages in green
- Error messages in red
- Warning messages in yellow
- Info messages in cyan
- Grades in color based on performance

### Interactive Menus
- Main menu with 5 categories
- Sub-menus for each category
- Clear navigation flow
- Input validation and error messages

### Formatted Output
- Beautiful box-drawn tables
- Aligned columns
- Statistics with icons
- Progress indicators

## 🔒 Validation & Error Handling

### Input Validation
- ✅ Non-empty required fields
- ✅ Valid email format (regex)
- ✅ Positive credit hours
- ✅ Numeric input validation

### Business Logic Validation
- ✅ No duplicate student IDs or emails
- ✅ No duplicate course codes
- ✅ No duplicate enrollments
- ✅ Valid student/course references for enrollments
- ✅ Graceful handling of not-found entities

### Error Messages
- Clear, user-friendly error messages
- Color-coded for visibility
- Non-crashing behavior (try-catch blocks)

## 📈 Sample Usage Flow

1. **Start the Application**
   - Choose to run with or without sample data
   - View the welcome screen

2. **Add Students**
   - Navigate to Student Management → Add New Student
   - Enter student details (ID, name, email, phone)
   - System validates and confirms

3. **Add Courses**
   - Navigate to Course Management → Add New Course
   - Enter course details (code, name, credits)
   - System validates and confirms

4. **Enroll Students**
   - Navigate to Enrollment Management → Enroll Student
   - Enter student ID and course code
   - System prevents duplicates

5. **Assign Grades**
   - Navigate to Enrollment Management → Assign Grade
   - Select from color-coded grade options
   - Updates immediately

6. **View Reports**
   - Navigate to Reports & Analytics
   - View system statistics
   - Check top performing students
   - Generate transcripts and rosters

7. **Search**
   - Use search functionality to quickly find students or courses
   - Results displayed in formatted tables

## 🏆 Project Requirements Checklist

### Core Features
- ✅ Student Management (add, edit, delete, view)
- ✅ Course Management (add, edit, delete, view)
- ✅ Enrollment Management (enroll, assign grades, prevent duplicates)
- ✅ Reports & Analytics (all students, course rosters, statistics)
- ✅ Search functionality (students by name, courses by code/name)

### Data Model
- ✅ Student class with required attributes
- ✅ Course class with required attributes
- ✅ Enrollment class linking students and courses
- ✅ Proper relationships and references

### Technical Requirements
- ✅ OOP principles (inheritance, encapsulation, constructors, methods)
- ✅ Collections (Lists, Sets, Maps) for data management
- ✅ Functions and control flow
- ✅ Error handling and validation
- ✅ Null safety throughout
- ✅ Console-based interface

### Bonus Features
- ✅ Sort by GPA and name
- ✅ Update grades dynamically
- ✅ Color-coded output (ANSI codes)
- ✅ Grade enums
- ✅ Beautiful UI with tables and boxes
- ✅ Sample data generator
- ✅ Comprehensive statistics

## 📝 Notes

- This is a console application, not a Flutter UI application
- Data is stored in-memory (no persistent database)
- ANSI color codes work best on modern terminals
- Sample data is provided for easy testing and demonstration
- All validation and error handling is implemented
- GPA calculation uses standard 4.0 scale

## 🤝 Contributing

This project was created as an educational demonstration of Dart programming concepts. Feel free to extend it with:
- File-based persistence (JSON/CSV export)
- More detailed statistics
- Course prerequisites
- Semester tracking
- Advanced search filters
- Grade history tracking

## 📚 Learning Outcomes

By studying this project, you will understand:
- How to design and implement a complete OOP system
- How to use Dart collections effectively
- How to implement proper error handling and validation
- How to create interactive console applications
- How to use ANSI color codes for better UX
- How to organize code into logical modules
- How to implement CRUD operations
- How to generate statistics and reports

---

**Developed with Mohamed Osama using Dart**

