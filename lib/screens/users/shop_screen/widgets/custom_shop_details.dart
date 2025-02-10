// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'shop_location.dart';

class CustomShopDetails extends StatelessWidget {
  const CustomShopDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppCubit.get(context).showProviderModel?.firstName ?? '',
                size: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svg.location,
                    height: 24.w,
                    width: 24.w,
                    fit: BoxFit.cover,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 3.w),
                  AppText(
                    text:
                        '${LocaleKeys.distanceFromYou.tr()} ${AppCubit.get(context).showProviderModel?.distance} ${LocaleKeys.km.tr()}',
                    size: 10.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15.sp,
                        color: const Color(0xffE5BB45),
                      ),
                      SizedBox(width: 3.w),
                      AppText(
                        text: AppCubit.get(context)
                                .showProviderModel
                                ?.rate
                                .toString() ??
                            '',
                        size: 14.sp,
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Share.share(
                              "https://www.google.com/maps/search/?api=1&query=${AppCubit.get(context).showProviderModel?.lat},${AppCubit.get(context).showProviderModel?.lng}");
                        },
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.copy,
                              height: 24.w,
                              width: 24.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          customBottomSheet(
                            context: context,
                            enableDrag: false,
                            child: ShopLocation(
                              lat: AppCubit.get(context)
                                      .showProviderModel
                                      ?.lat ??
                                  0,
                              lng: AppCubit.get(context)
                                      .showProviderModel
                                      ?.lng ??
                                  0,
                              address: 'jhg jg k',
                            ),
                          );
                        },
                        child: Container(
                          height: 35.h,
                          width: 93.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.primary, width: 2.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: AppText(
                              text: LocaleKeys.view_on_map.tr(),
                              color: AppColors.primary,
                              size: 10.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
