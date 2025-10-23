import 'dart:io';

/// Utility class for input validation and reading
class InputValidator {
  /// Read a non-empty string from console
  static String readString(String prompt, {bool required = true}) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';
      
      if (input.isEmpty && required) {
        print('  \x1B[31m✗ This field is required. Please try again.\x1B[0m');
        continue;
      }
      
      return input;
    }
  }

  /// Read an integer from console
  static int readInt(String prompt, {int? min, int? max}) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';
      
      try {
        final value = int.parse(input);
        
        if (min != null && value < min) {
          print('  \x1B[31m✗ Value must be at least $min\x1B[0m');
          continue;
        }
        
        if (max != null && value > max) {
          print('  \x1B[31m✗ Value must be at most $max\x1B[0m');
          continue;
        }
        
        return value;
      } catch (e) {
        print('  \x1B[31m✗ Invalid number. Please try again.\x1B[0m');
      }
    }
  }

  /// Read a yes/no confirmation
  static bool readConfirmation(String prompt) {
    while (true) {
      stdout.write('$prompt (y/n): ');
      final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';
      
      if (input == 'y' || input == 'yes') return true;
      if (input == 'n' || input == 'no') return false;
      
      print('  \x1B[31m✗ Please enter y or n\x1B[0m');
    }
  }

  /// Read an optional string
  static String? readOptionalString(String prompt) {
    stdout.write(prompt);
    final input = stdin.readLineSync()?.trim() ?? '';
    return input.isEmpty ? null : input;
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Read and validate email
  static String readEmail(String prompt) {
    while (true) {
      final email = readString(prompt);
      if (isValidEmail(email)) {
        return email;
      }
      print('  \x1B[31m✗ Invalid email format. Please try again.\x1B[0m');
    }
  }

  /// Wait for user to press Enter
  static void waitForEnter([String message = 'Press Enter to continue...']) {
    stdout.write('\n\x1B[90m$message\x1B[0m');
    stdin.readLineSync();
  }

  /// Clear console (cross-platform)
  static void clearScreen() {
    if (Platform.isWindows) {
      print(Process.runSync('cls', [], runInShell: true).stdout);
    } else {
      print(Process.runSync('clear', [], runInShell: true).stdout);
    }
  }
}

