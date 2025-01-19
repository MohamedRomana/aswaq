import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../home_layout/home_layout.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _messageController = TextEditingController();

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: CustomBottomNav(
            key: scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: CustomAppBar(
                text: LocaleKeys.contactUs.tr(),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 45.h),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.img.logo.path,
                      color: AppColors.primary,
                      height: 105.h,
                      width: 240.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: AppText(
                        text: LocaleKeys.name.tr(),
                        bottom: 10.h,
                      ),
                    ),
                    AppInput(
                      filled: true,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: Colors.grey,
                      hint: LocaleKeys.fullName.tr(),
                      start: 0,
                      end: 0,
                      controller: _nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.nameValidate.tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: AppText(
                        text: LocaleKeys.phone.tr(),
                        bottom: 10.h,
                        top: 15.h,
                      ),
                    ),
                    AppInput(
                      filled: true,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: Colors.grey,
                      hint: LocaleKeys.phone.tr(),
                      start: 0,
                      end: 0,
                      controller: _phoneController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.phoneValidate.tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: AppText(
                        text: LocaleKeys.yourMessage.tr(),
                        bottom: 10.h,
                        top: 15.h,
                      ),
                    ),
                    AppInput(
                        filled: true,
                        color: const Color(0xffFBFBFB),
                        enabledBorderColor: Colors.grey,
                        focusedBorderColor: Colors.grey,
                        hint: LocaleKeys.yourMessage.tr(),
                        maxLines: 5,
                        start: 0,
                        end: 0,
                        controller: _messageController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.yourMessage.tr();
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: 32.h),
                    BlocConsumer<AppCubit, AppState>(
                      listener: (context, state) {
                        if (state is ContactUsSuccess) {
                          AppCubit.get(context).changebottomNavIndex(2);
                          AppRouter.navigateAndFinish(
                              context, const HomeLayout());
                          _nameController.clear();
                          _phoneController.clear();
                          _messageController.clear();
                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is ContactUsFailure) {
                          showFlashMessage(
                            message: state.error,
                            type: FlashMessageType.error,
                            context: context,
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await AppCubit.get(context).contactUs(
                                name: _nameController.text,
                                phone: _phoneController.text,
                                message: _messageController.text,
                              );
                            }
                          },
                          width: 343.w,
                          child: state is ContactUsLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : AppText(
                                  text: LocaleKeys.send.tr(),
                                  color: Colors.white,
                                ),
                        );
                      },
                    ),
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
