// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/alert_dialog.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_login_dialog.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../shop_screen/shop_screen.dart';

class MarketsAndShopsListView extends StatelessWidget {
  const MarketsAndShopsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              top: 22.h,
              start: 21.w,
              text: LocaleKeys.markets_and_shops.tr(),
              size: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            ListView.separated(
              padding: EdgeInsets.all(16.r),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  AppCubit.get(context).clientHomeModel['providers'].length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(
                      context,
                      ShopScreen(
                        id: AppCubit.get(context).clientHomeModel['providers']
                            [index]['id'],
                      ),
                    );
                  },
                  child: Container(
                    height: 100.h,
                    width: 343.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          offset: Offset(0, 5.r),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: AppCachedImage(
                            image: AppCubit.get(context)
                                        .clientHomeModel['providers'][index]
                                    ['avatar'] ??
                                '',
                            height: 100.h,
                            width: 110.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                SizedBox(
                                  width: 180.w,
                                  child: AppText(
                                    text: AppCubit.get(context)
                                                .clientHomeModel['providers']
                                            [index]['first_name'] ??
                                        '',
                                    color: Colors.black,
                                    size: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                  child: InkWell(
                                    onTap: () {
                                      if (CacheHelper.getUserId() == "") {
                                        customAlertDialog(
                                          dialogBackGroundColor: Colors.white,
                                          context: context,
                                          child: const CustomLoginDialog(),
                                        );
                                      } else {
                                        AppCubit.get(context).addFavorite(
                                          providerId: AppCubit.get(context)
                                              .clientHomeModel['providers']
                                                  [index]['id']
                                              .toString(),
                                        );
                                      }
                                    },
                                    child: Icon(
                                      AppCubit.get(context)
                                                  .clientHomeModel['providers']
                                              [index]['is_user_fav']
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 19.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: const Color(0xffE5BB45),
                                  size: 15.sp,
                                ),
                                SizedBox(width: 3.w),
                                AppText(
                                  text: AppCubit.get(context)
                                      .clientHomeModel['providers'][index]
                                          ['rate']
                                      .toStringAsFixed(1),
                                  size: 14.sp,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.svg.location,
                                  color: AppColors.primary,
                                  height: 15.h,
                                  width: 15.w,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 3.w),
                                SizedBox(
                                  width: 190.w,
                                  child: AppText(
                                    text:
                                        '${LocaleKeys.distanceFromYou.tr()} ${AppCubit.get(context).clientHomeModel['providers'][index]['distance']} ${LocaleKeys.km.tr()}',
                                    color: Colors.grey,
                                    size: 10.sp,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Center(
              child: AppButton(
                bottom: 22.h,
                onPressed: () {
                  AppCubit.get(context).changebottomNavIndex(0);
                },
                color: Colors.white,
                borderColor: AppColors.primary,
                child: AppText(
                  text: LocaleKeys.view_all.tr(),
                  color: AppColors.primary,
                  size: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
