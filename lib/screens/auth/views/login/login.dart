import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../users/home_layout/home_layout.dart';
import '../../data/auth_cubit.dart';
import '../forget_pass/forget_pass.dart';
import '../register/register.dart';
import '../widgets/auth_header.dart';
import 'widgets/login_fields.dart';

final _formKey = GlobalKey<FormState>();
final _phoneController = TextEditingController();
final _passController = TextEditingController();
String phoneCode = "";

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const CustomAuthHeader(),
            CustomLoginFields(
              formKey: _formKey,
              phoneController: _phoneController,
              passController: _passController,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LogInSuccess) {
                  // AppCubit.get(context).changebottomNavIndex(0);
                  // AppRouter.navigateAndFinish(
                  //     context,
                  //     CacheHelper.getUserType() == "client"
                  //         ? const HomeLayout()
                  //         : const ProviderHomeLayout());
                  _phoneController.clear();
                  _passController.clear();
                  showFlashMessage(
                    context: context,
                    type: FlashMessageType.success,
                    message: LocaleKeys.welcome_dear_customer.tr(),
                  );
                } else if (state is LogInFailure) {
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
                  bottom: 40.h,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await AuthCubit.get(context).logIn(
                        phone: _phoneController.text,
                        password: _passController.text,
                      );
                    }
                  },
                  child: state is LogInLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : AppText(
                          text: LocaleKeys.signin.tr(),
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
                  text: LocaleKeys.dontHaveAccount.tr(),
                  size: 14.sp,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, const Register());
                  },
                  child: AppText(
                    text: LocaleKeys.newUser.tr(),
                    size: 14.sp,
                    color: AppColors.darkRed,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () =>
                  AppRouter.navigateTo(context, const ForgetPass()),
              child: AppText(
                text: LocaleKeys.forgetPass.tr(),
                size: 14.sp,
                color: AppColors.darkRed,
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changebottomNavIndex(2);
                AppRouter.navigateTo(context, const HomeLayout());
              },
              child: SizedBox(
                height: 20.h,
                width: 150.w,
                child: Center(
                  child: AppText(
                    text: LocaleKeys.skip.tr(),
                    size: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
