// ignore_for_file: deprecated_member_use
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class CustomChatWithContainer extends StatelessWidget {
  const CustomChatWithContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsetsDirectional.only(
        top: 16.h,
        start: 16.w,
        end: 16.w,
        bottom: 21.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(15.r),
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
          SvgPicture.asset(
            Assets.svg.profilecircle,
            color: AppColors.primary,
            height: 40.w,
            width: 40.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 6.w),
          AppText(
            text: LocaleKeys.chat_with.tr(),
            size: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
