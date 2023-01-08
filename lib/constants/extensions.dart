import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateStringParsing on DateTime {
  String toFormattedString() {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }
}

extension TimeStringParsing on TimeOfDay {
  String toFormattedString() {
    return '$hour:$minute';
  }
}

extension DoubleFormatting on double {
  double toCustomPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).floor().toDouble() / mod);
  }

  double toCustomPrecisionWithoutZeros(int fractionDigits) {
    if (this%1 == 0) {
      return floorToDouble();
    }
    double mod = pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).roundToDouble() / mod);
  }

  List<String> toMoneySentence() {

    String formattedString = toString().toNumberFormat().replaceAll('-', '').trim();
    String integerSection = formattedString.split(',')[0];
    String? decimalSection = (formattedString.split(',').length > 1 ? formattedString.split(',')[1] : null);

    String integerStr = '';
    String decimalStr = '';
    var items = [
      ["", ""],
      ["BİR", "ON"],
      ["İKİ", "YİRMİ"],
      ["ÜÇ", "OTUZ"],
      ["DÖRT", "KIRK"],
      ["BEŞ", "ELLİ"],
      ["ALTI", "ALTMIŞ"],
      ["YEDİ", "YETMİŞ"],
      ["SEKİZ", "SEKSEN"],
      ["DOKUZ", "DOKSAN"]
    ];

    //  Integer Section
    List<String> numberList = integerSection.split('.');
    for (int listIndex = 0; listIndex < numberList.length ; listIndex++) {
      int basamakNumarasi = numberList.length-1-listIndex;
      for (int basamak = 0; basamak < numberList[listIndex].length; basamak++){
        int basamakDegeri = numberList[listIndex].length-1 - basamak;
        int sayi = int.parse(numberList[listIndex][basamak]);
        String item = items[sayi][(basamakDegeri == 1) ? 1 : 0];

        if (sayi == 0 && numberList.length >1) continue;

        integerStr = '${integerStr.isEmpty ? '' : '$integerStr '}'
            '${(sayi == 1 && basamakDegeri == 2) ? 'YÜZ' : ((sayi == 1 && basamakNumarasi == 1 && basamakDegeri == 0) ? '' : item)}'
            '${basamakDegeri == 2 ? (sayi == 1 ? '' : ((sayi == 0) ? '' : ' YÜZ')) : ''}';
      }

      switch(basamakNumarasi) {
        case 1:
          integerStr += '${int.parse(numberList[listIndex]) == 1 ? '' : ' '}BİN';
          break;
        case 2:
          integerStr += ' MİLYON';
          break;
        case 3:
          integerStr += ' Milyar';
          break;
        case 4:
          integerStr += ' TRİLYON';
          break;
      }
    }

    if (integerStr.isNotEmpty) {
      integerStr += ' TL';
    }

    //  Decimal Section
    if (decimalSection != null) {
      if (decimalSection.length == 1){
        int sayi = int.parse(decimalSection[0]);
        decimalStr = (sayi == 0) ? '' : items[sayi][0];
      } else if (decimalSection.length >= 2) {
        int sayi1 = int.parse(decimalSection[0]);
        int sayi2 = int.parse(decimalSection[1]);

        if(sayi1 != 0 || sayi2 != 0) {
          for (int basamak = 0; basamak < decimalSection.length; basamak++){
            int sayi = int.parse(decimalSection[basamak]);
            String item = items[sayi][(basamak == 0) ? 1 : 0];
            decimalStr = '${decimalStr.isEmpty ? '' : '$decimalStr '}$item';
          }
        }
      }

      if (decimalStr.isNotEmpty) {
        decimalStr += ' KR';
      }
    }

    //  eksili sayı gelme durumu
    bool minus = this < 0;
    if (minus && integerStr.isNotEmpty) {
      integerStr = 'EKSİ $integerStr';
    } else if (minus && decimalStr.isNotEmpty) {
      decimalStr = 'EKSİ $decimalStr';
    }

    List<String> resultList = [];
    if (integerStr.isNotEmpty) {
      resultList.add(integerStr);
    }
    if (decimalStr.isNotEmpty) {
      resultList.add(decimalStr);
    }


    return resultList;

    // String str = '$integerStr${(integerStr.isNotEmpty && decimalStr.isNotEmpty) ? ' ' : ''}$decimalStr';
    //
    // return str.isNotEmpty ? '#$str#' : '';
  }

  //  virgülden sonra "123.0" olursa "123" şeklinde parse ediliyor
  String toFormattedString() {
    var numberFormatter = NumberFormat()
      ..minimumFractionDigits = 0
        ..maximumFractionDigits = 2;

    return numberFormatter.format(this);
  }
}

extension StringFormatting on String {
  String removeRequiredSign() {
    if (endsWith('*')) {
      return substring(0, length - 1).trim();
    }
    return this;
  }

  String removePercentSign() {
    if (endsWith('%')) {
      return substring(0, length - 1).trim();
    }
    return this;
  }

  String removeOtherCode() {
    return split('#')[0];
  }

  String parseColumnDisplayName() {
    return removeRequiredSign().removePercentSign().removeOtherCode();
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(
        hour: int.parse(split(":")[0]), minute: int.parse(split(":")[1]));
  }

  DateTime toDateTime() {
    return DateTime(
        int.parse(split('-')[0].toString()),
        int.parse(split('-')[1].toString()),
        int.parse(split('-')[2].toString()));
  }

  String toMoneyFormat() {
    // return NumberFormat.currency(
    //   locale: 'eu',
    //   customPattern: '#,### \u00a4',
    //   symbol: '₺',
    //   decimalDigits: 2,
    // ).format(this);
    return '${toNumberFormat()} ₺';
  }

  /// convert raw data to number format
  String toNumberFormat({bool isDeleting = false}) {
    if (this != '.' && double.tryParse(this) == null) {
      return '';
    }

    // String rawString = numberToRawFormat();
    var rawSplitList = split('.');
    String integerSection = split('.')[0];
    String decimalSection = rawSplitList.length > 1 ? split('.')[1] : '';

    String result = '';

    if (integerSection[0] == '-') {
      integerSection = integerSection.substring(1, integerSection.length);
      result += '-';
    }

    for (int i = 0; i < integerSection.length; i++) {
      if (i != 0 && (integerSection.length - i) % 3 == 0) {
        result += '.${integerSection[i]}';
      } else {
        result += integerSection[i];
      }
    }

    if (contains('.')) {
      result += ',';
    }

    for (int i = 0; i < decimalSection.length && i < 2; i++) {
      result += decimalSection[i];
    }

    if (decimalSection.length == 1 && !isDeleting) {
      result += '0';
    }

    return result;
  }

  String numberToRawFormat() {
    String doubleFormat =
        split(' ')[0].replaceAll('.', '').replaceAll(',', '.');
    List<String> doubleSplitList = doubleFormat.split('.');
    String result = doubleSplitList[0] +
        (doubleSplitList.length > 1 ? '.${doubleSplitList[1]}' : '');
    // result = double.tryParse(result) != null ? result : '';
    return result;
  }

  String generateMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  bool? parseBool() {
    if (toLowerCase().trim() == 'true' || this == '1') {
      return true;
    } else if (toLowerCase().trim() == 'false' || this == '0') {
      return false;
    }
    return null;
  }

  String trPhoneToRawString() {
    //  veri zaten formatlı ise
    if (length == 10) return this;
    debugPrint('phone length : $length');

    String formattedString =
    replaceAll(' ', '').replaceAll('+90(', '').replaceAll(')', '');
    return formattedString;
  }
}

var numberFormatter = NumberFormat.currency(
  locale: 'eu',
  customPattern: '#,### \u00a4',
  symbol: '₺',
  decimalDigits: 2,
);
