import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../products_details/products_details.dart';

class StoreProducts extends StatelessWidget {
  const StoreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: LocaleKeys.products.tr(),
              size: 20.sp,
              fontWeight: FontWeight.bold,
              start: 16.w,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(
                  start: 10.w, end: 10.w, top: 15.h, bottom: 5.h),
              itemCount: AppCubit.get(context).providerServicesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: Platform.isIOS ? 0.6.h : 0.7.h,
              ),
              itemBuilder: (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppRouter.navigateTo(
                    context,
                    ProductDetailsBottomSheet(
                      id: AppCubit.get(context).providerServicesList[index]
                          ['id'],
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 180.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5.r,
                            spreadRadius: 1.r,
                            offset: Offset(0, 5.r),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: AppCachedImage(
                          image: AppCubit.get(context)
                                  .providerServicesList[index]['first_image'] ??
                              "",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        AppText(
                          top: 8.h,
                          text: AppCubit.get(context)
                                  .providerServicesList[index]['title'] ??
                              "",
                          size: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        AppCubit.get(context).providerServicesList[index]
                                    ['discount'] ==
                                0
                            ? AppText(
                                text:
                                    "${AppCubit.get(context).providerServicesList[index]['price'].toString()} ${LocaleKeys.sar.tr()}",
                                size: 12.sp,
                                fontWeight: FontWeight.bold,
                              )
                            : SizedBox(
                                width: 150.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      end: 5.w,
                                      text:
                                          "${AppCubit.get(context).providerServicesList[index]['discount'].toString()} ${LocaleKeys.sar.tr()}",
                                      size: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    AppText(
                                      text:
                                          " ${AppCubit.get(context).providerServicesList[index]['price'].toString()} ${LocaleKeys.sar.tr()}",
                                      size: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    )
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
