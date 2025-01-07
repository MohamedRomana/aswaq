import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/Certificates/certificates.dart';
import 'package:aswaq/screens/users/chats/chats_list.dart';
import 'package:aswaq/screens/users/order_returns/order_returns.dart';
import 'package:aswaq/screens/users/orders/orders.dart';
import 'package:aswaq/screens/users/profile_edit/profile_edit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          text: LocaleKeys.profile.tr(),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const ProfileEdit());
            },
            child: Container(
              height: 101.h,
              width: 343.w,
              padding: EdgeInsets.all(16.r),
              margin: EdgeInsetsDirectional.only(
                start: 16.w,
                end: 16.w,
                bottom: 16.h,
              ),
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
              child: Row(
                children: [
                  Image.asset('assets/img/Ellipse 234.png'),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: AppText(
                              text: 'محمد احمد على',
                              size: 14.sp,
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.svg.edit,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      AppText(
                        text: '0596207234',
                        color: Colors.grey,
                        size: 12.sp,
                      ),
                      AppText(
                        text: 'الرياض - حي الصحافة',
                        color: Colors.grey,
                        size: 12.sp,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const ChatsList());
            },
            child: Container(
              height: 50.h,
              width: 343.w,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.all(13.r),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.messages,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6.w),
                      AppText(
                        text: LocaleKeys.chats.tr(),
                        size: 14.sp,
                        color: const Color(0xff4E4E4E),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                    color: const Color(0xff4E4E4E),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const Orders());
            },
            child: Container(
              height: 50.h,
              width: 343.w,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.all(13.r),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.text,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6.w),
                      AppText(
                        text: LocaleKeys.orders.tr(),
                        size: 14.sp,
                        color: const Color(0xff4E4E4E),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                    color: const Color(0xff4E4E4E),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const Certificates());
            },
            child: Container(
              height: 50.h,
              width: 343.w,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.all(13.r),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.star,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6.w),
                      AppText(
                        text: LocaleKeys.certificates.tr(),
                        size: 14.sp,
                        color: const Color(0xff4E4E4E),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                    color: const Color(0xff4E4E4E),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const OrderReturns());
            },
            child: Container(
              height: 50.h,
              width: 343.w,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.all(13.r),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.import,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6.w),
                      AppText(
                        text: LocaleKeys.order_returns.tr(),
                        size: 14.sp,
                        color: const Color(0xff4E4E4E),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                    color: const Color(0xff4E4E4E),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
