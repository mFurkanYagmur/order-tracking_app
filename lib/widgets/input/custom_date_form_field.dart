import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/extensions.dart';
import 'custom_text_form_field.dart';

class CustomDateFormField extends StatefulWidget {
  CustomDateFormField({
    Key? key,
    required this.label,
    required this.saveData,
    this.listener,
    this.defaultValue,
    this.isRequired = false,
    this.validator,
    this.isActive = true,
  }) : super(key: key);

  final String? label;
  void Function(DateTime? value, String? display) saveData;
  void Function(DateTime? value, String? display, dynamic lastValue)? listener;
  final String? defaultValue;
  final bool isRequired;
  final String? Function(String?)? validator;
  bool isActive;
  bool Function(BuildContext context, String? value)? valueConfirmation;

  @override
  State<CustomDateFormField> createState() => _CustomDateFormFieldState();
}

class _CustomDateFormFieldState extends State<CustomDateFormField> {
  late String? value;
  String? lastValue;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    _myInitState();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    _myInitState();
  }

  _myInitState() {
    textEditingController = TextEditingController();
    if (widget.isActive) {
      value = widget.defaultValue; // ?? DateTime.now().toFormattedString();
      textEditingController.text = value ?? '';

      // widget.saveData(value, null);
      /*if (widget.initValue != null) {
        widget.initValue!(value);
      } else if (widget.useOnChangeInsteadInitValue) {
        widget.onChanged(value);
      }*/
      // widget.onChanged(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.isActive
          ? null
          : () {
              datePickerForDateInput();
            },
      child: CustomTextFormField(
        label: widget.label ?? '',
        enabled: false,
        isRequired: widget.isRequired,
        isActive: widget.isActive,
        controller: textEditingController,
        validator: widget.validator,
        onDataDeleted: () {
          widget.saveData(null, null);
          if (widget.listener != null) widget.listener!(null, null, lastValue);
          lastValue = null;
          // widget.onChanged(null);
        },
        suffixIcon: Padding(
          padding: EdgeInsets.all(26.r),
          child: SvgPicture.asset(
            "assets/icons/calendar2-date.svg",
            color: Theme.of(context).shadowColor.withOpacity(0.9),
            height: 40.h,
          ),
        ),
      ),
    );
  }

  datePickerForDateInput() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      locale: LocaleType.tr,
      onChanged: (date) {},

      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).cardColor,
        itemStyle: TextStyle(
          color: Theme.of(context).shadowColor.withOpacity(0.9),
        ),
        // headerColor: Style.secondaryColor,
        doneStyle: TextStyle(
          color: Theme.of(context).shadowColor.withOpacity(0.9),
        ),
        cancelStyle: TextStyle(
          color: Theme.of(context).shadowColor.withOpacity(0.9),
        ),
      ),
      onConfirm: (date) {
        // selectedDateTime = date;
      },
      // currentTime: DateTime(2008, 12, 31, 23, 12, 34),
    ).then((value) {
      if (value != null) {
        String formattedString = value.toFormattedString();
        if (widget.valueConfirmation != null && !widget.valueConfirmation!(context, formattedString)) {
          return;
        }

        setState(() {
          this.value = formattedString;
          textEditingController.text = this.value ?? '';
        });
        widget.saveData(value, formattedString);
        if (widget.listener != null) widget.listener!(value, formattedString, lastValue);
        lastValue = this.value;
        // widget.onChanged(this.value);

      }
    });
  }
}
