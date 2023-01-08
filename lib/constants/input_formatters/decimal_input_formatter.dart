import 'package:flutter/services.dart';

import '../extensions.dart';

class DecimalInputFormatter extends TextInputFormatter {
  late String unFormattedText;
  late int oldCursor;
  bool isDeleting = false;
  double minValue;
  double maxValue;
  bool syncToMinMaxValue;

  DecimalInputFormatter({
    this.minValue = -99999999.99,
    this.maxValue = 99999999.99,
    this.syncToMinMaxValue = false,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    oldCursor = oldValue.selection.start;

    //  metin üzerinde silme işlemi yapılmışsa
    _setUnformattedText(newValue, oldValue);

    String newText = parseRatio(oldValue, newValue, unFormattedText);
    int newCursor = calculateNewCursor(oldCursor, oldValue.text, newText);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }

  void _setUnformattedText(TextEditingValue newValue, TextEditingValue oldValue) {
    if (newValue.text.length < oldValue.text.length) {
      isDeleting = true;
      int cursorIndex = oldValue.selection.start;

      // cursor noktadan sonra ise silme işlemi ('12.|321,00' || '1.|321,00')
      if (cursorIndex > 1 && oldValue.text[cursorIndex - 1] == '.') {
        //  ilgili karakterlerin silinmesi
        unFormattedText = oldValue.text.substring(0, cursorIndex - 2) + oldValue.text.substring(cursorIndex);

        //  '12.|321,00' durumunda '2.' karakterlerinin beraber silinmesi durumunda cursor:
        if (cursorIndex > 2) {
          oldCursor = cursorIndex - 1;
        }
        //  '1.|321,00' durumunda '1.' karakterlerinin beraber silinmesi durumunda cursor:
        else {
          oldCursor = cursorIndex;
        }
      }

      // 12.345,|98 durumunda ',98' karakterlerinin beraber silinmesi
      else if (oldValue.text[cursorIndex - 1] == ',') {
        unFormattedText = oldValue.text.substring(0, cursorIndex - 1);
        oldCursor = cursorIndex + 2;
      }

      // diğer durumlarda ekstra bir işlem yapılmayacak
      else {
        unFormattedText = newValue.text;
      }
    } else {
      unFormattedText = newValue.text;
    }
  }

  String parseRatio(TextEditingValue oldValue, TextEditingValue newValue, String unFormattedText) {
    String rawFormat = unFormattedText.numberToRawFormat();
    double tempDoubleValue = double.tryParse(rawFormat) ?? 0;

    if (rawFormat.isNotEmpty && rawFormat[0] == '.' && rawFormat.length > 1) {
      rawFormat = '0$rawFormat';
    }

    if (tempDoubleValue > maxValue) {
      rawFormat = syncToMinMaxValue ? maxValue.toString() : oldValue.text.numberToRawFormat();
    } else if (tempDoubleValue < minValue) {
      rawFormat = syncToMinMaxValue ? minValue.toString() : oldValue.text.numberToRawFormat();
    }
    String formattedString = rawFormat.toNumberFormat(isDeleting: isDeleting);
    String matched = RegExp(r'(0{0,1}([,]{0,1})?(?:(,)\d{0,2}))|(0)|([1-9][0-9]{0,2})(\.[0-9]{3})*(,\d{0,2}|)')
            .firstMatch(formattedString)
            ?.group(0) ??
        '';
    return matched;
  }

  int calculateNewCursor(int oldCursor, String oldText, String formattedText) {
    int newCursor = oldCursor;
    int difference = formattedText.length - oldText.length;
    newCursor += difference;

    if (newCursor > formattedText.length) {
      return formattedText.length;
    }
    return newCursor >= 0 ? newCursor : 0;
  }
}
