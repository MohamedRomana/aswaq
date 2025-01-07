import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/screens/users/notifications/notifications.dart';
import 'package:aswaq/screens/users/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';

class CustomMoreProfileRow extends StatelessWidget {
  const CustomMoreProfileRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h, bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const Profile());
            },
            child: Row(
              children: [
                Container(
                  height: 36.w,
                  width: 36.w,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.svg.user,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                AppText(
                  text: 'محمد أحمد',
                  size: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              AppRouter.navigateTo(context, const Notifications());
            },
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 16.w),
              child: SvgPicture.asset(
                Assets.svg.notificationBing,
                height: 24.w,
                width: 24.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
