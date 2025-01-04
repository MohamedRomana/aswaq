import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class PaymentLocatContaine extends StatelessWidget {
  const PaymentLocatContaine({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          margin: EdgeInsets.symmetric(vertical: 18.h),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (AppCubit.get(context).paymentlocatIndex == 0) {
                    AppCubit.get(context).changePaymentlocatIndex(index: -1);
                  } else {
                    AppCubit.get(context).changePaymentlocatIndex(index: 0);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: LocaleKeys.order_shipping.tr(),
                      size: 14.sp,
                      color: AppCubit.get(context).paymentlocatIndex == 0
                          ? Colors.black
                          : Colors.grey,
                    ),
                    Container(
                      height: 22.w,
                      width: 22.w,
                      decoration: BoxDecoration(
                        color: AppCubit.get(context).paymentlocatIndex == 0
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Divider(
                  thickness: 1,
                  color: AppColors.primary,
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (AppCubit.get(context).paymentlocatIndex == 1) {
                    AppCubit.get(context).changePaymentlocatIndex(index: -1);
                  } else {
                    AppCubit.get(context).changePaymentlocatIndex(index: 1);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: LocaleKeys.pickup_from_site.tr(),
                      size: 14.sp,
                      color: AppCubit.get(context).paymentlocatIndex == 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                    Container(
                      height: 22.w,
                      width: 22.w,
                      decoration: BoxDecoration(
                        color: AppCubit.get(context).paymentlocatIndex == 1
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
            ],
          ),
        );
      },
    );
  }
}
