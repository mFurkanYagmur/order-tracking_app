import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:order_tracking_app/constants/style.dart';
import 'package:order_tracking_app/constants/validator.dart';
import 'package:order_tracking_app/view_models/auth_viewmodel.dart';
import 'package:order_tracking_app/widgets/input/custom_text_form_field.dart';
import 'package:order_tracking_app/widgets/solid_button.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import 'components/title.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email, _password;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        PageTitle(height: _size.height * 0.3, width: _size.width),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(Style.defaultPadding),
                            child: _buildForm(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Container(
                      height: constraints.biggest.height,
                      width: constraints.biggest.width,
                      color: Colors.white.withOpacity(0.7),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Style.secondaryColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              label: 'E-Mail',
              inputType: InputType.email,
              onSaved: (s) {
                _email = s!.trim();
              },
              validator: Validator.emailValidator,
              // isRequired: true,
              hint: 'E-Mail',
              autofillHints: const [AutofillHints.email],
            ),
            SizedBox(
              height: Style.defaultPadding,
            ),
            CustomTextFormField(
              label: 'Parola',
              inputType: InputType.password,
              onSaved: (s) {
                _password = s!.trim();
              },
              validator: Validator.passwordValidator,
              obscureText: true,
              textInputAction: TextInputAction.done,
              // isRequired: true,
              hint: 'Parola',
              autofillHints: const [AutofillHints.password],
            ),
            SizedBox(
              height: Style.defaultPadding / 2,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'forgot_password'.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            SizedBox(
              height: Style.defaultPadding,
            ),
            SolidButton(text: 'login'.tr(), onPressed: () => _loginTapped(context)),
          ],
        ),
      ),
    );
  }

  Future _loginTapped(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _login(context);
    }
  }

  Future _login(BuildContext context) async {
    try {
      await context.read<AuthViewModel>().login(email: _email!, password: _password!);
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
    } catch (e) {
      log('Login hatası $e', name: 'ERROR-LOGIN');
    }
  }
}
