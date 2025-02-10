import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../core/constants/colors.dart';
import '../../../data/auth_cubit.dart';

class CustomLoginFields extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppText(
              top: 26.h,
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
              bottom: 16.h,
              filled: true,
              enabledBorderColor: Colors.grey,
              hint: LocaleKeys.phone.tr(),
              color: Colors.white,
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
                Icons.phone_outlined,
                size: 24.sp,
                color: Colors.grey,
              )),
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
                enabledBorderColor: Colors.grey,
                filled: true,
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
