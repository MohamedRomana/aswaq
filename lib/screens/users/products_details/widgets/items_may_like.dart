import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';
import '../products_details.dart';

class ItemsMayLike extends StatefulWidget {
  const ItemsMayLike({super.key});

  @override
  State<ItemsMayLike> createState() => _ItemsMayLikeState();
}

class _ItemsMayLikeState extends State<ItemsMayLike> {
  @override
  void initState() {
    AppCubit.get(context).services();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AppCubit.get(context)
                .showServiceModel['related_services']
                .isEmpty
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: LocaleKeys.items_you_may_also_like.tr(),
                    size: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsetsDirectional.only(
                        start: 10.w, end: 10.w, top: 15.h, bottom: 5.h),
                    itemCount: AppCubit.get(context)
                        .showServiceModel['related_services']
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: Platform.isIOS ? 0.55.h : 0.7.h,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppRouter.navigateTo(
                          context,
                          ProductDetailsBottomSheet(
                            id: AppCubit.get(context)
                                    .showServiceModel['related_services'][index]
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
                                    offset: Offset(0, 5.r))
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: AppCachedImage(
                                image: AppCubit.get(context).showServiceModel[
                                            'related_services'][index]
                                        ['first_image'] ??
                                    '',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              AppText(
                                top: 8.h,
                                text: AppCubit.get(context).showServiceModel[
                                        'related_services'][index]['title'] ??
                                    '',
                                size: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              AppCubit.get(context).showServiceModel[
                                              'related_services'][index]
                                          ['discount'] ==
                                      0
                                  ? AppText(
                                      text:
                                          "${AppCubit.get(context).showServiceModel['related_services'][index]['price'].toString()} ${LocaleKeys.sar.tr()}",
                                      size: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : SizedBox(
                                      width: 150.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AppText(
                                            text:
                                                "${AppCubit.get(context).showServiceModel['related_services'][index]['discount'].toString()} ${LocaleKeys.sar.tr()}",
                                            size: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          AppText(
                                            start: 10.w,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            text:
                                                "${AppCubit.get(context).showServiceModel['related_services'][index]['price'].toString()} ${LocaleKeys.sar.tr()}",
                                            size: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ],
              );
      },
    );
  }
}
