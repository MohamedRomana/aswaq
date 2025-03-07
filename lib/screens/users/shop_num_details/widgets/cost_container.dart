import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CostContainer extends StatelessWidget {
  const CostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.r),
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
            children: [
              Row(
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
                          '${AppCubit.get(context).cartItemsModel['total']}  ${LocaleKeys.sar.tr()}',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: LocaleKeys.total.tr(),
                    size: 14.sp,
                  ),
                  SizedBox(
                    width: 150.w,
                    child: AppText(
                      textAlign: TextAlign.end,
                      text:
                          '${AppCubit.get(context).cartItemsModel['total_with_value']}  ${LocaleKeys.sar.tr()}',
                      size: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
