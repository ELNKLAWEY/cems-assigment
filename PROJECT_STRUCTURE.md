# CEMS Project Structure

## Directory Layout

```
cems/
│
├── bin/
│   ├── main.dart                    # Application entry point
│   └── cems.exe                     # Compiled executable (Windows)
│
├── lib/
│   ├── models/                      # Data model classes
│   │   ├── student.dart            # Student entity with GPA calculation
│   │   ├── course.dart             # Course entity with statistics
│   │   ├── enrollment.dart         # Enrollment linking students and courses
│   │   └── grade.dart              # Grade enum with point values
│   │
│   ├── utils/                       # Utility classes
│   │   ├── console_colors.dart     # ANSI color codes and helper methods
│   │   └── input_validator.dart   # Input validation and reading utilities
│   │
│   ├── ui/                          # User interface
│   │   └── console_ui.dart         # Console menu system and interaction
│   │
│   └── cems_manager.dart           # Main business logic manager
│
├── .gitignore                       # Git ignore file
├── analysis_options.yaml            # Dart analyzer configuration
├── pubspec.yaml                     # Package dependencies
├── README.md                        # Comprehensive project documentation
├── QUICKSTART.md                    # Quick start guide
├── FEATURES.md                      # Feature implementation checklist
└── PROJECT_STRUCTURE.md            # This file
```

## File Descriptions

### Core Application Files

#### `bin/main.dart`
- Entry point of the application
- Instantiates ConsoleUI and starts the program
- Minimal code - delegates to UI layer

#### `lib/cems_manager.dart`
- **CEMSManager class** - Central business logic
- Manages all students, courses, and enrollments
- Implements CRUD operations
- Provides statistics and analytics
- Uses Maps for efficient lookups
- **Lines of Code**: ~250

### Model Classes (`lib/models/`)

#### `student.dart`
- **Student class** - Represents a student
- Fields: id, name, email, phoneNumber?, enrollments[]
- Methods: 
  - `calculateGPA()` - Compute GPA from enrollments
  - `isEnrolledIn()` - Check course enrollment
  - `toDetailedString()` - Formatted output
- **Lines of Code**: ~100

#### `course.dart`
- **Course class** - Represents a course
- Fields: courseCode, courseName, creditHours, enrollments[]
- Methods:
  - `calculateAverageGrade()` - Average grade for course
  - `getGradeDistribution()` - Grade histogram
  - `getPassingStudents()` - Students with D or better
  - `toDetailedString()` - Formatted output
- **Lines of Code**: ~120

#### `enrollment.dart`
- **Enrollment class** - Links student to course
- Fields: student, course, grade?, enrollmentDate
- Methods:
  - `assignGrade()` - Set or update grade
  - `isPassing()` - Check if grade is passing
- Implements equality for duplicate prevention
- **Lines of Code**: ~50

#### `grade.dart`
- **Grade enum** - All possible grades
- 12 grade levels from A+ to F
- Each with letter representation and grade point value
- Methods:
  - `fromString()` - Parse string to Grade
  - `colorCode` getter - ANSI color for grade
  - `coloredString` getter - Colored output
- **Lines of Code**: ~60

### Utility Classes (`lib/utils/`)

#### `console_colors.dart`
- **ConsoleColors class** - ANSI color utilities
- Static constants for all colors
- Helper methods:
  - `success()` - Green checkmark messages
  - `error()` - Red X messages
  - `warning()` - Yellow warning messages
  - `info()` - Cyan info messages
  - `header()` - Bold cyan headers
- **Lines of Code**: ~60

#### `input_validator.dart`
- **InputValidator class** - Input validation utilities
- Static methods:
  - `readString()` - Read required string
  - `readInt()` - Read integer with min/max
  - `readEmail()` - Read and validate email
  - `readOptionalString()` - Read nullable string
  - `readConfirmation()` - Yes/no prompts
  - `waitForEnter()` - Pause for user
  - `clearScreen()` - Cross-platform screen clear
- **Lines of Code**: ~100

### User Interface (`lib/ui/`)

#### `console_ui.dart`
- **ConsoleUI class** - Main user interface
- Manages the menu system and user interaction
- Methods for each menu option:
  - Student management (add, view, search)
  - Course management (add, view, search)
  - Enrollment operations
  - Grade assignment
  - Statistics and reports
- Pre-loads sample data for demonstration
- **Lines of Code**: ~450

## Code Statistics

| Component | Files | Lines of Code | Complexity |
|-----------|-------|---------------|------------|
| Models | 4 | ~330 | Medium |
| Manager | 1 | ~250 | High |
| UI | 1 | ~450 | Medium |
| Utils | 2 | ~160 | Low |
| **Total** | **8** | **~1190** | **Medium** |

## Design Patterns Used

1. **Encapsulation**
   - Private fields with public getters
   - Validation in constructors and methods
   - Data hiding with underscore prefix

2. **Composition**
   - Enrollment connects Student and Course
   - Better than inheritance for this relationship

3. **Manager Pattern**
   - CEMSManager centralizes business logic
   - Separates data management from UI

4. **Strategy Pattern (implicit)**
   - Different sorting strategies (by name, GPA, enrollment)

5. **Factory Pattern (implicit)**
   - Grade.fromString() creates enum from string

## OOP Principles Demonstrated

- ✅ **Encapsulation**: Private fields, controlled access
- ✅ **Abstraction**: Hide complexity behind simple interfaces
- ✅ **Composition**: Enrollment links students and courses
- ✅ **Polymorphism**: toString() overrides
- ✅ **Single Responsibility**: Each class has one job
- ✅ **DRY (Don't Repeat Yourself)**: Utility classes for reuse

## Data Flow

```
User Input (Console)
       ↓
ConsoleUI (Menu System)
       ↓
CEMSManager (Business Logic)
       ↓
Models (Student, Course, Enrollment)
       ↓
CEMSManager (Calculations & Queries)
       ↓
ConsoleUI (Formatted Display)
       ↓
Console Output (With Colors)
```

## Key Collections Used

1. **Map<String, Student>** - Fast student lookup by ID
2. **Map<String, Course>** - Fast course lookup by code
3. **List<Enrollment>** - Ordered enrollment records
4. **List<Enrollment>** (per student) - Student's courses
5. **List<Enrollment>** (per course) - Course roster

## Error Handling Strategy

- **Validation at Input**: InputValidator catches bad input
- **Validation at Creation**: Constructors validate data
- **Validation at Operation**: Manager methods check preconditions
- **User-Friendly Messages**: Clear error descriptions
- **Try-Catch Blocks**: Prevent crashes, show errors gracefully

## Null Safety

- **Nullable Fields**: phoneNumber?, grade?
- **Null-Aware Operators**: ?., ??, !
- **Null Checks**: Explicit checks before operations
- **Safe Defaults**: Return empty lists/zero instead of null

## Testing the Structure

Run analysis to verify:
```bash
dart analyze
```

Compile to executable:
```bash
dart compile exe bin/main.dart -o bin/cems.exe
```

Run directly:
```bash
dart run
```

---

**Last Updated**: October 2025

