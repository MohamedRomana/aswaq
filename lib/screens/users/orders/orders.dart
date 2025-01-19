// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/orders_details/orders_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: LocaleKeys.orders.tr(),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsetsDirectional.only(
          top: 10.h,
          bottom: 140.h,
          start: 16.w,
          end: 16.w,
        ),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            AppRouter.navigateTo(context, const OrdersDetails());
          },
          child: Container(
            width: 343.w,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(16.r),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: '${LocaleKeys.orderNumber.tr()}  ',
                          size: 14.sp,
                        ),
                        SizedBox(
                          width: 110.w,
                          child: AppText(
                            text: '#15446464',
                            color: AppColors.primary,
                            size: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 150.w,
                      child: AppText(
                        text: 'الخميس12 مارس 2023',
                        color: Colors.grey,
                        size: 12.sp,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: AppText(
                          textAlign: TextAlign.end,
                          text: 'منذ 15 دقيقة',
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      height: 35.h,
                      width: 93.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 93.w,
                          child: AppText(
                            textAlign: TextAlign.center,
                            text: 'تم قبول الطلب',
                            size: 12.sp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
