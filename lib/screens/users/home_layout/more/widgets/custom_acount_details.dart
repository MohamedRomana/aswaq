import 'package:aswaq/screens/users/drawer_items/about_us/about_us.dart';
import 'package:aswaq/screens/users/drawer_items/contact_us/contact_us.dart';
import 'package:aswaq/screens/users/drawer_items/faq/faq.dart';
import 'package:aswaq/screens/users/drawer_items/privacy_policy/privacy_policy.dart';
import 'package:aswaq/screens/users/drawer_items/technical_support/technical_support_view.dart';
import 'package:aswaq/screens/users/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomAccountDetails extends StatelessWidget {
  const CustomAccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
          CacheHelper.getUserId() == ""
              ? const SizedBox()
              : InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    CacheHelper.getUserId() == ""
                        ? const SizedBox()
                        : AppRouter.navigateTo(context, const Profile());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.svg.profile,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 6.w),
                          AppText(
                            text: LocaleKeys.profile.tr(),
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
          CacheHelper.getUserId() == ""
              ? const SizedBox()
              : SizedBox(height: 16.h),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const AboutUs());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.people,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      text: LocaleKeys.aboutus.tr(),
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
          SizedBox(height: 16.h),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const ContactUs());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.sms,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      text: LocaleKeys.contactUs.tr(),
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
          SizedBox(height: 16.h),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const TechnicalSupportView());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.book,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      text: LocaleKeys.support_and_complaints.tr(),
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
          SizedBox(height: 16.h),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const PrivacyPolicy());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.task,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      text: LocaleKeys.privacyPolicy.tr(),
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
          SizedBox(height: 16.h),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const Faq());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.menu,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      text: LocaleKeys.frequently_asked_questions.tr(),
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
        ],
      ),
    );
  }
}
