import 'dart:io';

/// ANSI color codes for console output
class ConsoleColors {
  static const String reset = '\x1B[0m';
  static const String bold = '\x1B[1m';
  
  // Text colors
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';
  static const String gray = '\x1B[90m';
  
  // Background colors
  static const String bgBlack = '\x1B[40m';
  static const String bgRed = '\x1B[41m';
  static const String bgGreen = '\x1B[42m';
  static const String bgYellow = '\x1B[43m';
  static const String bgBlue = '\x1B[44m';
  static const String bgMagenta = '\x1B[45m';
  static const String bgCyan = '\x1B[46m';
  static const String bgWhite = '\x1B[47m';

  /// Print colored text
  static void printColored(String text, String color) {
    // ignore: avoid_print
    stdout.writeln('$color$text$reset');
  }

  /// Print success message
  static void success(String message) {
    // ignore: avoid_print
    stdout.writeln('$green✓ $message$reset');
  }

  /// Print error message
  static void error(String message) {
    // ignore: avoid_print
    stdout.writeln('$red✗ $message$reset');
  }

  /// Print warning message
  static void warning(String message) {
    // ignore: avoid_print
    stdout.writeln('$yellow⚠ $message$reset');
  }

  /// Print info message
  static void info(String message) {
    // ignore: avoid_print
    stdout.writeln('$cyan ℹ $message$reset');
  }

  /// Print header
  static void header(String text) {
    // ignore: avoid_print
    stdout.writeln('$bold$cyan$text$reset');
  }
}

