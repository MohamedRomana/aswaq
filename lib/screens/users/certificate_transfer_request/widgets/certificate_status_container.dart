import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CertificateStatusContainer extends StatelessWidget {
  const CertificateStatusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 253.h,
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.all(16.r),
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
                text: LocaleKeys.beneficiary_name.tr(),
                size: 14.sp,
                color: Colors.black,
              ),
              SizedBox(
                width: 150.w,
                child: AppText(
                  textAlign: TextAlign.end,
                  text: 'محمد احمد محمد',
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
                  text: '0596204587',
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
                text: LocaleKeys.phone.tr(),
                size: 14.sp,
                color: Colors.black,
              ),
              SizedBox(
                width: 150.w,
                child: AppText(
                  textAlign: TextAlign.end,
                  text: '548755455',
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
                text: LocaleKeys.identity_number.tr(),
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
