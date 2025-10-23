# 🚀 CEMS Quick Start Guide

## What is CEMS?

**Course Enrollment Management System (CEMS)** is a console-based Dart application for managing students, courses, and enrollments with automatic GPA calculation, grade tracking, and comprehensive reporting.

## 📦 Installation

No installation needed! The system is ready to run.

## ▶️ Running the Application

### Option 1: Start with Sample Data (Recommended for First Time)

```bash
dart run bin/cems_with_sample_data.dart
```

This loads 5 students, 6 courses, and 16 enrollments with grades for testing.

### Option 2: Start with Empty System

```bash
dart run bin/cems_main.dart
```

Start fresh and add your own data.

### Option 3: Run Tests

```bash
dart run bin/test_cems.dart
```

Verify all functionality works correctly.

## 🎮 Using the System

### Main Menu Structure

```
MAIN MENU
  1. 👨‍🎓 Student Management
  2. 📖 Course Management
  3. 📝 Enrollment Management
  4. 📊 Reports & Analytics
  5. 🔍 Search
  0. 🚪 Exit
```

### Common Workflows

#### 1️⃣ Adding a Student

1. Select `1` (Student Management)
2. Select `1` (Add New Student)
3. Enter:
   - Student ID (e.g., S001)
   - Name (e.g., John Doe)
   - Email (e.g., john.doe@university.edu)
   - Phone (optional)

#### 2️⃣ Adding a Course

1. Select `2` (Course Management)
2. Select `1` (Add New Course)
3. Enter:
   - Course Code (e.g., CS101)
   - Course Name (e.g., Introduction to Programming)
   - Credit Hours (e.g., 3)

#### 3️⃣ Enrolling a Student in a Course

1. Select `3` (Enrollment Management)
2. Select `1` (Enroll Student in Course)
3. Enter:
   - Student ID (e.g., S001)
   - Course Code (e.g., CS101)

#### 4️⃣ Assigning a Grade

1. Select `3` (Enrollment Management)
2. Select `2` (Assign/Update Grade)
3. Enter:
   - Student ID
   - Course Code
4. Select grade from color-coded menu:
   - 🟢 A+, A (4.0)
   - 🔵 B+, B, B- (3.3-2.7)
   - 🟡 C+, C, C- (2.3-1.7)
   - 🟣 D+, D (1.3-1.0)
   - 🔴 F (0.0)

#### 5️⃣ Viewing Reports

1. Select `4` (Reports & Analytics)
2. Choose from:
   - System Statistics (overall stats)
   - Top Performing Students (by GPA)
   - Course Statistics (average grade, distribution)
   - Student Transcript (all courses for a student)
   - Course Roster (all students in a course)

#### 6️⃣ Searching

1. Select `5` (Search)
2. Choose:
   - Search Students (by name)
   - Search Courses (by code or name)

## 📊 Sample Data Overview

If you run with sample data, you'll have:

### Students
- **S001**: Alice Johnson (GPA: 3.91) - 3 courses
- **S002**: Bob Smith (GPA: 3.00) - 3 courses
- **S003**: Charlie Brown (GPA: 3.70) - 3 courses
- **S004**: Diana Prince (GPA: 4.00) - 4 courses 🏆
- **S005**: Ethan Hunt (GPA: 2.15) - 3 courses (1 not graded)

### Courses
- **CS101**: Intro to Computer Science (3 credits) - 3 students
- **CS201**: Data Structures & Algorithms (4 credits) - 3 students
- **CS301**: Database Systems (3 credits) - 2 students
- **MATH101**: Calculus I (4 credits) - 3 students
- **MATH201**: Linear Algebra (3 credits) - 2 students
- **ENG101**: English Composition (3 credits) - 3 students

## 🎯 Key Features to Try

### 1. View Top Students by GPA
- Go to Reports → Top Performing Students
- See GPA rankings with medals 🥇🥈🥉

### 2. Check Course Statistics
- Go to Reports → Course Statistics
- Enter course code (e.g., CS101)
- View average grade and grade distribution

### 3. See Student Transcript
- Go to Reports → Student Transcript
- Enter student ID (e.g., S004)
- View all enrolled courses with grades and GPA

### 4. View Grade Distribution
- Go to Course Management → View Course Details
- Enter course code
- See how many students got each grade

### 5. Update Grades
- Go to Enrollment Management → Assign/Update Grade
- Change existing grades (try improving Ethan's grades!)

### 6. Search Functionality
- Go to Search → Search Students
- Try partial names (e.g., "Alice")
- Or search courses by code/name

## 🎨 Color Coding

The system uses colors for better visualization:

- 🟢 **Green**: Success messages, A grades
- 🔵 **Blue**: B grades, dividers
- 🟡 **Yellow**: C grades, warnings
- 🟣 **Purple**: D grades
- 🔴 **Red**: F grades, errors
- 🔷 **Cyan**: Headers, prompts, info

## ⚠️ Important Notes

1. **Validation**: The system prevents:
   - Duplicate student IDs or emails
   - Duplicate course codes
   - Duplicate enrollments
   - Invalid email formats
   - Negative credit hours

2. **GPA Calculation**: 
   - Automatic and credit-weighted
   - Uses standard 4.0 scale
   - Updates immediately when grades change

3. **Data Persistence**: 
   - Data is stored in-memory only
   - Data is lost when you exit
   - Use this as a demonstration/learning tool

## 🆘 Troubleshooting

### "Student/Course not found"
- Make sure you entered the correct ID/Code
- IDs and codes are case-sensitive
- Use Search to find the correct ID

### "Already enrolled"
- Student is already in that course
- Check the student's transcript to see current enrollments

### "Invalid email"
- Email must be in format: name@domain.com
- Check for typos

### Colors not showing?
- Windows: Use Windows Terminal or PowerShell 7+
- Mac/Linux: Should work in all terminals
- Colors use ANSI escape codes

## 💡 Tips & Tricks

1. **Start with sample data** to explore all features
2. **Try the test script** to see all functionality demonstrated
3. **Use search** to quickly find students or courses
4. **Check system statistics** to get overview of your data
5. **Sort students** by name or GPA in the student list view
6. **View course rosters** to see all students in a class
7. **Grade distribution** helps identify course difficulty

## 📚 Learning Path

### For Beginners
1. Run with sample data
2. Explore all menus
3. View different reports
4. Try searching

### For Intermediate Users
1. Start with empty system
2. Add your own students and courses
3. Enroll students
4. Assign grades
5. Generate reports

### For Advanced Users
1. Review the code structure
2. Understand the architecture
3. Add new features
4. Extend functionality

## 🔗 Next Steps

- Read `README_CEMS.md` for detailed documentation
- Explore the code in `lib/` directory
- Try adding new features
- Adapt it for your own use case

## 📝 Example Session

```
1. Start: dart run bin/cems_with_sample_data.dart
2. Press Enter to continue
3. Select 4 (Reports & Analytics)
4. Select 2 (Top Performing Students)
5. See Diana Prince at #1 with 4.00 GPA
6. Back to main menu
7. Select 3 (Enrollment Management)
8. Select 2 (Assign/Update Grade)
9. Update Ethan's CS301 grade from C to B
10. Select 4 (Reports & Analytics)
11. Select 2 (Top Performing Students)
12. See Ethan's rank improve!
```

## 🎓 Educational Value

This project demonstrates:
- ✅ Object-Oriented Programming
- ✅ Collections (Lists, Maps, Sets)
- ✅ Null Safety
- ✅ Error Handling
- ✅ Data Validation
- ✅ Console UI Design
- ✅ Business Logic Implementation
- ✅ Code Organization

---

**Happy Learning! 📚✨**

For questions or issues, please refer to the main README or code documentation.

