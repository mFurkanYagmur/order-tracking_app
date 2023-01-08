import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/extensions.dart';
import '../../constants/input_formatters/decimal_input_formatter.dart';
import '../../constants/input_formatters/phone_input_formatters.dart';
import '../../constants/style.dart';
import '../../constants/validator.dart';

enum InputType {
  text,
  multiLineText,
  phone,
  number,
  decimalNumber,
  email,
  password,
}

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.hint = '',
    this.maxLines,
    this.inputType = InputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.onSubmitted,
    this.controller,
    this.enabled = true,
    this.isActive = true,
    this.autoFocus,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.autofillHints,
    this.onDataDeleted,
  }) : super(key: key);

  String label;
  String? initialValue;
  bool isRequired;
  String hint;
  int? maxLines;

  /// InputType.phone seçildiğinde mask girilmesi zorunlu
  InputType inputType;
  TextInputAction textInputAction;
  bool? obscureText;
  String? Function(String?)? validator;
  Widget? prefixIcon;
  Widget? suffixIcon;
  FocusNode? focusNode;
  void Function(String?)? onSaved;
  void Function(String?)? onChanged;
  void Function(String)? onSubmitted;
  TextEditingController? controller;
  bool enabled;
  bool isActive;
  bool? autoFocus;
  List<TextInputFormatter>? inputFormatters;
  late TextInputType keyboardType;
  TextCapitalization textCapitalization;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final Function()? onDataDeleted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String currentPhoneMask = PhoneInputFormatters.getTrMask();
  Timer? onEditingCompleteTimer;

  @override
  Widget build(BuildContext context) {
    if (widget.controller != null) {
      widget.controller!.addListener(() {
        _onChanged(widget.controller!.text);
      });
    }
    _setKeyboardType();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: Style.defaultPadding,
        // ),
        if (widget.label.isNotEmpty)
          Text.rich(
            TextSpan(
              // style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: widget.label.parseColumnDisplayName(),
                  style: const TextStyle(
                      // color: Style.primaryColor /*, fontSize: 16.sp*/,
                      ),
                ),
                if (widget.isRequired)
                  const TextSpan(
                    text: '  *',
                    style: TextStyle(color: Style.dangerColor),
                  ),
              ],
            ),
          ),
        if (widget.label.isNotEmpty)
          SizedBox(
            height: Style.defaultPadding / 2,
          ),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Center(child: _buildTextFormField(context))),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: (widget.onDataDeleted != null && (widget.controller?.text.isNotEmpty ?? false)) && widget.isActive
                  ? IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.all(Style.defaultPadding / 2),
                      onPressed: () {
                        setState(() {
                          if (widget.controller != null) {
                            widget.controller!.text = '';
                          }
                          if (widget.onDataDeleted != null) {
                            widget.onDataDeleted!();
                          }
                        });
                      },
                      icon: Icon(Icons.clear, size: Style.defaultIconSize / 2),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus == true ? true : false,
      initialValue: (widget.inputType != InputType.decimalNumber) ? widget.initialValue : widget.initialValue?.toNumberFormat(),
      controller: widget.controller,
      maxLength: widget.maxLength,
      autofillHints: widget.autofillHints,
      buildCounter: (BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}) {
        if (isFocused && maxLength != null && currentLength > 0) {
          return Text(
            '$currentLength/$maxLength',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: currentLength == maxLength ? Style.successColor.withOpacity(0.7) : Theme.of(context).shadowColor,
                ),
          );
        }
        return null;
      },
      validator: (s) {
        if (widget.validator != null) {
          return widget.validator!(s);
        } else if (widget.isRequired || _isRequiredLabel()) {
          return _defaultValidators()!(s);
        }
        return null;
      },
      onSaved: widget.onSaved,
      onChanged: widget.controller == null ? _onChanged : null,
      textAlignVertical: widget.suffixIcon != null ? TextAlignVertical.center : null,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        fillColor: widget.isActive == false ? Theme.of(context).shadowColor.withOpacity(0.1) : Theme.of(context).cardColor,
        filled: true,
        hintText: widget.hint,
        errorStyle: Theme.of(context).textTheme.caption!.copyWith(color: Style.dangerColor),
        hintStyle: TextStyle(
          // color: Style.primaryColor.withOpacity(0.6),
          color: widget.isActive == false
              ? Theme.of(context).shadowColor.withOpacity(0.5)
              : Theme.of(context).shadowColor.withOpacity(0.9),
          fontSize: 40.sp,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            width: Style.defaultBorderSize,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Style.dangerColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Style.defaultPadding,
          vertical: Style.defaultPadding / 2,
        ),
        // prefix: _getPrefix(context),
        suffixIcon: _getSuffixIcon(context),
        suffixIconColor: Theme.of(context).shadowColor.withOpacity(0.1),
      ),
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            // color: Style.primaryColor,
            fontSize: 48.sp,
          ),
      maxLines: widget.maxLines ?? (widget.inputType == InputType.multiLineText ? 5 : 1),
      keyboardType: widget.keyboardType,
      textInputAction: widget.inputType == InputType.multiLineText ? TextInputAction.newline : widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText ?? false,
      obscuringCharacter: '•',
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      textCapitalization: widget.textCapitalization,
    );
  }

  Widget? _getSuffixIcon(BuildContext context) {
    if (widget.inputType == InputType.password) {
      return InkWell(
        onTap: () {
          setState(() {
            widget.obscureText = !widget.obscureText!;
            debugPrint('obscureText : ${widget.obscureText}');
          });
        },
        child: widget.obscureText!
            ? Container(
                padding: EdgeInsets.all(40.r),
                child: SvgPicture.asset(
                  "assets/icons/eye-slash.svg",
                  height: 30.h,
                  color: Theme.of(context).shadowColor.withOpacity(1),
                ),
              )
            : Container(
                padding: EdgeInsets.all(40.r),
                child: SvgPicture.asset(
                  "assets/icons/eyef.svg",
                  height: 30.h,
                  color: Theme.of(context).shadowColor.withOpacity(1),
                ),
              ),
      );
    }
    return widget.suffixIcon == null
        ? null
        : Padding(
            padding: EdgeInsets.all(Style.defaultPadding * 0.4),
            child: widget.suffixIcon,
          );
  }

  bool _isRequiredLabel() {
    return widget.label.endsWith('*');
  }

  void _onChanged(String s) {
    if (s.isNotEmpty && widget.inputType == InputType.decimalNumber) {
      s = s.numberToRawFormat();
    }
    if (widget.onChanged != null) widget.onChanged!(s);

    //  onEditingComplete
    if (widget.textInputAction == TextInputAction.search /*&& widget.onEditingComplete != null*/) {
      if (onEditingCompleteTimer != null) {
        onEditingCompleteTimer!.cancel();
      }
    }
  }

  void _setKeyboardType() {
    switch (widget.inputType) {
      case InputType.text:
        widget.keyboardType = TextInputType.text;
        break;
      case InputType.multiLineText:
        widget.keyboardType = TextInputType.multiline;
        break;
      case InputType.number:
        widget.keyboardType = TextInputType.number;
        widget.inputFormatters ??= <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ];
        break;
      case InputType.decimalNumber:
        widget.keyboardType = const TextInputType.numberWithOptions(decimal: true);
        widget.inputFormatters ??= <TextInputFormatter>[
          DecimalInputFormatter(),
        ];
        break;
      case InputType.phone:
        widget.keyboardType = TextInputType.number;
        widget.inputFormatters ??= [
          PhoneInputFormatters.getPhoneFormatter(mask: currentPhoneMask),
        ];
        break;
      case InputType.email:
        widget.keyboardType = TextInputType.emailAddress;
        break;
      case InputType.password:
        widget.keyboardType = TextInputType.visiblePassword;
        widget.obscureText ??= true;
        break;
    }
  }

  String? Function(String?)? _defaultValidators() {
    switch (widget.inputType) {
      case InputType.text:
        return Validator.requiredTextValidator;
      case InputType.multiLineText:
        return Validator.requiredMultilineTextValidator;
      case InputType.number:
        return Validator.numberValidator;
      case InputType.decimalNumber:
        return Validator.decimalValidator;
      case InputType.phone:
        return Validator.getPhoneValidator(currentPhoneMask);
      case InputType.email:
        return Validator.emailValidator;
      case InputType.password:
        return Validator.passwordValidator;
    }
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/style.dart';

enum SuffixIcon { none, visiblePassword }

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.hint = '',
    this.maxLines,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.onSubmitted,
    this.controller,
    this.enabled = true,
    this.isActive = true,
    this.autoFocus,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.autofillHints,
    this.deletableData = false,
    this.onDataDeleted,
  }) : super(key: key);

  String label;
  String? initialValue;
  bool isRequired;
  String hint;
  int? maxLines;
  TextInputAction textInputAction;
  bool? obscureText;
  String? Function(String?)? validator;
  Widget? prefixIcon;
  Widget? suffixIcon;
  FocusNode? focusNode;
  void Function(String?)? onSaved;
  void Function(String?)? onChanged;
  void Function(String)? onSubmitted;
  TextEditingController? controller;
  bool enabled;
  bool isActive;
  bool? autoFocus;
  List<TextInputFormatter>? inputFormatters;
  TextInputType keyboardType;
  TextCapitalization textCapitalization;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final bool deletableData;
  final Function()? onDataDeleted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller != null) {
      widget.controller!.addListener(() {
        _onChanged(widget.controller!.text);
      });
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                ),
                if (widget.isRequired)
                  const TextSpan(
                    text: '  *',
                    style: TextStyle(color: Style.dangerColor),
                  ),
              ],
            ),
          ),
        if (widget.label.isNotEmpty)
          SizedBox(
            height: Style.defaultPadding / 2,
          ),
        _buildTextFormField(context),
      ],
    );
  }

  TextFormField _buildTextFormField(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus == true ? true : false,
      initialValue: widget.initialValue,
      controller: widget.controller,
      maxLength: widget.maxLength,
      autofillHints: widget.autofillHints,
      buildCounter: (BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}) {
        if (isFocused && maxLength != null && currentLength > 0) {
          return Text(
            '$currentLength/$maxLength',
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: currentLength == maxLength ? Style.successColor.withOpacity(0.7) : Theme.of(context).shadowColor,
                ),
          );
        }
        return null;
      },
      validator: (s) {
        if (widget.validator != null) {
          return widget.validator!(s);
        }
        return null;
      },
      onSaved: widget.onSaved,
      onChanged: widget.controller == null ? _onChanged : null,
      textAlignVertical: widget.suffixIcon != null ? TextAlignVertical.center : null,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        fillColor: widget.isActive == false ? Theme.of(context).shadowColor.withOpacity(0.1) : Theme.of(context).cardColor,
        filled: true,
        hintText: widget.hint,
        errorStyle: Theme.of(context).textTheme.caption!.copyWith(color: Style.dangerColor),
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: widget.isActive == false
              ? Theme.of(context).shadowColor.withOpacity(0.5)
              : Theme.of(context).shadowColor.withOpacity(0.9),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Style.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Style.dangerColor),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Style.defaultPadding,
          vertical: Style.defaultPadding / 2,
        ),
        suffixIcon: _getSuffixIcon(context),
        suffixIconColor: Theme.of(context).shadowColor.withOpacity(0.1),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText ?? false,
      obscuringCharacter: '•',
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      textCapitalization: widget.textCapitalization,
    );
  }

  Widget? _getSuffixIcon(BuildContext context) {
    if (widget.suffixIcon == SuffixIcon.visiblePassword) {
      return IconButton(
        splashColor: Colors.transparent,
        icon: Icon(
          _passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Style.primaryColor,
        ),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      );
    }
    return null;
  }

  bool _isRequiredLabel() {
    return widget.label.endsWith('*');
  }

  void _onChanged(String s) {
    if (widget.onChanged != null) widget.onChanged!(s);
  }
}
*/
