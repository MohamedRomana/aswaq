import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class ProductTitlePrice extends StatelessWidget {
  const ProductTitlePrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 343.w,
                  child: Row(
                    children: [
                      AppText(
                        textAlign: TextAlign.start,
                        text:
                            '${AppCubit.get(context).showServiceModel['price']} ${LocaleKeys.sar.tr()}',
                        color: AppColors.primary,
                        size: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      AppText(
                        textAlign: TextAlign.start,
                        start: 5.w,
                        decoration: TextDecoration.lineThrough,
                        text:
                            '${AppCubit.get(context).showServiceModel['price']} ${LocaleKeys.sar.tr()}',
                        color: Colors.grey,
                        size: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      AppText(
                        textAlign: TextAlign.start,
                        start: 5.w,
                        text:
                            '${LocaleKeys.discount.tr()} 50%',
                        color: Colors.red,
                        size: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 343.w,
                  child: AppText(
                    top: 10.h,
                    textAlign: TextAlign.start,
                    text: AppCubit.get(context).showServiceModel['title'],
                    size: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 343.w,
                  child: AppText(
                    textAlign: TextAlign.start,
                    top: 5.h,
                    bottom: 16.h,
                    text:
                        AppCubit.get(context).showServiceModel['section_title'],
                    size: 16.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
