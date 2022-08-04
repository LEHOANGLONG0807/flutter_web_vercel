import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:app_visitor/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'package:app_visitor/common/common.dart';

import 'widget/widget.dart';

class FormScreen extends GetResponsiveView<FormController> {
  final _textTheme = Get.textTheme;

  FormScreen({Key? key}) : super(key: key);

  final _underlineBorderTextFiled = const UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.colorGreyE2E0E0),
  );

  @override
  Widget build(context) {
    return GetBuilder<FormController>(
      builder: (_) {
        if (controller.customerId.isNotEmpty) {
          return ViewSubmitSuccess();
        }
        return Scaffold(
          backgroundColor: AppColors.primary,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white, size: 40),
          ),
          body: Column(
            children: [
              60.verticalSpace,
              Image.asset(
                'img_logo_company'.assetImagesPathPNG,
                height: 60,
              ),
              30.verticalSpace,
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 50, left: 100, right: 100),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Check-in',
                          style: _textTheme.headline3!.textPrimary,
                        ),
                        5.verticalSpace,
                        Text(
                          'Welcome aboard! We look forward to helping you get the most out of HTH. Just check in and enjoy the visit.',
                          textAlign: TextAlign.center,
                          style: _textTheme.headline5!.textGrey797979.regular,
                        ),
                        40.verticalSpace,
                        _buildForm(),
                        40.verticalSpace,
                        if (controller.isEnabled)
                          Obx(() {
                            return const Text('Submit')
                                .elevatedButton(
                                onPressed: controller.isInitialsNameRequires.isTrue
                                    ? () {
                                  FocusScope.of(context).unfocus();
                                  controller.onSubmit();
                                }
                                    : null)
                                .wrapWidth(200);
                          }),
                        // else
                        //   const Text('Print')
                        //       .elevatedButton(onPressed: controller.onTapPrinting)
                        //       .wrapWidth(200),
                        100.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: controller.formKey,
      child: Column(
        children: <Widget>[
          _buildTitleAndWidget(
            title: 'First Name',
            child: FormBuilderTextField(
              name: 'Type your name',
              onChanged: (_) {
                controller.initials();
              },
              enabled: controller.isEnabled,
              textCapitalization: TextCapitalization.words,
              controller: controller.firstNameController,
              decoration: const InputDecoration(hintText: 'Type your name'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'First name is require'),
              ]),
            ),
          ),
          30.verticalSpace,
          _buildTitleAndWidget(
            title: 'Last Name',
            child: FormBuilderTextField(
              name: 'Type your name',
              enabled: controller.isEnabled,
              onChanged: (_) {
                controller.initials();
              },
              textCapitalization: TextCapitalization.words,
              controller: controller.lastNameController,
              decoration: const InputDecoration(hintText: 'Type your name'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Last name is require'),
              ]),
            ),
          ),
          30.verticalSpace,
          _buildTitleAndWidget(
            title: 'Your Company',
            child: FormBuilderTextField(
              name: 'company',
              minLines: 1,
              textCapitalization: TextCapitalization.words,
              enabled: controller.isEnabled,
              maxLines: 10,
              controller: controller.companyController,
              decoration: const InputDecoration(hintText: 'Tell us which company you work for'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Your Company is require'),
              ]),
            ),
          ),
          30.verticalSpace,
          _buildTitleAndWidget(
            title: 'Purpose of Your Visit',
            child: FormBuilderDropdown<String>(
              name: 'purpose_of_visit',
              initialValue:
              controller.isEnabled == false ? controller.purposeController.text : null,
              onChanged: (val) => controller.purposeController.text = val ?? '',
              decoration: const InputDecoration(hintText: 'Select Your Purposes'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Purpose of Your Visit is require'),
              ]),
              items: List<DropdownMenuItem<String>>.from(
                (!controller.isEnabled
                ? ['For an interview']
                        : ['For an interview', 'To explore HTH premises'])
                    .map(
                      (s) =>
                      DropdownMenuItem(
                        value: s,
                        child: Text(s),
                      ),
                ),
              ),
            ),
          ),
          30.verticalSpace,
          _buildCheckInPhoto(),
          30.verticalSpace,
          _buildTitleCheckbox(
            title: RichText(
              text: TextSpan(
                  text: 'I have read and agree to ',
                  style: _textTheme.headline5!.regular,
                  children: [
                    TextSpan(
                      text: 'Security, Safety & Environmental Notice',
                      style: _textTheme.headline5!.regular.textPrimary,
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.onTapSecurity,
                    ),
                    const TextSpan(
                      text: ' and escort required.',
                    ),
                  ]),
            ),
            isCheck: controller.isInitialsNameRequires,
            child: Obx(() {
              return FormBuilderTextField(
                name: 'above',
                key: ValueKey(controller.initial.value),
                controller: controller.initialsNameController,
                textCapitalization: TextCapitalization.characters,
                enabled: controller.isEnabled,
                decoration: InputDecoration(
                  hintText:controller.initial.isNotEmpty?controller.initial.value: 'Your Initials Name',
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: _underlineBorderTextFiled,
                  focusedBorder: _underlineBorderTextFiled,
                  disabledBorder: _underlineBorderTextFiled,
                  border: _underlineBorderTextFiled,
                  focusedErrorBorder: _underlineBorderTextFiled.copyWith(
                    borderSide: const BorderSide(color: AppColors.colorRedE53535),
                  ),
                  errorBorder: _underlineBorderTextFiled.copyWith(
                    borderSide: const BorderSide(color: AppColors.colorRedE53535),
                  ),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(errorText: 'Please enter your initials name'),
                    FormBuilderValidators.equal(controller.initial.value,
                        errorText: 'Initials name must match with your full name filled above'),
                  ],
                ),
              );
            }),
          ),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildCheckInPhoto() {
    return Obx(
          () {
        final file = controller.fileImage.value;
        late Widget _child;
        if (file is String) {
          if (file.isEmpty) {
            _child = InkWell(
              onTap: controller.checkInImage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'ic_checkin_photo'.assetImagesPathPNG,
                    width: 40,
                  ),
                  5.verticalSpace,
                  Text('Take a selfie', style: _textTheme.headline5!.regular.textGrey797979),
                ],
              ),
            );
          } else {
            _child = CachedImageNetworkWidget(
              url: file,
            );
          }
        } else {
          if (file is File) {
            _child = Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  height: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.fileImage.value = '';
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          } else {
            _child = const SizedBox();
          }
        }
        return _buildTitleAndWidget(
          title: 'Check-in photo',
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(15),
            dashPattern: const [8, 8],
            color: AppColors.colorGreyBBBBBB,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 300,
              width: double.infinity,
              child: _child,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleCheckbox(
      {required Widget title, required RxBool isCheck, required Widget child}) {
    return Column(
      children: [
        Row(
          children: [
            Obx(() {
              return InkWell(
                onTap: controller.isEnabled ? isCheck.toggle : null,
                child: Icon(
                  isCheck.isTrue ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isCheck.isTrue ? AppColors.primary : AppColors.colorGreyBBBBBB,
                  size: 35,
                ),
              );
            }),
            10.horizontalSpace,
            Expanded(
              child: title,
            ),
          ],
        ),
        5.verticalSpace,
        child,
      ],
    );
  }

  Widget _buildTitleAndWidget({required String title, required Widget child}) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        child.paddingOnly(top: 8),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              2.horizontalSpace,
              Text(
                title,
                style: _textTheme.headline5!.medium,
              ),
              Text(
                ' *',
                style: _textTheme.subtitle1!.textRedE53535,
              ),
            ],
          ),
        ).paddingOnly(left: 20),
      ],
    );
  }
}
