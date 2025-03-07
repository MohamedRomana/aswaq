// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/map/map.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomShippingMethod extends StatelessWidget {
  const CustomShippingMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              top: 15.h,
              bottom: 15.h,
              text: LocaleKeys.shipping_method.tr(),
              size: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (AppCubit.get(context).shipIndex == 0) {
                  AppCubit.get(context).changeShipIndex(index: -1);
                } else {
                  AppCubit.get(context).changeShipIndex(index: 0);
                }
              },
              child: Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.trak,
                          height: 24.w,
                          width: 24.w,
                          color: AppCubit.get(context).shipIndex == 0
                              ? AppColors.primary
                              : Colors.grey,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 6.w),
                        AppText(
                          text: LocaleKeys.ship_to_my_location.tr(),
                          size: 16.sp,
                          color: AppCubit.get(context).shipIndex == 0
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(
                          text:
                              '${AppCubit.get(context).cartItemsModel['delivery']} ${LocaleKeys.sar.tr()}',
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          height: 22.w,
                          width: 22.w,
                          decoration: BoxDecoration(
                            color: AppCubit.get(context).shipIndex == 0
                                ? AppColors.primary
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.done,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (AppCubit.get(context).shipIndex == 1) {
                  AppCubit.get(context).changeShipIndex(index: -1);
                } else {
                  AppCubit.get(context).changeShipIndex(index: 1);
                  customBottomSheet(
                    context: context,
                    enableDrag: false,
                    isDismissible: false,
                    child: const MapScreen(),
                  );
                }
              },
              child: Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
                margin: EdgeInsets.symmetric(vertical: 16.h),
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
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.svg.trak,
                              height: 24.w,
                              width: 24.w,
                              color: AppCubit.get(context).shipIndex == 1
                                  ? AppColors.primary
                                  : Colors.grey,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 6.w),
                            AppText(
                              text: LocaleKeys.ship_to_another_location.tr(),
                              size: 16.sp,
                              color: AppCubit.get(context).shipIndex == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ],
                        ),
                        Container(
                          height: 22.w,
                          width: 22.w,
                          decoration: BoxDecoration(
                            color: AppCubit.get(context).shipIndex == 1
                                ? AppColors.primary
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.done,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (AppCubit.get(context).shipIndex == 1) {
                          customBottomSheet(
                            context: context,
                            enableDrag: false,
                            isDismissible: false,
                            child: const MapScreen(),
                          );
                        } else {
                          const SizedBox.shrink();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: LocaleKeys.set_location_on_map.tr(),
                            size: 16.sp,
                            color: AppCubit.get(context).shipIndex == 1
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                          SvgPicture.asset(
                            Assets.svg.map,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                            color: AppCubit.get(context).shipIndex == 1
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
