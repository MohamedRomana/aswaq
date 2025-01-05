import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomDeletFavContainer extends StatelessWidget {
  const CustomDeletFavContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192.h,
      width: 311.w,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          AppText(
            bottom: 25.h,
            text: LocaleKeys.delete_product_confirmation.tr(),
            size: 18.sp,
            family: Assets.fonts.norsalBold,
          ),
          AppButton(
            onPressed: () {},
            radius: 10.r,
            child: AppText(
              text: LocaleKeys.confirm_deletion.tr(),
              size: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          AppButton(
            top: 16.h,
            onPressed: () {},
            color: Colors.white,
            borderColor: AppColors.primary,
            radius: 10.r,
            child: AppText(
              text: LocaleKeys.cancel_deletion.tr(),
              color: AppColors.primary,
              size: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
