# CEMS Quick Start Guide

## Installation & Running

1. **Navigate to the project directory:**
   ```bash
   cd cems
   ```

2. **Install dependencies:**
   ```bash
   dart pub get
   ```

3. **Run the application:**
   ```bash
   dart run
   ```

## First Steps

When you start the application, you'll see a welcome screen. The system comes pre-loaded with sample data:

### Sample Students
- **S001** - Alice Johnson (GPA: ~3.85)
- **S002** - Bob Smith (GPA: ~3.15)
- **S003** - Charlie Brown (GPA: 2.0)
- **S004** - Diana Prince (GPA: 4.0)
- **S005** - Ethan Hunt (Not graded yet)

### Sample Courses
- **CS101** - Introduction to Programming (3 credits)
- **CS201** - Data Structures (4 credits)
- **MATH101** - Calculus I (4 credits)
- **ENG101** - English Composition (3 credits)
- **PHY101** - Physics I (4 credits)

## Common Tasks

### View Top Students
1. Choose option **10** from the main menu
2. Enter how many students to display (e.g., 5)
3. See the leaderboard with GPAs

### Add a New Student
1. Choose option **1** from the main menu
2. Enter Student ID (e.g., S006)
3. Enter Name (e.g., Frank Castle)
4. Enter Email (e.g., frank.c@university.edu)
5. Enter Phone (optional, press Enter to skip)

### Enroll Student in Course
1. Choose option **3** from the main menu
2. View the list of available students
3. Enter the Student ID (e.g., S006)
4. View the list of available courses
5. Enter the Course Code (e.g., CS101)

### Assign Grade
1. Choose option **4** from the main menu
2. Enter Student ID (e.g., S006)
3. View the student's enrollments
4. Select an enrollment by number
5. Enter a grade (e.g., A, B+, C, etc.)

### View Student Details
1. Choose option **7** from the main menu
2. Enter Student ID (e.g., S001)
3. See complete profile with courses and GPA

### Search
1. Choose option **11** from the main menu
2. Select search type (1 for Students, 2 for Courses)
3. Enter search query (partial matches work!)

## Tips

- 🎨 **Color Coding**: Grades are color-coded (Green=A, Blue=B, Yellow=C, Purple=D, Red=F)
- 🔍 **Search**: Works with partial matches and is case-insensitive
- ✅ **Validation**: The system prevents invalid inputs and duplicate data
- 📊 **Statistics**: Check option 9 for system-wide analytics
- 💡 **Sample Data**: Use the pre-loaded data to explore features immediately

## Keyboard Shortcuts

- **Enter** - Continue after viewing information
- **0** - Exit the application from main menu
- **Ctrl+C** - Force quit (emergency exit)

## Grade Scale Reference

| Grade | Points |
|-------|--------|
| A+, A | 4.0    |
| A-    | 3.7    |
| B+    | 3.3    |
| B     | 3.0    |
| B-    | 2.7    |
| C+    | 2.3    |
| C     | 2.0    |
| C-    | 1.7    |
| D+    | 1.3    |
| D     | 1.0    |
| F     | 0.0    |

## Try This Demo Flow

1. **View top students** (Menu 10)
2. **Add a new student** (Menu 1)
3. **Enroll them in 2-3 courses** (Menu 3)
4. **Assign grades** (Menu 4)
5. **View their profile** (Menu 7)
6. **Check updated top students** (Menu 10)
7. **View system statistics** (Menu 9)

## Need Help?

- See `README.md` for complete documentation
- See `FEATURES.md` for feature checklist
- All menus have numbered options - just enter the number!

---

**Enjoy using CEMS! 🎓**

