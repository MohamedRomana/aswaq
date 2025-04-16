import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../home_layout/home_layout.dart';

final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _emailController = TextEditingController();
final _messageController = TextEditingController();

class TechnicalSupportView extends StatefulWidget {
  const TechnicalSupportView({super.key});

  @override
  State<TechnicalSupportView> createState() => _TechnicalSupportViewState();
}

class _TechnicalSupportViewState extends State<TechnicalSupportView> {
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    nameFocusNode.addListener(() => setState(() {}));
    phoneFocusNode.addListener(() => setState(() {}));
    emailFocusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ComplaintSuccess) {
          AppCubit.get(context).changebottomNavIndex(2);
          AppRouter.navigateAndFinish(context, const HomeLayout());
          _nameController.clear();
          _phoneController.clear();
          _emailController.clear();
          _messageController.clear();
          showFlashMessage(
            message: state.message,
            type: FlashMessageType.success,
            context: context,
          );
        } else if (state is ComplaintFailure) {
          showFlashMessage(
            message: state.error,
            type: FlashMessageType.error,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: CustomBottomNav(
            key: scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: CustomAppBar(
                text: LocaleKeys.support_and_complaints.tr(),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.img.logo.path,
                      height: 250.w,
                      width: 350.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 343.w,
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: AppCubit.get(context).complaintsTitle,
                        family: FontFamily.norsalBold,
                        color: AppColors.primary,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: AppText(
                        text: LocaleKeys.name.tr(),
                        bottom: 10.h,
                      ),
                    ),
                    AppInput(
                      focusNode: nameFocusNode,
                      filled: true,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(
                          Assets.svg.person,
                          color: nameFocusNode.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                      ),
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
                      focusNode: phoneFocusNode,
                      filled: true,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
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
                      hint: LocaleKeys.phone.tr(),
                      inputType: TextInputType.phone,
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
                        text: LocaleKeys.email.tr(),
                        bottom: 10.h,
                        top: 15.h,
                      ),
                    ),
                    AppInput(
                      focusNode: emailFocusNode,
                      filled: true,
                      color: const Color(0xffFBFBFB),
                      enabledBorderColor: Colors.grey,
                      inputType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(
                          Assets.svg.sms,
                          color: emailFocusNode.hasFocus
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                      ),
                      hint: LocaleKeys.email.tr(),
                      start: 0,
                      end: 0,
                      controller: _emailController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.yourEmailValidate.tr();
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
                    AppButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await AppCubit.get(context).complaints(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            message: _messageController.text,
                            email: _emailController.text,
                          );
                        }
                      },
                      radius: 15.r,
                      width: 343.w,
                      child: state is ComplaintLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : AppText(
                              text: LocaleKeys.send.tr(),
                              color: Colors.white,
                            ),
                    ),
                    AppButton(
                      onPressed: () {
                        openWhatsApp(AppCubit.get(context).whatsApp);
                      },
                      top: 16.h,
                      color: Colors.white,
                      borderColor: AppColors.primary,
                      radius: 15.r,
                      child: const AppText(
                        text: 'تواصل عبر الواتس اب',
                        color: AppColors.primary,
                        family: FontFamily.norsalBold,
                      ),
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
