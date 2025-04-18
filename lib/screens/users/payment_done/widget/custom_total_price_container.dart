// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CusomTotalPriceContainer extends StatelessWidget {
  

  const CusomTotalPriceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 343.w,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 16.w),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5.r,
                spreadRadius: 1.r,
                offset: Offset(0, 5.r),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: LocaleKeys.total_value.tr(),
                    size: 14.sp,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text: '${AppCubit.get(context).cartItemsModel['total'].toStringAsFixed(1) ?? ""} ${LocaleKeys.sar.tr()}',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
              //   child: Divider(
              //     thickness: 1,
              //     color: AppColors.primary.withOpacity(0.4),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     AppText(
              //       text: LocaleKeys.discount_coupon.tr(),
              //       size: 14.sp,
              //     ),
              //     SizedBox(
              //       width: 150.w,
              //       child: AppText(
              //         textAlign: TextAlign.end,
              //         text: '- 250 ${LocaleKeys.sar.tr()}',
              //         size: 14.sp,
              //         color: AppColors.primary,
              //       ),
              //     ),
              //   ],
              // ),

              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
                child: Divider(
                  thickness: 1,
                  color: AppColors.primary.withOpacity(0.4),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: LocaleKeys.total.tr(),
                    size: 14.sp,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text:
                          '${AppCubit.get(context).cartItemsModel['total_with_value'].toStringAsFixed(1) ?? ""} ${LocaleKeys.sar.tr()}',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppText(
          bottom: 31.h,
          text: LocaleKeys.inclusive_of_vat.tr(),
          size: 14.sp,
        )
      ],
    );
  }
}
