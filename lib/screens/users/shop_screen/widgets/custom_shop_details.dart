// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/flash_message.dart';
import 'package:aswaq/screens/users/shop_screen/shop_details/shop_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_login_dialog.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomShopDetails extends StatelessWidget {
  const CustomShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    num rate = AppCubit.get(context).showProviderModel['rate'];
    num rateCount = AppCubit.get(context).showProviderModel['rate_count'];
    num percentage = (rate * rateCount) / (5 * rateCount) * 100;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AddFavoriteSuccess) {
          showFlashMessage(
            message: state.message,
            type: FlashMessageType.success,
            context: context,
          );
        } else if (state is AddFavoriteFailure) {
          showFlashMessage(
            message: state.error,
            type: FlashMessageType.success,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Color.fromARGB(255, 219, 218, 218),
              ],
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 16.w,
              top: 20.h,
              bottom: 30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000.r),
                      child: AppCachedImage(
                        image:
                            AppCubit.get(context).showProviderModel['avatar'],
                        height: 50.w,
                        width: 50.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppCubit.get(context)
                                  .showProviderModel['first_name'] ??
                              '',
                          color: Colors.black,
                          size: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.svg.location,
                              color: AppColors.primary,
                              height: 20.h,
                              width: 20.w,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 3.w),
                            AppText(
                              text:
                                  '${LocaleKeys.distanceFromYou.tr()} ${AppCubit.get(context).showProviderModel['distance']} ${LocaleKeys.km.tr()}',
                              size: 10.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 35.h,
                      child: AppButton(
                        onPressed: () {
                          if (CacheHelper.getUserId() == "") {
                            customAlertDialog(
                              dialogBackGroundColor: Colors.white,
                              context: context,
                              child: const CustomLoginDialog(),
                            );
                          } else {
                            AppCubit.get(context).addFavorite(
                                providerId: AppCubit.get(context)
                                    .showProviderModel['id']
                                    .toString());
                          }
                        },
                        elevation: WidgetStateProperty.all(5.r),
                        shadowColor: WidgetStateProperty.all(Colors.black),
                        width: 100.w,
                        color: Colors.red,
                        child: AppText(
                          text: '+ ${LocaleKeys.favorite.tr()}',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(context, const ShopDetails());
                  },
                  child: Container(
                    width: 343.w,
                    padding: EdgeInsets.all(10.r),
                    margin: EdgeInsets.only(top: 10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.sp,
                                    color: const Color(0xffE5BB45),
                                  ),
                                  SizedBox(width: 3.w),
                                  AppText(
                                    text: double.parse(AppCubit.get(context)
                                            .showProviderModel['rate']
                                            .toString())
                                        .toStringAsFixed(1),
                                    size: 16.sp,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              AppText(
                                textAlign: TextAlign.center,
                                text: LocaleKeys.store_rating.tr(),
                                size: 12.sp,
                                color: Colors.black,
                                lines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    text: '${percentage.toStringAsFixed(1)}%',
                                    size: 16.sp,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              AppText(
                                textAlign: TextAlign.center,
                                text: LocaleKeys.customer_reviews.tr(),
                                size: 12.sp,
                                color: Colors.black,
                                lines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText(
                                    text:
                                        "${((percentage / 100) * 5).toStringAsFixed(1)}/5",
                                    size: 16.sp,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              AppText(
                                textAlign: TextAlign.center,
                                text: LocaleKeys.store_category.tr(),
                                size: 12.sp,
                                color: Colors.black,
                                lines: 2,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15.sp,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
