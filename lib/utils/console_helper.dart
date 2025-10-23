import 'dart:io';

/// Helper class for console UI operations
class ConsoleHelper {
  // ANSI color codes
  static const String reset = '\x1B[0m';
  static const String bold = '\x1B[1m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  /// Print colored text
  static void printColored(String text, String color) {
    print('$color$text$reset');
  }

  /// Print success message
  static void printSuccess(String message) {
    printColored('✓ $message', green);
  }

  /// Print error message
  static void printError(String message) {
    printColored('✗ $message', red);
  }

  /// Print warning message
  static void printWarning(String message) {
    printColored('⚠ $message', yellow);
  }

  /// Print info message
  static void printInfo(String message) {
    printColored('ℹ $message', cyan);
  }

  /// Print header
  static void printHeader(String text) {
    print('');
    printColored('╔${'═' * (text.length + 2)}╗', cyan);
    printColored('║ $text ║', cyan);
    printColored('╚${'═' * (text.length + 2)}╝', cyan);
    print('');
  }

  /// Print section divider
  static void printDivider() {
    printColored('━' * 60, blue);
  }

  /// Clear the console
  static void clearConsole() {
    if (Platform.isWindows) {
      print(Process.runSync("cls", [], runInShell: true).stdout);
    } else {
      print(Process.runSync("clear", [], runInShell: true).stdout);
    }
  }

  /// Read user input with prompt
  static String? readInput(String prompt, {bool required = true}) {
    stdout.write('$cyan$prompt$reset ');
    final input = stdin.readLineSync()?.trim();
    
    if (required && (input == null || input.isEmpty)) {
      printError('Input cannot be empty');
      return null;
    }
    
    return input;
  }

  /// Read integer input
  static int? readInt(String prompt) {
    final input = readInput(prompt);
    if (input == null) return null;
    
    try {
      return int.parse(input);
    } catch (e) {
      printError('Invalid number format');
      return null;
    }
  }

  /// Read choice from options
  static String? readChoice(String prompt, List<String> options) {
    print('$cyan$prompt$reset');
    for (var i = 0; i < options.length; i++) {
      print('  ${i + 1}. ${options[i]}');
    }
    
    final choice = readInt('Enter your choice:');
    if (choice == null || choice < 1 || choice > options.length) {
      printError('Invalid choice');
      return null;
    }
    
    return options[choice - 1];
  }

  /// Pause and wait for user to press enter
  static void pause() {
    stdout.write('\n${yellow}Press Enter to continue...$reset');
    stdin.readLineSync();
  }

  /// Display a table
  static void printTable(List<String> headers, List<List<String>> rows) {
    if (headers.isEmpty || rows.isEmpty) return;

    // Calculate column widths
    List<int> widths = List.filled(headers.length, 0);
    for (var i = 0; i < headers.length; i++) {
      widths[i] = headers[i].length;
      for (var row in rows) {
        if (i < row.length && row[i].length > widths[i]) {
          widths[i] = row[i].length;
        }
      }
    }

    // Print header
    printColored('┌${widths.map((w) => '─' * (w + 2)).join('┬')}┐', cyan);
    
    String headerRow = '│ ';
    for (var i = 0; i < headers.length; i++) {
      headerRow += headers[i].padRight(widths[i]) + ' │ ';
    }
    printColored(headerRow.trimRight(), bold);

    printColored('├${widths.map((w) => '─' * (w + 2)).join('┼')}┤', cyan);

    // Print rows
    for (var row in rows) {
      String rowStr = '│ ';
      for (var i = 0; i < headers.length; i++) {
        String cell = i < row.length ? row[i] : '';
        rowStr += cell.padRight(widths[i]) + ' │ ';
      }
      print(rowStr.trimRight());
    }

    printColored('└${widths.map((w) => '─' * (w + 2)).join('┴')}┘', cyan);
  }
}

