import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomOrderContentListView extends StatelessWidget {
  const CustomOrderContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 16.h),
      itemBuilder: (context, index) => Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(16.r),
        width: 343.w,
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
        child: Row(
          children: [
            Container(
              height: 90.h,
              width: 82.w,
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
                image: DecorationImage(
                  image: AssetImage(Assets.img.wash.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 11.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: AppText(
                      text: 'اسم المنتج',
                      size: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: AppText(
                      top: 6.h,
                      text: 'اسم القسم',
                      size: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: AppText(
                      top: 22.h,
                      text: '‏175  ${LocaleKeys.sar.tr()}',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                SvgPicture.asset(
                  Assets.svg.trash,
                  height: 24.w,
                  width: 24.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 41.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
