// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomOrderContentListView extends StatelessWidget {
  const CustomOrderContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.all(16.r),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: AppCubit.get(context).showitems.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 16.h),
          itemBuilder: (context, index) => Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(16.r),
            width: 343.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.r,
                  spreadRadius: 1.r,
                  color: Colors.grey.withOpacity(0.5.r),
                  offset: Offset(0, 5.r),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 90.h,
                  width: 82.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.r,
                        spreadRadius: 1.r,
                        color: Colors.grey.withOpacity(0.7.r),
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: AppCachedImage(
                      image: AppCubit.get(context).showitems[index]
                              ['service_first_image'] ??
                          "",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 11.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: AppText(
                              text: AppCubit.get(context).showitems[index]
                                      ['service_title'] ??
                                  "",
                              lines: 2,
                              size: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // InkWell(
                          //   splashColor: Colors.transparent,
                          //   highlightColor: Colors.transparent,
                          //   onTap: () {
                          //     AppCubit.get(context).deleteOrders(
                          //       orderId: AppCubit.get(context)
                          //               .showOrdersModel
                          //               ?.items[index]
                          //               .id
                          //               .toString() ??
                          //           "",
                          //       index: index,
                          //     );
                          //   },
                          //   child: SvgPicture.asset(
                          //     Assets.svg.trash,
                          //     height: 24.w,
                          //     width: 24.w,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        width: 200.w,
                        child: AppText(
                          top: 6.h,
                          text: AppCubit.get(context).showitems[index]
                                  ['service_section_title'] ??
                              "",
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: AppText(
                          top: 22.h,
                          text:
                              '${AppCubit.get(context).showitems[index]['service_price'].toStringAsFixed(1) ?? ""}  ${LocaleKeys.sar.tr()}',
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
