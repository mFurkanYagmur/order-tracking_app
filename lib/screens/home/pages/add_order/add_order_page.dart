import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_tracking_app/constants/routes.dart';
import 'package:order_tracking_app/view_models/loading_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../constants/style.dart';
import '../../../../view_models/add_order_viewmodel.dart';
import '../../../../widgets/input/custom_date_form_field.dart';
import '../../../../widgets/input/custom_text_form_field.dart';
import '../../../../widgets/solid_bottom_sheet.dart';
import '../../../../widgets/solid_button.dart';

part 'components/_add_order_image.dart';

class AddOrderPage extends StatelessWidget {
  AddOrderPage({Key? key}) : super(key: key);

  // final AddOrderModel model = AddOrderModel();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Style.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const _AddOrderImage(),
                  SizedBox(
                    width: Style.defaultPadding,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: 'Ad soyad',
                          isRequired: true,
                          onSaved: (s) {
                            context.read<AddOrderViewModel>().orderModel.name = s ?? '';
                          },
                        ),
                        SizedBox(
                          height: Style.defaultPadding / 2,
                        ),
                        CustomTextFormField(
                          label: 'Telefon numaras??',
                          inputType: InputType.phone,
                          onSaved: (s) {
                            context.read<AddOrderViewModel>().orderModel.phone = s;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                label: 'Sipari?? tutar??',
                inputType: InputType.decimalNumber,
                isRequired: true,
                onSaved: (s) {
                  context.read<AddOrderViewModel>().orderModel.price = double.tryParse(s ?? '') ?? 0;
                },
              ),
              SizedBox(
                height: Style.defaultPadding / 2,
              ),
              CustomTextFormField(
                label: '??denen tutar',
                inputType: InputType.decimalNumber,
                onSaved: (s) {
                  context.read<AddOrderViewModel>().orderModel.paid = double.tryParse(s ?? '');
                },
              ),
              SizedBox(
                height: Style.defaultPadding / 2,
              ),
              CustomTextFormField(
                label: 'Sipari?? a????klamas??',
                inputType: InputType.multiLineText,
                isRequired: true,
                onSaved: (s) {
                  context.read<AddOrderViewModel>().orderModel.description = s ?? '';
                },
              ),
              SizedBox(
                height: Style.defaultPadding / 2,
              ),
              CustomDateFormField(
                label: 'Teslim zaman??',
                saveData: (value, display) {
                  context.read<AddOrderViewModel>().orderModel.deliverDate = value!;
                },
                isRequired: true,
              ),
              SizedBox(
                height: Style.defaultPadding,
              ),
              SolidButton(
                  text: 'Kaydet',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _save(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _save(BuildContext context) async {
    try {
      context.read<LoadingViewModel>().start();
      await context.read<AddOrderViewModel>().save();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sipari?? Eklendi')));
      Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
    } catch (e) {
      log('Order save error : $e', name: 'ERROR-AddOrder');
    } finally {
      context.read<LoadingViewModel>().end();
    }
  }
}
