import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/contsants.dart';
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
                offset: const Offset(0, 0),
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
                      bottom:
                          AppCubit.get(context).showOrdersModel['address'] == ''
                              ? 0
                              : 19.h,
                      text: AppCubit.get(context).showOrdersModel['name'] ?? "",
                      color: Colors.grey,
                      size: 12.sp,
                    ),
                  ),
                ],
              ),
              AppCubit.get(context).showOrdersModel['address'] == ''
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        AppText(
                          top: 15.h,
                          text: LocaleKeys.address.tr(),
                          color: AppColors.primary,
                          size: 14.sp,
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 300.w,
                          child: AppText(
                            bottom: 19.h,
                            text: AppCubit.get(context)
                                    .showOrdersModel['address'] ??
                                "",
                            color: Colors.grey,
                            size: 12.sp,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            openGoogleMap(
                              AppCubit.get(context).showOrdersModel['lat'],
                              AppCubit.get(context).showOrdersModel['lng'],
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_location,
                                color: AppColors.primary,
                                size: 21.sp,
                              ),
                              AppText(
                                text: LocaleKeys.deliveryAddress.tr(),
                                color: AppColors.primary,
                                size: 14.sp,
                              ),
                            ],
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
