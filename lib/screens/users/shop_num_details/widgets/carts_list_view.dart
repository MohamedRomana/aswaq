import 'package:aswaq/core/widgets/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_cached.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CartsListView extends StatelessWidget {
  const CartsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is CartItemsFailure) {
          AppCubit.get(context).showCart();
          AppRouter.pop(context);
        }
      },
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.only(
            top: 16.h,
            bottom: 24.h,
            start: 16.w,
            end: 16.w,
          ),
          itemCount:
              AppCubit.get(context).cartItemsModel?.cartItems.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(
            height: 16.h,
          ),
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
                  color: Colors.grey,
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
                        color: Colors.grey,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: AppCachedImage(
                      image: AppCubit.get(context)
                          .cartItemsModel!
                          .cartItems[index]
                          .serviceFirstImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 11.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110.w,
                        child: AppText(
                          text: AppCubit.get(context)
                              .cartItemsModel!
                              .cartItems[index]
                              .serviceTitle,
                          size: 16.sp,
                          lines: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 110.w,
                        child: AppText(
                          top: 6.h,
                          text: AppCubit.get(context)
                              .cartItemsModel!
                              .cartItems[index]
                              .serviceSectionTitle,
                          size: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 110.w,
                        child: AppText(
                          top: 22.h,
                          text:
                              '${AppCubit.get(context).cartItemsModel!.cartItems[index].servicePrice}  ${LocaleKeys.sar.tr()}',
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).updateCartIndex(index: index);
                        AppCubit.get(context).updateCart(
                          cartItemId: AppCubit.get(context)
                              .cartItemsModel!
                              .cartItems[index]
                              .id
                              .toString(),
                          cartId: AppCubit.get(context)
                              .cartItemsModel!
                              .id
                              .toString(),
                          count: '0',
                        );
                      },
                      child: SvgPicture.asset(
                        Assets.svg.trash,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 41.h),
                    Row(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).updateCartIndex(index: index);
                            AppCubit.get(context).updateCart(
                              cartItemId: AppCubit.get(context)
                                  .cartItemsModel!
                                  .cartItems[index]
                                  .id
                                  .toString(),
                              cartId: AppCubit.get(context)
                                  .cartItemsModel!
                                  .id
                                  .toString(),
                              count: (AppCubit.get(context)
                                          .cartItemsModel!
                                          .cartItems[index]
                                          .count +
                                      1)
                                  .toString(),
                            );
                          },
                          child: Container(
                            height: 25.w,
                            width: 25.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                          child: AppText(
                            // start: 10.w,
                            // end: 10.w,
                            textAlign: TextAlign.center,
                            text: AppCubit.get(context)
                                .cartItemsModel!
                                .cartItems[index]
                                .count
                                .toString(),
                            size: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).updateCartIndex(index: index);
                            AppCubit.get(context).updateCart(
                              cartItemId: AppCubit.get(context)
                                  .cartItemsModel!
                                  .cartItems[index]
                                  .id
                                  .toString(),
                              cartId: AppCubit.get(context)
                                  .cartItemsModel!
                                  .id
                                  .toString(),
                              count: (AppCubit.get(context)
                                          .cartItemsModel!
                                          .cartItems[index]
                                          .count -
                                      1)
                                  .toString(),
                            );
                          },
                          child: Container(
                            height: 25.w,
                            width: 25.w,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
