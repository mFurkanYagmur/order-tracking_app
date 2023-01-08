import 'input_formatters/phone_input_formatters.dart';

class Validator {
  Validator._();

  static String? emptyValidator(String? s) {
    return null;
  }

  static String? requiredTextValidator(String? s, [int? maxLength = 100]) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (maxLength != null && s.length > maxLength) {
      return '$maxLength karakterden fazla olamaz.';
    }
    return null;
  }

  static String? requiredMultilineTextValidator(String? s) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (s.length > 300) {
      return '300 karakterden fazla olamaz.';
    }
    return null;
  }

  static String? Function(String?) getPhoneValidator(String? mask) {
    mask ??= PhoneInputFormatters.getTrMask();

    return (String? s) {
      if (s == null || s.isEmpty) {
        return 'Bu alan boş bırakılamaz';
      } else if (s.length < mask!.length) {
        return 'Geçerli bir telefon numarası giriniz';
      }
      return null;
    };
  }

  static String? numberValidator(String? s) {
    var regex = RegExp(r'^[0-9]*$');
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (!regex.hasMatch(s)) {
      return 'Hatalı sayı girişi. Sadece rakamları kullanınız';
    }
    return null;
  }

  static String? decimalValidator(String? s) {
    var regex = RegExp(r'[0-9]+\.{0,1}[0-9]*');
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (!regex.hasMatch(s)) {
      return 'Hatalı sayı girişi. Sadece rakamlar ve \',\' kullanılabilir';
    }
    return null;
  }

  static String? emailValidator(String? s) {
    var regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (!regex.hasMatch(s)) {
      return 'Lütfen geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  static String? passwordValidator(String? s) {
    if (s == null || s.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    } else if (s.trim().length < 6) {
      return 'Parolanız en az 6 karakterden oluşmalıdır';
    }
    return null;
  }
}
