import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class ProductDesc extends StatelessWidget {
  const ProductDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 343.w,
              child: AppText(
                bottom: 7.h,
                text: LocaleKeys.product_description.tr(),
                size: 16.sp,
              ),
            ),
            SizedBox(
              width: 343.w,
              child: AppText(
                bottom: 16.h,
                text: AppCubit.get(context).showServiceModel['desc'] ?? '',
                color: Colors.grey,
                size: 14.sp,
                lines: 3,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppCubit.get(context).serviceImages.length,
              itemBuilder: (context, index) => AppCachedImage(
                height: 230.h,
                width: double.infinity,
                image: AppCubit.get(context).serviceImages[index].image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16.h),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}
