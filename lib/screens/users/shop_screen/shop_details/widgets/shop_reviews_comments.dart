import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class ShopReviewsComments extends StatefulWidget {
  const ShopReviewsComments({super.key});

  @override
  State<ShopReviewsComments> createState() => _ShopReviewsCommentsState();
}

class _ShopReviewsCommentsState extends State<ShopReviewsComments> {
  int visibleComment = 2;
  @override
  Widget build(BuildContext context) {
    final rates = List<Map<String, dynamic>>.from(
      AppCubit.get(context).showProviderModel['rates'] ?? [],
    ).reversed.toList();

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return rates.isEmpty
            ? SizedBox(
                width: 343.w,
                child: AppText(
                  textAlign: TextAlign.center,
                  text: LocaleKeys.rates_empty.tr(),
                  color: AppColors.primary,
                  family: FontFamily.norsalBold,
                  fontStyle: FontStyle.italic,
                ),
              )
            : Column(
                children: [
                  ListView.separated(
                    padding:
                        EdgeInsetsDirectional.only(start: 16.w, bottom: 20.h),
                    itemCount: visibleComment < rates.length
                        ? visibleComment
                        : rates.length,
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
                                image: rates[index]['user_avatar'] ?? "",
                                height: 30.w,
                                width: 30.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            RatingBar.readOnly(
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              initialRating: double.parse(rates[index]['rate']),
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
                            text: rates[index]['desc'] ?? "",
                            lines: 3,
                            size: 12.sp,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (rates.length > visibleComment)
                    InkWell(
                      onTap: () {
                        setState(() {
                          visibleComment += 3;
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
