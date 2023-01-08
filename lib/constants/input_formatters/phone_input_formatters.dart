import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneInputFormatters {
  PhoneInputFormatters._();
  static String getTrMask() => "+90 (###) ### ## ##";

  static MaskTextInputFormatter getUserPhoneFormatter() {
    return MaskTextInputFormatter(
      mask: getTrMask(),
      filter: {"#": RegExp(r'[0-9]')},
      // type: MaskAutoCompletionType.lazy,
    );
  }

  static MaskTextInputFormatter getPhoneFormatter({required String mask}) {
    return MaskTextInputFormatter(
      mask: mask,
      filter: {"#": RegExp(r'[0-9]')},
      // type: MaskAutoCompletionType.lazy,
    );
  }
}
