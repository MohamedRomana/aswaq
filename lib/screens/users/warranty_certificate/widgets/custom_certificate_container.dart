import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomCertficateContainer extends StatelessWidget {
  const CustomCertficateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104.h,
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F2),
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
              AppText(
                text: LocaleKeys.warranty_name.tr(),
                size: 14.sp,
                color: Colors.black,
              ),
              SizedBox(
                width: 150.w,
                child: AppText(
                  textAlign: TextAlign.end,
                  text: 'شهادة ضمان',
                  size: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: LocaleKeys.warranty_duration.tr(),
                size: 14.sp,
                color: Colors.black,
              ),
              SizedBox(
                width: 150.w,
                child: AppText(
                  textAlign: TextAlign.end,
                  text: '‏10 سنوات',
                  size: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
