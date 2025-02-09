// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/cache/cache_helper.dart';
import 'package:aswaq/screens/auth/data/auth_cubit.dart';
import 'package:aswaq/screens/start/splash/splash.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/contsants.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/alert_dialog.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../auth/views/login/login.dart';
import 'deleteAccount_dialog.dart';

class CustomChangesAppContainer extends StatefulWidget {
  const CustomChangesAppContainer({super.key});

  @override
  State<CustomChangesAppContainer> createState() =>
      _CustomChangesAppContainerState();
}

class _CustomChangesAppContainerState extends State<CustomChangesAppContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0, 5.r),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.notificationBing,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 6.w),
                  AppText(
                    text: LocaleKeys.notifications.tr(),
                    size: 14.sp,
                    color: const Color(0xff4E4E4E),
                  ),
                ],
              ),
              Transform.scale(
                scale: 0.8.r,
                child: Switch(
                  padding: EdgeInsets.zero,
                  trackOutlineColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  activeColor: AppColors.primary,
                  activeTrackColor: AppColors.primary.withOpacity(0.2),
                  inactiveThumbColor: const Color(0xffB5B2B2),
                  inactiveTrackColor: const Color(0xffDCDCDC),
                  value: AppCubit.get(context).showUserMap['send_notify'],
                  onChanged: (bool value) {
                    setState(
                      () {
                        AppCubit.get(context).showUserMap['send_notify'] =
                            value;
                        AppCubit.get(context).userNotification(
                          sendNotify:
                              AppCubit.get(context).showUserMap['send_notify'],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.global,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 6.w),
                  AppText(
                    text: LocaleKeys.language.tr(),
                    size: 14.sp,
                    color: const Color(0xff4E4E4E),
                  ),
                ],
              ),
              Row(
                children: [
                  AppText(
                    text: CacheHelper.getLang() != "en"
                        ? LocaleKeys.en.tr()
                        : LocaleKeys.ar.tr(),
                    size: 14.sp,
                  ),
                  SizedBox(width: 6.w),
                  Transform.scale(
                    scale: 0.8.r,
                    child: Switch(
                      padding: EdgeInsets.zero,
                      trackOutlineColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      activeColor: AppColors.primary,
                      activeTrackColor: const Color(0xffD4D4D4),
                      inactiveThumbColor: const Color(0xffB5B2B2),
                      inactiveTrackColor: const Color(0xffDCDCDC),
                      value: CacheHelper.getLang() == "en" ? true : false,
                      onChanged: (bool value) {
                        setState(
                          () {
                            AppRouter.navigateAndFinish(
                                context, const Splash());
                            if (CacheHelper.getLang() == "ar") {
                              CacheHelper.setLang('en');
                              context.setLocale(const Locale('en'));
                            } else {
                              CacheHelper.setLang('ar');
                              context.setLocale(const Locale('ar'));
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              launchUrl(Uri.parse(baseUrl));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.share,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      text: LocaleKeys.share_app.tr(),
                      size: 14.sp,
                      color: const Color(0xff4E4E4E),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 24.sp,
                  color: const Color(0xff4E4E4E),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          CacheHelper.getUserId() == ""
              ? InkWell(
                  onTap: () {
                    AppRouter.navigateAndPop(context, const LogIn());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: LocaleKeys.login.tr(),
                        size: 16.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.red,
                        size: 24.sp,
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogOutSuccess) {
                          AppRouter.navigateAndFinish(context, const Splash());
                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is LogOutFailure) {
                          showFlashMessage(
                            message: state.error,
                            type: FlashMessageType.error,
                            context: context,
                          );
                        }
                      },
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: LocaleKeys.logout.tr(),
                            desc: LocaleKeys.logOutSubtitle.tr(),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              AuthCubit.get(context).logOut();
                            },
                          ).show();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svg.output,
                                  height: 24.w,
                                  width: 24.w,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 6.w),
                                AppText(
                                  text: LocaleKeys.logout.tr(),
                                  size: 14.sp,
                                  color: const Color(0xff4E4E4E),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24.sp,
                              color: const Color(0xff4E4E4E),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is DeleteAccountLoading) {
                          showLoadingDialog(context: context, isLottie: true);
                        } else if (state is DeleteAccountSuccess) {
                          AppRouter.navigateAndFinish(context, const Splash());

                          showFlashMessage(
                            message: state.message,
                            type: FlashMessageType.success,
                            context: context,
                          );
                        } else if (state is DeleteAccountFailure) {
                          showFlashMessage(
                            message: state.error,
                            type: FlashMessageType.error,
                            context: context,
                          );
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            customAlertDialog(
                              context: context,
                              child: const DeleteAccountDialog(),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: LocaleKeys.deleteAccount.tr(),
                                color: Colors.red,
                                size: 14.sp,
                              ),
                              SvgPicture.asset(
                                Assets.svg.trash,
                                height: 24.w,
                                width: 24.w,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
