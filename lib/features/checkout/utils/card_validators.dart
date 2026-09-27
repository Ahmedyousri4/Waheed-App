import 'package:waheed/features/checkout/models/payment_card.dart';

// ──────────────────────────────────────────────────────────────────
// Brand detection
// ──────────────────────────────────────────────────────────────────

/// Detects the card brand from the first digits of the card number.
///
/// - Starts with **4** → Visa
/// - Prefix **51–55** or **2221–2720** → Mastercard
/// - Otherwise → unknown
CardBrand detectBrand(String digits) {
  if (digits.isEmpty) return CardBrand.unknown;
  if (digits.startsWith('4')) return CardBrand.visa;

  if (digits.length >= 2) {
    final prefix2 = int.tryParse(digits.substring(0, 2));
    if (prefix2 != null && prefix2 >= 51 && prefix2 <= 55) {
      return CardBrand.mastercard;
    }
  }

  if (digits.length >= 4) {
    final prefix4 = int.tryParse(digits.substring(0, 4));
    if (prefix4 != null && prefix4 >= 2221 && prefix4 <= 2720) {
      return CardBrand.mastercard;
    }
  }

  return CardBrand.unknown;
}

// ──────────────────────────────────────────────────────────────────
// Luhn algorithm
// ──────────────────────────────────────────────────────────────────

/// Returns `true` if [digits] passes the Luhn check.
bool luhnCheck(String digits) {
  if (digits.isEmpty || !RegExp(r'^\d+$').hasMatch(digits)) return false;

  int sum = 0;
  bool alternate = false;
  for (int i = digits.length - 1; i >= 0; i--) {
    int n = int.parse(digits[i]);
    if (alternate) {
      n *= 2;
      if (n > 9) n -= 9;
    }
    sum += n;
    alternate = !alternate;
  }
  return sum % 10 == 0;
}

// ──────────────────────────────────────────────────────────────────
// Field validators — return Arabic error message or null
// ──────────────────────────────────────────────────────────────────

/// Holder name: required, at least 3 characters.
String? validateHolderName(String? value) {
  if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
  if (value.trim().length < 3) return 'الاسم يجب أن يكون ٣ أحرف على الأقل';
  return null;
}

/// Card number: 16 digits, Luhn-valid.
String? validateCardNumber(String? value) {
  if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
  final digits = value.replaceAll(' ', '');
  if (digits.length != 16 || !RegExp(r'^\d+$').hasMatch(digits)) {
    return 'رقم الكارت غير صحيح';
  }
  if (!luhnCheck(digits)) return 'رقم الكارت غير صحيح';
  return null;
}

/// Expiry: MM/YY, month 01–12, not in the past.
String? validateExpiry(String? value) {
  if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
  final parts = value.split('/');
  if (parts.length != 2) return 'تاريخ الانتهاء غير صحيح';

  final month = int.tryParse(parts[0]);
  final year = int.tryParse(parts[1]);
  if (month == null || year == null) return 'تاريخ الانتهاء غير صحيح';
  if (month < 1 || month > 12) return 'تاريخ الانتهاء غير صحيح';

  final now = DateTime.now();
  final fullYear = 2000 + year;
  // Last day of the expiry month.
  final expiry = DateTime(fullYear, month + 1, 0);
  if (expiry.isBefore(now)) return 'تاريخ الانتهاء غير صحيح';

  return null;
}

/// CVV: 3 digits (4 if the card prefix is 34 or 37 — Amex).
String? validateCvv(String? value, String cardNumber) {
  if (value == null || value.trim().isEmpty) return 'هذا الحقل مطلوب';
  final digits = cardNumber.replaceAll(' ', '');
  final isAmex = digits.startsWith('34') || digits.startsWith('37');
  final requiredLength = isAmex ? 4 : 3;
  if (value.length != requiredLength || !RegExp(r'^\d+$').hasMatch(value)) {
    return 'CVV غير صحيح';
  }
  return null;
}
