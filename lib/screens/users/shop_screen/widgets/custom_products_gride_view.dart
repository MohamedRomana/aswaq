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
      child: Stack(
        children: [
          Container(
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
                  offset: Offset(0, 5.r),
                ),
              ],
            ),
            child: Image.asset(
              Assets.img.wash.path,
            ),
          ),
          PositionedDirectional(
            top: 11.h,
            start: 16.w,
            child: Column(
              children: [
                AppText(
                  start: 10.w,
                  text: 'اسم المنتج',
                  size: 11.sp,
                  family: Assets.fonts.norsalBold,
                ),
                AppText(
                  top: 5.h,
                  text: 'اسم القسم',
                  color: AppColors.primary,
                  size: 9.sp,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            child: Row(
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
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 12.h,
            end: 13.w,
            child: AppText(
              text: '175 ${LocaleKeys.sar.tr()}',
              size: 12.sp,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
