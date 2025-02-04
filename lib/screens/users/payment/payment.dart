// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: LocaleKeys.payment.tr(),
        ),
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                width: 343.w,
                margin: EdgeInsets.all(16.r),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (AppCubit.get(context).paymentIndex == 0) {
                          AppCubit.get(context).changePaymentIndex(index: -1);
                        } else {
                          AppCubit.get(context).changePaymentIndex(index: 0);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svg.iconcard,
                                  height: 18.w,
                                  width: 18.w,
                                  color: AppCubit.get(context).paymentIndex == 0
                                      ? AppColors.primary
                                      : Colors.grey,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 6.w),
                                AppText(
                                  text: LocaleKeys.onlinePayment.tr(),
                                  size: 14.sp,
                                  color: AppCubit.get(context).paymentIndex == 0
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ],
                            ),
                            Container(
                              height: 22.w,
                              width: 22.w,
                              decoration: BoxDecoration(
                                color: AppCubit.get(context).paymentIndex == 0
                                    ? AppColors.primary
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  size: 15.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColors.primary,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (AppCubit.get(context).paymentIndex == 1) {
                          AppCubit.get(context).changePaymentIndex(index: -1);
                        } else {
                          AppCubit.get(context).changePaymentIndex(index: 1);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svg.bank,
                                  height: 24.w,
                                  width: 24.w,
                                  color: AppCubit.get(context).paymentIndex == 1
                                      ? AppColors.primary
                                      : Colors.grey,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 6.w),
                                AppText(
                                  text: 'Cash',
                                  size: 14.sp,
                                  color: AppCubit.get(context).paymentIndex == 1
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ],
                            ),
                            Container(
                              height: 22.w,
                              width: 22.w,
                              decoration: BoxDecoration(
                                color: AppCubit.get(context).paymentIndex == 1
                                    ? AppColors.primary
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  size: 15.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 343.w,
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 16.w),
                margin: EdgeInsets.only(
                  top: 16.h,
                ),
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
                child: Row(
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
                        text: '‏250 ${LocaleKeys.sar.tr()}',
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              AppButton(
                onPressed: () {
                  // AppCubit.get(context).storeCertificatesSections(title: title)
                },
                top: 26.h,
                child: AppText(
                  text: LocaleKeys.payment_confirmation.tr(),
                  size: 16.sp,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
