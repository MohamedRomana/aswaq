// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../shop_screen/widgets/custom_product_details.dart';

class BestProductsListView extends StatelessWidget {
  const BestProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              start: 22.w,
              bottom: 11.h,
              text: LocaleKeys.best_products.tr(),
              size: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 248.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount:
                    AppCubit.get(context).clientHomeModel?.services.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(width: 13.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      builder: (context) => ProductDetailsBottomSheet(
                        id: AppCubit.get(context)
                            .clientHomeModel!
                            .services[index]
                            .id,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 210.h,
                          width: 165.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: AppCachedImage(
                            image: AppCubit.get(context)
                                    .clientHomeModel
                                    ?.services[index]
                                    .firstImage ??
                                "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 210.h,
                          width: 165.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Stack(
                            children: [
                              PositionedDirectional(
                                top: 11.h,
                                start: 16.w,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: AppText(
                                        textAlign: TextAlign.start,
                                        start: 10.w,
                                        text: AppCubit.get(context)
                                                .clientHomeModel
                                                ?.services[index]
                                                .title ??
                                            "",
                                        color: Colors.white,
                                        size: 11.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150.w,
                                      child: AppText(
                                        textAlign: TextAlign.start,
                                        top: 5.h,
                                        text: AppCubit.get(context)
                                                .clientHomeModel
                                                ?.services[index]
                                                .sectionTitle ??
                                            "",
                                        color: AppColors.primary,
                                        size: 9.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PositionedDirectional(
                                bottom: 0,
                                start: 0,
                                child: Row(
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
                                  ],
                                ),
                              ),
                              PositionedDirectional(
                                bottom: 12.h,
                                end: 13.w,
                                child: SizedBox(
                                  width: 150.w,
                                  child: AppText(
                                    textAlign: TextAlign.end,
                                    text:
                                        '${AppCubit.get(context).clientHomeModel?.services[index].price} ${LocaleKeys.sar.tr()}',
                                    size: 12.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
