import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../data/auth_cubit.dart';

class CustomUserRegisterFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController fullNameController;
  final TextEditingController locationController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;

  const CustomUserRegisterFields({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passController,
    required this.confirmPassController,
    required this.locationController,
    required this.fullNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppText(
              bottom: 31.h,
              start: 36.w,
              text: LocaleKeys.new_registration.tr(),
              size: 24.sp,
              color: Colors.black,
              family: Assets.fonts.norsalBold,
            ),
          ),
          AppText(
            start: 38.w,
            bottom: 8.h,
            text: LocaleKeys.username.tr(),
            color: Colors.black,
            fontWeight: FontWeight.w400,
            size: 14.sp,
          ),
          AppInput(
            enabledBorderColor: Colors.grey,
            bottom: 16.h,
            filled: true,
            hint: LocaleKeys.fullName.tr(),
            controller: fullNameController,
            inputType: TextInputType.name,
            validate: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.usernameValidate.tr();
              } else {
                return null;
              }
            },
            prefixIcon: Icon(
              Icons.person,
              color: Colors.grey,
              size: 25.sp,
            ),
          ),
          AppText(
            start: 38.w,
            bottom: 8.h,
            text: LocaleKeys.phone.tr(),
            color: Colors.black,
            fontWeight: FontWeight.w400,
            size: 14.sp,
          ),
          AppInput(
            enabledBorderColor: Colors.grey,
            bottom: 16.h,
            filled: true,
            hint: LocaleKeys.phone.tr(),
            controller: phoneController,
            inputType: TextInputType.phone,
            validate: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.phoneValidate.tr();
              } else {
                return null;
              }
            },
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.grey,
              size: 25.sp,
            ),
          ),
          AppText(
            start: 38.w,
            bottom: 8.h,
            text: LocaleKeys.chooseCity.tr(),
            color: Colors.black,
            fontWeight: FontWeight.w400,
            size: 14.sp,
          ),
          AppInput(
            enabledBorderColor: Colors.grey,
            bottom: 16.h,
            filled: true,
            hint: LocaleKeys.chooseCity.tr(),
            controller: locationController,
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 25.sp,
            ),
            read: true,
            onTap: () async {
              String? value = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    backgroundColor: AppColors.borderColor,
                    title: AppText(
                      text: LocaleKeys.chooseCity.tr(),
                      size: 21.sp,
                    ),
                    // children: AppCubit.get(context).citiesList.map(
                    //   (value) {
                    //     return SimpleDialogOption(
                    //       onPressed: () {
                    //         AuthCubit.get(context).cityId =
                    //             value.id.toString();
                    //         Navigator.pop(context, value.title);
                    //       },
                    //       child: AppText(
                    //         text: value.title,
                    //         size: 18.sp,
                    //         color: AppColors.primary,
                    //       ),
                    //     );
                    //   },
                    // ).toList(),
                  );
                },
              );
              if (value != null) {
                // locationController.text = value;
              }
            },
            validate: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.cityValidation.tr();
              } else {
                return null;
              }
            },
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
              size: 25.sp,
            ),
          ),
          AppText(
            start: 38.w,
            bottom: 8.h,
            text: LocaleKeys.password.tr(),
            color: Colors.black,
            fontWeight: FontWeight.w400,
            size: 14.sp,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AppInput(
                enabledBorderColor: Colors.grey,
                filled: true,
                bottom: 16.h,
                hint: LocaleKeys.password.tr(),
                controller: passController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.passwordValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 25.sp,
                ),
                secureText: AuthCubit.get(context).isSecureRegister1,
                suffixIcon: AuthCubit.get(context).isSecureRegister1
                    ? InkWell(
                        onTap: () {
                          AuthCubit.get(context).isSecureRegisterIcon1(false);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                            size: 21.sp,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          AuthCubit.get(context).isSecureRegisterIcon1(true);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Icon(
                            Icons.visibility,
                            color: Colors.grey,
                            size: 21.sp,
                          ),
                        ),
                      ),
              );
            },
          ),
          AppText(
            start: 38.w,
            bottom: 8.h,
            text: LocaleKeys.confirmPassword.tr(),
            color: Colors.black,
            fontWeight: FontWeight.w400,
            size: 14.sp,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AppInput(
                enabledBorderColor: Colors.grey,
                filled: true,
                hint: LocaleKeys.confirmPassword.tr(),
                controller: confirmPassController,
                validate: (value) {
                  if (passController.text != confirmPassController.text) {
                    return LocaleKeys.passwordDoesNotMatch.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 25.sp,
                ),
                secureText: AuthCubit.get(context).isSecureRegister2,
                suffixIcon: AuthCubit.get(context).isSecureRegister2
                    ? InkWell(
                        onTap: () {
                          AuthCubit.get(context).isSecureRegisterIcon2(false);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                            size: 21.sp,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          AuthCubit.get(context).isSecureRegisterIcon2(true);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Icon(
                            Icons.visibility,
                            color: Colors.grey,
                            size: 21.sp,
                          ),
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
