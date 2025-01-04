import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomAddPaymentContainer extends StatelessWidget {
  const CustomAddPaymentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(top: 18.h, bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.r,
            spreadRadius: 1.r,
            color: Colors.grey,
            offset: Offset(0, 5.r),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: LocaleKeys.add_payment_method.tr(),
            size: 14.sp,
            color: Colors.grey,
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Container(
              height: 24.w,
              width: 24.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(color: AppColors.primary),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 15.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
