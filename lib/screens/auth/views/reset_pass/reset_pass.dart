import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../gen/assets.gen.dart';
import '../../data/auth_cubit.dart';
import '../widgets/auth_header.dart';

final _formKey = GlobalKey<FormState>();
final _passController = TextEditingController();
final _confirmPassController = TextEditingController();

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    passFocus.addListener(() => setState(() {}));
    confirmPassFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    passFocus.dispose();
    confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String otpCode = "";
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomAuthHeader(),
              AppText(
                text: LocaleKeys.enterActivationCode.tr(),
                top: 26.h,
                color: const Color(0xff00818A),
                bottom: 27.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  cursorColor: AppColors.primary,
                  textStyle: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontFamily: FontFamily.norsalBold,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10.r),
                    fieldHeight: 60.h,
                    fieldWidth: 60.h,
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    activeFillColor: AppColors.primary,
                    selectedColor: AppColors.primary,
                    selectedFillColor: Colors.transparent,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (code) {
                    otpCode = code;
                    debugPrint("Completed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                ),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        start: 44.w,
                        bottom: 8.h,
                        top: 20.h,
                        text: LocaleKeys.password.tr(),
                        size: 14.sp,
                      ),
                      AppInput(
                        focusNode: passFocus,
                        filled: true,
                        bottom: 16.h,
                        hint: LocaleKeys.password.tr(),
                        controller: _passController,
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
                        secureText: AuthCubit.get(context).isSecureNewPass1,
                        suffixIcon: AuthCubit.get(context).isSecureNewPass1
                            ? InkWell(
                                onTap: () {
                                  AuthCubit.get(context)
                                      .isSecureNewPassIcon1(false);
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
                                      .isSecureNewPassIcon1(true);
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
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        start: 44.w,
                        bottom: 8.h,
                        text: LocaleKeys.confirmPassword.tr(),
                        size: 14.sp,
                      ),
                      AppInput(
                        focusNode: confirmPassFocus,
                        filled: true,
                        hint: LocaleKeys.confirmPassword.tr(),
                        controller: _confirmPassController,
                        validate: (value) {
                          if (_passController.text !=
                              _confirmPassController.text) {
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
                        secureText: AuthCubit.get(context).isSecureNewPass2,
                        suffixIcon: AuthCubit.get(context).isSecureNewPass2
                            ? InkWell(
                                onTap: () {
                                  AuthCubit.get(context)
                                      .isSecureNewPassIcon2(false);
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
                                      .isSecureNewPassIcon2(true);
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
                      ),
                    ],
                  );
                },
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ResetPassFailure) {
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.error,
                      message: state.error,
                    );
                  } else if (state is ResetPassSuccess) {
                    Navigator.pop(context);
                    _passController.clear();
                    _confirmPassController.clear();
                    otpCode = "";
                    AuthCubit.get(context).resetPassId = "";
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.success,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    top: 32.h,
                    bottom: 29.h,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthCubit.get(context).resetPass(
                          code: otpCode,
                          password: _passController.text,
                        );
                      }
                    },
                    child: state is ResetPassLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : AppText(
                            text: LocaleKeys.confirm.tr(),
                            color: Colors.white,
                            family: FontFamily.norsalBold,
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
