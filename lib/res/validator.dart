// lib/utils/validators.dart
class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email address';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }

    if (value.length < 4) {
      return 'Password must be at least 4 characters long';
    }

    return null;
  }

  // Security code validation (optional - if you still want validation)
  static String? validateSecurityCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter security code';
    }

    if (value.length < 4) {
      return 'Code must be at least 4 characters long';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  // Minimum length validation
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }
    return null;
  }
}