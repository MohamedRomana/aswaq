import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/screens/users/home_layout/products_details/products_details.dart';
import 'package:aswaq/screens/users/shop_screen/shop_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/locale_keys.g.dart';

class ProductStore extends StatelessWidget {
  const ProductStore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(height: 6.h),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000.r),
                  child: AppCachedImage(
                    image:
                        AppCubit.get(context).showServiceModel['saler_avatar'],
                    height: 50.w,
                    width: 50.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 7.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text:
                          AppCubit.get(context).showServiceModel['saler_name'],
                      size: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        AppText(
                          text: LocaleKeys.rate.tr(),
                          size: 12.sp,
                          color: Colors.grey,
                        ),
                        AppText(
                          start: 5.w,
                          text: AppCubit.get(context)
                              .showServiceModel['saler_rate']
                              .toString(),
                          size: 12.sp,
                          color: Colors.black,
                        ),
                        Icon(
                          Icons.star,
                          size: 16.sp,
                          color: Colors.amber,
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
                      AppRouter.navigateTo(
                        context,
                        ShopScreen(
                          id: AppCubit.get(context)
                              .showServiceModel['saler_id'],
                        ),
                      );
                    },
                    width: 100.w,
                    child: AppText(
                      text: LocaleKeys.visit_store.tr(),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 400.h,
              child: GridView.builder(
                padding: EdgeInsetsDirectional.only(
                    start: 10.w, end: 10.w, top: 15.h, bottom: 5.h),
                scrollDirection: Axis.horizontal,
                itemCount: AppCubit.get(context).providerServicesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 1.7.h,
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
                        height: 130.h,
                        width: 130.w,
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
                            image: AppCubit.get(context)
                                .providerServicesList[index]['first_image'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          AppText(
                            top: 8.h,
                            text: AppCubit.get(context)
                                .providerServicesList[index]['title'],
                            size: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            text:
                                "${AppCubit.get(context).providerServicesList[index]['price'].toString()} ${LocaleKeys.sar.tr()}",
                            size: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
