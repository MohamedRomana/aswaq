// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/screens/users/shop_num_details/shop_num_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class ShoppingCarts extends StatelessWidget {
  const ShoppingCarts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: CustomAppBar(
          isHomeLayout: true,
          text: LocaleKeys.shopping_carts.tr(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsetsDirectional.only(
          top: 16.w,
          start: 16.w,
          end: 16.w,
          bottom: 140.h,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(
          height: 16.h,
        ),
        itemBuilder: (context, index) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            AppRouter.navigateTo(context, const ShopNumDetails());
          },
          child: Container(
            height: 96.h,
            width: 343.w,
            padding: EdgeInsets.all(16.r),
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
                  height: 64.w,
                  width: 64.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.svg.bagTick,
                      color: AppColors.primary,
                      height: 33.w,
                      width: 33.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 8.w),
                  child: SizedBox(
                    width: 230.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 170.w,
                              child: const AppText(
                                text: 'محل رقم 1',
                                size: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              Assets.svg.trash,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: SizedBox(
                                width: 80.w,
                                child: const AppText(
                                  text: 'اجمالي السلة',
                                  color: Colors.grey,
                                  size: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 110.w,
                              child: AppText(
                                textAlign: TextAlign.end,
                                text: '‏1705 ${LocaleKeys.sar.tr()}',
                                size: 14.sp,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
