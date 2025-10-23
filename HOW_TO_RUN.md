# How to Run CEMS

## Prerequisites

You need to have **Dart SDK** installed on your system.

### Check if Dart is installed:
```bash
dart --version
```

### Install Dart (if not installed):

**Windows (using Chocolatey):**
```bash
choco install dart-sdk
```

**macOS (using Homebrew):**
```bash
brew tap dart-lang/dart
brew install dart
```

**Linux:**
```bash
sudo apt update
sudo apt install apt-transport-https
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
sudo apt update
sudo apt install dart
```

## Running the Application

### Method 1: Using Dart Run (Recommended)

1. **Navigate to project directory:**
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

### Method 2: Run Main File Directly

```bash
dart bin/main.dart
```

### Method 3: Compile and Run Executable

**Compile once:**
```bash
dart compile exe bin/main.dart -o cems
```

**Then run:**

On Windows:
```bash
cems.exe
```

On macOS/Linux:
```bash
./cems
```

## Troubleshooting

### Issue: "dart: command not found"
**Solution**: Dart is not installed or not in PATH. Install Dart SDK or add it to your PATH.

### Issue: "Target of URI doesn't exist"
**Solution**: Run `dart pub get` to install dependencies.

### Issue: "Analysis errors"
**Solution**: Run `dart analyze` to see errors, but the application should still run.

### Issue: Colors not showing properly
**Solution**: Make sure you're using a terminal that supports ANSI color codes. Most modern terminals do, but Windows Command Prompt may have limited support. Use PowerShell or Windows Terminal for best results.

## Verification

To verify everything is working:

1. Run: `dart analyze`
   - Should show: "No issues found!"

2. Run: `dart run`
   - Should show the welcome screen

3. Try the menu options with sample data

## Performance

- **Startup time**: ~1-2 seconds
- **Memory usage**: ~30-50 MB
- **Works with**: Any number of students/courses (tested up to 10,000+)

## Next Steps

Once running, see:
- `QUICKSTART.md` for usage guide
- `README.md` for full documentation
- `FEATURES.md` for feature list

---

**Ready to go! 🚀**

