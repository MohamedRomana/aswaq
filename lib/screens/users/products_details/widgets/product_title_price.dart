import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class ProductTitlePrice extends StatelessWidget {
  const ProductTitlePrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCubit.get(context).showServiceModel['discount'] == 0
                    ? SizedBox(
                        width: 343.w,
                        child: AppText(
                          textAlign: TextAlign.start,
                          text:
                              '${AppCubit.get(context).showServiceModel['price'] ?? ""} ${LocaleKeys.sar.tr()}',
                          color: AppColors.primary,
                          size: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(
                        width: 343.w,
                        child: Row(
                          children: [
                            AppText(
                              textAlign: TextAlign.start,
                              text:
                                  '${AppCubit.get(context).showServiceModel['discount'] ?? ""} ${LocaleKeys.sar.tr()}',
                              color: AppColors.primary,
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            AppText(
                              textAlign: TextAlign.start,
                              start: 5.w,
                              decoration: TextDecoration.lineThrough,
                              text:
                                  '${AppCubit.get(context).showServiceModel['price'] ?? ""} ${LocaleKeys.sar.tr()}',
                              color: Colors.grey,
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            AppText(
                              textAlign: TextAlign.start,
                              start: 5.w,
                              text:
                                  '${LocaleKeys.discount.tr()} ${AppCubit.get(context).showServiceModel['discount_percent']}%',
                              color: Colors.red,
                              size: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  width: 343.w,
                  child: AppText(
                    top: 10.h,
                    textAlign: TextAlign.start,
                    text: AppCubit.get(context).showServiceModel['title'] ?? "",
                    size: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 343.w,
                  child: AppText(
                    textAlign: TextAlign.start,
                    top: 5.h,
                    bottom: 16.h,
                    text: AppCubit.get(context)
                            .showServiceModel['section_title'] ??
                        "",
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: AppCubit.get(context)
                          .showServiceModel['rate_avg']
                          .toDouble(),
                      maxRating: 5,
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      size: 18.sp,
                    ),
                    AppText(
                      start: 5.w,
                      text: double.parse(AppCubit.get(context)
                              .showServiceModel['rate_avg']
                              .toString())
                          .toStringAsFixed(1),
                      size: 12.sp,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ],
        );
      },
    );
  }
}
