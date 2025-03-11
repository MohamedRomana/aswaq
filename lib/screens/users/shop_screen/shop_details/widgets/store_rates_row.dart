import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class StoreRatesRow extends StatelessWidget {
  const StoreRatesRow({super.key});

  @override
  Widget build(BuildContext context) {
    double value = 1.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 15.h,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
          color: Colors.grey.withOpacity(0.2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                AppText(
                  start: 16.w,
                  bottom: 10.h,
                  text: LocaleKeys.store_category.tr(),
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  width: 100.w,
                  child: AppText(
                    start: 16.w,
                    text: '4.5',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AppText(
                  start: 16.w,
                  bottom: 10.h,
                  text: LocaleKeys.customer_reviews.tr(),
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  width: 100.w,
                  child: AppText(
                    start: 16.w,
                    text: '45 %',
                    size: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 15.h,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
          color: Colors.grey.withOpacity(0.2),
        ),
        AppText(
          start: 16.w,
          bottom: 10.h,
          text: LocaleKeys.store_rating.tr(),
          size: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        Center(
          child: RatingBar.builder(
            initialRating: 1,
            allowHalfRating: true,
            minRating: 1,
            itemCount: 5,
            itemSize: 30.sp,
            direction: Axis.horizontal,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              value = rating;
              debugPrint(value.toString());
            },
          ),
        ),
        SizedBox(height: 20.h),
        Divider(
          color: Colors.black,
          indent: 20.w,
          endIndent: 20.w,
        ),
      ],
    );
  }
}
