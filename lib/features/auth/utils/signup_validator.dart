/// Validation rules and error messages for Screen 03 (Sign Up).
abstract final class SignUpValidator {
  /// Validates full name (required).
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى كتابة الاسم بالكامل';
    }
    return null;
  }

  /// Validates phone number (required, minimum 8 digits).
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى كتابة رقم الهاتف';
    }
    if (value.trim().length < 8) {
      return 'رقم الهاتف قصير جداً';
    }
    return null;
  }

  /// Validates email address (required, standard syntax).
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى كتابة البريد الإلكتروني';
    }
    final trimmed = value.trim();
    if (!trimmed.contains('@') || !trimmed.contains('.')) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  /// Validates password (required, minimum 6 characters).
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى كتابة كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  /// Validates password confirmation (required, must match password).
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != password) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }
}
