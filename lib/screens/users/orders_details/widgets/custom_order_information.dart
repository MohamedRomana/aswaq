import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomOrderInformation extends StatelessWidget {
  const CustomOrderInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          width: 343.w,
          margin: EdgeInsets.only(top: 16.h, bottom: 21.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.fullName.tr(),
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 300.w,
                    child: AppText(
                      text: AppCubit.get(context).showOrdersModel?.name ?? "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.neighborhood_or_street_name.tr(),
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 300.w,
                    child: AppText(
                      text: AppCubit.get(context).showOrdersModel?.street ?? "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.landmarks_near_area.tr(),
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 300.w,
                    child: AppText(
                      text:
                          AppCubit.get(context).showOrdersModel?.neighborhood ??
                              "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.city.tr(),
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 300.w,
                    child: AppText(
                      text: AppCubit.get(context).showOrdersModel?.city ?? "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.region_or_governorate.tr(),
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 300.w,
                    child: AppText(
                      text: AppCubit.get(context).showOrdersModel?.highlights ??
                          "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 19.h),
                child: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.country.tr(),
                    color: AppColors.primary,
                    size: 14.sp,
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 300.w,
                    child: AppText(
                      text:
                          AppCubit.get(context).showOrdersModel?.country ?? "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
