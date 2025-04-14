import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../data/auth_cubit.dart';

class CustomLoginFields extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController passController;
  final GlobalKey<FormState> formKey;

  const CustomLoginFields({
    super.key,
    required this.phoneController,
    required this.passController,
    required this.formKey,
  });

  @override
  State<CustomLoginFields> createState() => _CustomLoginFieldsState();
}

class _CustomLoginFieldsState extends State<CustomLoginFields> {
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() => setState(() {}));
    passFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppText(
              bottom: 31.h,
              text: LocaleKeys.login.tr(),
              size: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppText(
            start: 32.w,
            bottom: 8.h,
            text: LocaleKeys.phone.tr(),
            color: Colors.black,
            size: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          AppInput(
            focusNode: phoneFocusNode,
            bottom: 16.h,
            filled: true,
            enabledBorderColor: Colors.grey,
            hint: LocaleKeys.phone.tr(),
            color: Colors.white,
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
                      phoneFocusNode.hasFocus ? AppColors.primary : Colors.grey,
                ),
              ),
            ),
          ),
          AppText(
            start: 32.w,
            bottom: 8.h,
            text: LocaleKeys.password.tr(),
            color: Colors.black,
            size: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return AppInput(
                focusNode: passFocusNode,
                enabledBorderColor: Colors.grey,
                filled: true,
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
                      color: passFocusNode.hasFocus
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                  ),
                ),
                secureText: AuthCubit.get(context).isSecureLogIn,
                suffixIcon: AuthCubit.get(context).isSecureLogIn
                    ? InkWell(
                        onTap: () {
                          AuthCubit.get(context).isSecureLogInIcon(false);
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
                          AuthCubit.get(context).isSecureLogInIcon(true);
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
  }
}
