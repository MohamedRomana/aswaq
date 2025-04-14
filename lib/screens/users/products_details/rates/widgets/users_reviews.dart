import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/gen/fonts.gen.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';

class UsersReviews extends StatefulWidget {
  const UsersReviews({super.key});

  @override
  State<UsersReviews> createState() => _UsersReviewsState();
}

class _UsersReviewsState extends State<UsersReviews> {
  int visibleCount = 2;

  @override
  Widget build(BuildContext context) {
    final ratess = List<Map<String, dynamic>>.from(
      AppCubit.get(context).showServiceModel['rates'] ?? [],
    ).reversed.toList();

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            ListView.separated(
              padding: EdgeInsets.only(bottom: 20.h),
              itemCount:
                  visibleCount < ratess.length ? visibleCount : ratess.length,
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
                          image: ratess[index]['user_avatar'] ?? "",
                          height: 30.w,
                          width: 30.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating:
                            double.parse(ratess[index]['rate'].toString()),
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
                      text: ratess[index]['desc'] ?? "",
                      lines: 3,
                      size: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (visibleCount < ratess.length)
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    visibleCount += 3;
                  });
                },
                child: AppText(
                  text: LocaleKeys.view_more.tr(),
                  color: AppColors.primary,
                  family: FontFamily.norsalBold,
                ),
              ),
          ],
        );
      },
    );
  }
}
