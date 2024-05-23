
import 'package:flutter/services.dart';

class FirstLetterUpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    return newValue.copyWith(text: newValue.text.replaceFirst(RegExp(r'^[a-z]'), newValue.text[0].toUpperCase()));
  }
}