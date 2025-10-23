/// Enum representing possible grades a student can receive
enum Grade {
  aPlus('A+', 4.0),
  a('A', 4.0),
  aMinus('A-', 3.7),
  bPlus('B+', 3.3),
  b('B', 3.0),
  bMinus('B-', 2.7),
  cPlus('C+', 2.3),
  c('C', 2.0),
  cMinus('C-', 1.7),
  dPlus('D+', 1.3),
  d('D', 1.0),
  f('F', 0.0);

  final String letter;
  final double gradePoint;

  const Grade(this.letter, this.gradePoint);

  /// Parse a string to Grade enum
  static Grade? fromString(String gradeStr) {
    try {
      return Grade.values.firstWhere(
        (g) => g.letter.toLowerCase() == gradeStr.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get ANSI color code for grade
  String get colorCode {
    switch (this) {
      case Grade.aPlus:
      case Grade.a:
      case Grade.aMinus:
        return '\x1B[32m'; // Green
      case Grade.bPlus:
      case Grade.b:
      case Grade.bMinus:
        return '\x1B[34m'; // Blue
      case Grade.cPlus:
      case Grade.c:
      case Grade.cMinus:
        return '\x1B[33m'; // Yellow
      case Grade.dPlus:
      case Grade.d:
        return '\x1B[35m'; // Magenta
      case Grade.f:
        return '\x1B[31m'; // Red
    }
  }

  /// Get colored string representation
  String get coloredString => '$colorCode$letter\x1B[0m';

  @override
  String toString() => letter;
}

