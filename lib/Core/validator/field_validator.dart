import 'package:flutter/services.dart';

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Prevent adding space at the beginning of the input
    if (newValue.text.startsWith(' ')) {
      // If the new input starts with a space, remove it
      return TextEditingValue(
        text: newValue.text.trimLeft(), // Remove leading spaces
        selection: TextSelection.collapsed(offset: newValue.text.trimLeft().length),
      );
    } else {
      // Otherwise, allow the input
      return newValue;
    }
  }
}
