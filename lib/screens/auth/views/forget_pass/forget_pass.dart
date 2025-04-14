import 'package:aswaq/core/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../gen/assets.gen.dart';
import '../../data/auth_cubit.dart';
import '../reset_pass/reset_pass.dart';
import '../widgets/auth_header.dart';

final _formKey = GlobalKey<FormState>();
final _phoneController = TextEditingController();
String forgetPassPhoneCode = "";

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final FocusNode phoneFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomAuthHeader(),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 26.h,
                  text: LocaleKeys.phone.tr(),
                  size: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AppText(
                  top: 14.h,
                  text: LocaleKeys.enterMobileNumberToSendActivationCode.tr(),
                  color: Colors.grey,
                  size: 14.sp,
                ),
              ),
              AppInput(
                focusNode: phoneFocusNode,
                top: 27.h,
                bottom: 24.h,
                filled: true,
                enabledBorderColor: Colors.grey,
                hint: LocaleKeys.phone.tr(),
                controller: _phoneController,
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
                      color: phoneFocusNode.hasFocus
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ForgetPassFailure) {
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.error,
                      message: state.error,
                    );
                  } else if (state is ForgetPassSuccess) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPass()));
                    _phoneController.clear();
                    showFlashMessage(
                      context: context,
                      type: FlashMessageType.success,
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: AppButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          AuthCubit.get(context).forgetPass(
                            phone: _phoneController.text,
                          );
                        }
                      },
                      child: state is ForgetPassLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : AppText(
                              text: LocaleKeys.confirm.tr(),
                              color: Colors.white,
                              family: FontFamily.norsalBold,
                            ),
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
