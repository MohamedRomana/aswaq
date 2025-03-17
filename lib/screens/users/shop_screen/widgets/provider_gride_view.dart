import 'package:aswaq/core/widgets/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../products_details/products_details.dart';
import 'custom_grid_view_load.dart';

class ProviderGrideView extends StatelessWidget {
  const ProviderGrideView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is AllServicesLoading || state is ShowProviderLoading
            ? const CustomGrideViewLoading()
            : AppCubit.get(context).allServiceList.isEmpty
                ? Center(
                    child: AppText(
                      text: LocaleKeys.noServices.tr(),
                      size: 24.sp,
                      color: AppColors.primary,
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsetsDirectional.only(
                      top: 10.h,
                      start: 10.w,
                      end: 10.w,
                      bottom: 150.h,
                    ),
                    itemCount: AppCubit.get(context).allServiceList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 205.h,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                              context,
                              ProductDetailsBottomSheet(
                                id: AppCubit.get(context).allServiceList[index]
                                    ['id'],
                              ));
                        },
                        child: Container(
                          height: 210.h,
                          width: 165.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.r,
                                spreadRadius: 1.r,
                                color: Colors.grey,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: AppText(
                                      textAlign: TextAlign.start,
                                      start: 10.w,
                                      top: 10.h,
                                      text: AppCubit.get(context)
                                          .allServiceList[index]['title'] ?? "",
                                      size: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: AppText(
                                      textAlign: TextAlign.start,
                                      start: 10.w,
                                      top: 3.h,
                                      text: AppCubit.get(context)
                                              .allServiceList[index]
                                          ['section_title'] ?? "",
                                      color: AppColors.primary,
                                      size: 9.sp,
                                    ),
                                  ),
                                ],
                              ),
                              AppCachedImage(
                                image: AppCubit.get(context)
                                        .allServiceList[index]['first_image'] ??
                                    "",
                                fit: BoxFit.fill,
                                height: 120.h,
                                width: 165.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 37.h,
                                    width: 39.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                        bottomStart: Radius.circular(10.r),
                                        topEnd: Radius.circular(10.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Assets.svg.bagTick,
                                        height: 24.h,
                                        width: 24.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  AppCubit.get(context).allServiceList[index]
                                              ['discount'] ==
                                          0
                                      ? SizedBox(
                                          width: 100.w,
                                          child: AppText(
                                            end: 10.w,
                                            textAlign: TextAlign.end,
                                            text:
                                                '${AppCubit.get(context).allServiceList[index]['price']} ${LocaleKeys.sar.tr()}',
                                            size: 12.sp,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : SizedBox(
                                          width: 100.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AppText(
                                                end: 10.w,
                                                text:
                                                    '${AppCubit.get(context).allServiceList[index]['discount']} ${LocaleKeys.sar.tr()}',
                                                size: 12.sp,
                                                color: AppColors.primary,
                                              ),
                                              AppText(
                                                end: 10.w,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                textAlign: TextAlign.end,
                                                text:
                                                    '${AppCubit.get(context).allServiceList[index]['price']} ${LocaleKeys.sar.tr()}',
                                                size: 10.sp,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      },
    );
  }
}
