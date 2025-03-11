import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../gen/assets.gen.dart';

class UsersReviews extends StatelessWidget {
  const UsersReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.only(bottom: 20.h),
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 4.h),
          itemBuilder: (context, index) => Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000.r),
                    child: Image.asset(
                      Assets.img.logo.path,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    initialRating: 4.5,
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
                  text:
                      'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسومهناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم',
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
