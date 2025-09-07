/// Email validation utility
class EmailValidator {
  static bool isValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

/// Password validation utility
class PasswordValidator {
  static bool isValid(String password) {
    // Minimum 6 characters
    return password.length >= 6;
  }

  static bool isStrong(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }
}

/// Note validation utility
class NoteValidator {
  static bool isValidTitle(String title) {
    return title.trim().isNotEmpty && title.length <= 100;
  }

  static bool isValidContent(String content) {
    return content.length <= 10000; // 10KB limit
  }
}
