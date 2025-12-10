import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == oldValue.text) {
      return newValue;
    }

    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedText = '';

    if (newText.length > 8) {
      formattedText = oldValue.text;
    } else if (newText.isNotEmpty) {
      if (newText.length <= 2) {
        formattedText = newText;
      } else if (newText.length <= 4) {
        formattedText = '${newText.substring(0, 2)}/${newText.substring(2)}';
      } else {
        formattedText = '${newText.substring(0, 2)}/${newText.substring(2, 4)}/${newText.substring(4)}';
      }
    }

    int cursorPosition = formattedText.length;
    
    if (newValue.text.length < oldValue.text.length) {
      cursorPosition = newValue.selection.baseOffset;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition.clamp(0, formattedText.length)),
    );
  }
}