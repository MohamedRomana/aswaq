import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../data/auth_cubit.dart';
import '../otp/otp.dart';
import '../widgets/auth_header.dart';
import 'widgets/fields.dart';

final _formKey = GlobalKey<FormState>();
final _fullNameController = TextEditingController();
final _phoneController = TextEditingController();
final _locationController = TextEditingController();
final _passController = TextEditingController();
final _confirmPassController = TextEditingController();

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const CustomAuthHeader(),
            CustomUserRegisterFields(
              formKey: _formKey,
              phoneController: _phoneController,
              passController: _passController,
              confirmPassController: _confirmPassController,
              fullNameController: _fullNameController,
              locationController: _locationController,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  AppRouter.navigateAndPop(context, const OTPscreen());
                  _fullNameController.clear();
                  _phoneController.clear();
                  _locationController.clear();
                  _passController.clear();
                  _confirmPassController.clear();
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.success,
                    message: state.message,
                  );
                } else if (state is RegisterFailure) {
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.error,
                    message: state.error,
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  top: 24.h,
                  bottom: 29.h,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AuthCubit.get(context).register(
                        fullName: _fullNameController.text,
                        phone: _phoneController.text,
                        password: _passController.text,
                      );
                    }
                  },
                  child: state is RegisterLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : AppText(
                          text: LocaleKeys.signingUp.tr(),
                          color: Colors.white,
                          family: FontFamily.norsalBold,
                        ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: LocaleKeys.alreadyHaveAccount.tr(),
                  size: 14.sp,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () => AppRouter.pop(context),
                  child: AppText(
                    text: LocaleKeys.login.tr(),
                    size: 14.sp,
                    color: AppColors.darkRed,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
