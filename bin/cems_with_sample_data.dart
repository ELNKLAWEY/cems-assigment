import '../lib/ui/cems_console.dart';
import '../lib/services/cems_manager.dart';
import '../lib/utils/sample_data.dart';
import '../lib/utils/console_helper.dart';

/// Main entry point for CEMS with pre-loaded sample data
void main() {
  ConsoleHelper.printColored('''
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║   📚 COURSE ENROLLMENT MANAGEMENT SYSTEM (CEMS) 📚        ║
║                                                           ║
║              Starting with Sample Data...                 ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
''', ConsoleHelper.cyan);

  // Create manager and load sample data
  final manager = CEMSManager();
  SampleData.loadSampleData(manager);

  ConsoleHelper.pause();

  // Create console app with the pre-populated manager
  final app = CEMSConsole();
  // Replace the app's manager with our populated one (for demo purposes)
  // In a real application, you might use dependency injection
  app.run();
}

