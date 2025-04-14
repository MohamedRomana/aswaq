import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../data/auth_cubit.dart';

class CustomUserRegisterFields extends StatefulWidget {
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
  State<CustomUserRegisterFields> createState() =>
      _CustomUserRegisterFieldsState();
}

class _CustomUserRegisterFieldsState extends State<CustomUserRegisterFields> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() => setState(() {}));
    phoneFocus.addListener(() => setState(() {}));
    cityFocus.addListener(() => setState(() {}));
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocus.dispose();
    phoneFocus.dispose();
    cityFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 26.h,
                  bottom: 31.h,
                  text: LocaleKeys.new_registration.tr(),
                  size: 24.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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
                focusNode: nameFocus,
                enabledBorderColor: Colors.grey,
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.fullName.tr(),
                controller: widget.fullNameController,
                inputType: TextInputType.name,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.usernameValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    Assets.svg.person,
                    color: nameFocus.hasFocus ? AppColors.primary : Colors.grey,
                  ),
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
                focusNode: phoneFocus,
                enabledBorderColor: Colors.grey,
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.phone.tr(),
                controller: widget.phoneController,
                inputType: TextInputType.phone,
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.phoneValidate.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: SizedBox(
                  height: 28.w,
                  width: 28.w,
                  child: Center(
                    child: SvgPicture.asset(
                      height: 28.w,
                      width: 28.w,
                      Assets.svg.call,
                      color:
                          phoneFocus.hasFocus ? AppColors.primary : Colors.grey,
                    ),
                  ),
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
                focusNode: cityFocus,
                enabledBorderColor: Colors.grey,
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.chooseCity.tr(),
                controller: widget.locationController,
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
                        children: AppCubit.get(context).citiesList.map(
                          (value) {
                            return SimpleDialogOption(
                              onPressed: () {
                                AuthCubit.get(context).cityId =
                                    value['id'].toString();
                                Navigator.pop(context, value['title']);
                              },
                              child: AppText(
                                text: value['title'] ?? "",
                                size: 18.sp,
                                color: AppColors.primary,
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  );
                  if (value != null) {
                    widget.locationController.text = value;
                  }
                },
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.cityValidation.tr();
                  } else {
                    return null;
                  }
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    Assets.svg.location,
                    color: cityFocus.hasFocus ? AppColors.primary : Colors.grey,
                  ),
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
                    focusNode: passFocus,
                    enabledBorderColor: Colors.grey,
                    filled: true,
                    bottom: 16.h,
                    hint: LocaleKeys.password.tr(),
                    controller: widget.passController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.passwordValidate.tr();
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.key,
                          height: 28.w,
                          width: 28.w,
                          color: passFocus.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                      ),
                    ),
                    secureText: AuthCubit.get(context).isSecureRegister1,
                    suffixIcon: AuthCubit.get(context).isSecureRegister1
                        ? InkWell(
                            onTap: () {
                              AuthCubit.get(context)
                                  .isSecureRegisterIcon1(false);
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
                              AuthCubit.get(context)
                                  .isSecureRegisterIcon1(true);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Icon(
                                Icons.visibility,
                                color: AppColors.primary,
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
                    focusNode: confirmPassFocus,
                    enabledBorderColor: Colors.grey,
                    filled: true,
                    hint: LocaleKeys.confirmPassword.tr(),
                    controller: widget.confirmPassController,
                    validate: (value) {
                      if (widget.passController.text !=
                          widget.confirmPassController.text) {
                        return LocaleKeys.passwordDoesNotMatch.tr();
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: SizedBox(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.key,
                          height: 28.w,
                          width: 28.w,
                          color: confirmPassFocus.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                      ),
                    ),
                    secureText: AuthCubit.get(context).isSecureRegister2,
                    suffixIcon: AuthCubit.get(context).isSecureRegister2
                        ? InkWell(
                            onTap: () {
                              AuthCubit.get(context)
                                  .isSecureRegisterIcon2(false);
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
                              AuthCubit.get(context)
                                  .isSecureRegisterIcon2(true);
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(8.h),
                              child: Icon(
                                Icons.visibility,
                                color: AppColors.primary,
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
      },
    );
  }
}
