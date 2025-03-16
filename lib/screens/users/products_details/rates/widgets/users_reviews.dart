import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersReviews extends StatelessWidget {
  const UsersReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.only(bottom: 20.h),
          itemCount: AppCubit.get(context).showServiceModel['rates'].length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) => Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000.r),
                    child: AppCachedImage(
                      image: AppCubit.get(context).showServiceModel['rates']
                              [index]['user_avatar'] ??
                          "",
                      height: 30.w,
                      width: 30.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    initialRating: double.parse(AppCubit.get(context)
                        .showServiceModel['rates'][index]['rate']),
                    maxRating: 5,
                    isHalfAllowed: true,
                    halfFilledIcon: Icons.star_half,
                    size: 18.sp,
                  ),
                ],
              ),
              SizedBox(
                width: 300.w,
                child: AppText(
                  top: 6.h,
                  text: AppCubit.get(context).showServiceModel['rates'][index]
                          ['desc'] ??
                      "",
                  lines: 3,
                  size: 12.sp,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
