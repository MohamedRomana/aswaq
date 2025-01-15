import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'custom_product_details.dart';

class CustomProductsGridView extends StatelessWidget {
  const CustomProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (context) => const ProductDetailsBottomSheet(),
        );
      },
      child: Container(
        height: 210.h,
        width: 165.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.r,
              spreadRadius: 1.r,
              color: Colors.grey,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 150.w,
                  child: AppText(
                    textAlign: TextAlign.start,
                    start: 10.w,
                    top: 10.h,
                    text: 'اسم المنتج',
                    size: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: AppText(
                    textAlign: TextAlign.start,
                    start: 10.w,
                    top: 3.h,
                    text: 'اسم القسم',
                    color: AppColors.primary,
                    size: 9.sp,
                  ),
                ),
              ],
            ),
            Image.asset(
              Assets.img.wash.path,
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 37.h,
                  width: 39.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(10.r),
                      topEnd: Radius.circular(10.r),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.svg.bagTick,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: AppText(
                    end: 10.w,
                    textAlign: TextAlign.end,
                    text: '150 ${LocaleKeys.sar.tr()}',
                    size: 12.sp,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
