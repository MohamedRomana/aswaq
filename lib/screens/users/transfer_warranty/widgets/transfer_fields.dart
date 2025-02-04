// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class TransferFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController idController;

  const TransferFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.idController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          start: 24.w,
          bottom: 10.h,
          text: LocaleKeys.recipient_name.tr(),
          size: 14.sp,
        ),
        AppInput(
          filled: true,
          border: 15.r,
          enabledBorderColor: Colors.grey,
          hint: LocaleKeys.recipient_name.tr(),
          controller: nameController,
          prefixIcon: Icon(
            Icons.person_outline,
            size: 30.sp,
            color: Colors.grey,
          ),
          validate: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.nameValidate.tr();
            } else {
              return null;
            }
          },
        ),
        AppText(
          top: 16.h,
          start: 24.w,
          bottom: 10.h,
          text: LocaleKeys.phone.tr(),
          size: 14.sp,
        ),
        AppInput(
          filled: true,
          border: 15.r,
          enabledBorderColor: Colors.grey,
          hint: LocaleKeys.phone.tr(),
          controller: phoneController,
          inputType: TextInputType.phone,
          prefixIcon: Icon(
            Icons.phone_outlined,
            size: 24.sp,
            color: Colors.grey,
          ),
          validate: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.phoneValidate.tr();
            } else {
              return null;
            }
          },
        ),
        AppText(
          top: 16.h,
          start: 24.w,
          bottom: 10.h,
          text: LocaleKeys.identity_number.tr(),
          size: 14.sp,
        ),
        AppInput(
          filled: true,
          border: 15.r,
          enabledBorderColor: Colors.grey,
          hint: LocaleKeys.identity_number.tr(),
          inputType: TextInputType.number,
          controller: idController,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.r),
            child: SvgPicture.asset(
              Assets.svg.id,
              height: 10.w,
              width: 10.w,
              fit: BoxFit.cover,
              color: Colors.grey,
            ),
          ),
          validate: (value) {
            if (value!.isEmpty) {
              return LocaleKeys.identity_number.tr();
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
