// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class PaymentChoiceContainer extends StatelessWidget {
  const PaymentChoiceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
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
                            text: LocaleKeys.bank_transfer.tr(),
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
        );
      },
    );
  }
}
