// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../generated/locale_keys.g.dart';

class CustomCertificatePrice extends StatelessWidget {
  const CustomCertificatePrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
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
                  text:
                      '${AppCubit.get(context).cerPrice} ${LocaleKeys.sar.tr()}',
                  size: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
