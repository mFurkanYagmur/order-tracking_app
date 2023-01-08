/*
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../constants/validator.dart';

enum SuffixIcon { none, visiblePassword }

class TextInputFormField extends StatefulWidget {
  final String label;
  final Validator validator;
  final SuffixIcon suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction textInputAction;
  final void Function(String?) onSaved;

  TextInputFormField({
    Key? key,
    required this.label,
    required this.validator,
    this.suffixIcon = SuffixIcon.none,
    required this.keyboardType,
    this.obscureText = false,
    required this.textInputAction,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<TextInputFormField> createState() => _TextInputFormFieldState();
}

class _TextInputFormFieldState extends State<TextInputFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Style.defaultPadding / 4, horizontal: Style.defaultPadding),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        TextFormField(
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          validator: widget.validator.validate,
          obscureText: _passwordVisible,
          onSaved: widget.onSaved,
          decoration: InputDecoration(
            hintText: widget.label,
            border: InputBorder.none,
            isCollapsed: true,
            fillColor: Theme.of(context).cardColor,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: Style.defaultPadding * 0.75,
              horizontal: Style.defaultPadding,
            ),
            enabledBorder: _getInputBorder(),
            focusedBorder: _getInputBorder(),
            disabledBorder: _getInputBorder(),
            errorBorder: _getInputBorder(color: Theme.of(context).errorColor),
            focusedErrorBorder: _getInputBorder(),
            suffixIcon: widget.suffixIcon == SuffixIcon.visiblePassword
                ? IconButton(
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
                  )
                : null,
          ),
        ),
      ],
    );
  }

  InputBorder _getInputBorder({Color color = Style.primaryColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(color: color),
    );
  }
}
*/
