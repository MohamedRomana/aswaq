// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/screens/users/home_layout/favorites/widgets/custom_empty_fav.dart';
import 'package:aswaq/screens/users/shop_num_details/shop_num_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class ShoppingCarts extends StatefulWidget {
  const ShoppingCarts({super.key});

  @override
  State<ShoppingCarts> createState() => _ShoppingCartsState();
}

class _ShoppingCartsState extends State<ShoppingCarts> {
  @override
  void initState() {
    AppCubit.get(context).showCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              isHomeLayout: true,
              text: LocaleKeys.shopping_carts.tr(),
            ),
          ),
          body: state is ShowCartLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
              : AppCubit.get(context).cartList.isEmpty
                  ? const CustomEmptyFav(isCart: true)
                  : ListView.separated(
                      padding: EdgeInsetsDirectional.only(
                        top: 16.w,
                        start: 16.w,
                        end: 16.w,
                        bottom: 140.h,
                      ),
                      itemCount: AppCubit.get(context).cartList.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 16.h,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                            context,
                            ShopNumDetails(
                              id: AppCubit.get(context).cartList[index].id,
                            ),
                          );
                        },
                        child: Container(
                          height: 96.h,
                          width: 343.w,
                          padding: EdgeInsets.all(16.r),
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
                                height: 64.w,
                                width: 64.w,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.primary),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    Assets.svg.bagTick,
                                    color: AppColors.primary,
                                    height: 33.w,
                                    width: 33.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 8.w),
                                child: SizedBox(
                                  width: 230.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 170.w,
                                            child: AppText(
                                              text: AppCubit.get(context)
                                                  .cartList[index]
                                                  .salerName,
                                              size: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              AppCubit.get(context).deleteCart(
                                                cartId: AppCubit.get(context)
                                                    .cartList[index]
                                                    .id
                                                    .toString(),
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              Assets.svg.trash,
                                              height: 24.w,
                                              width: 24.w,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 18.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 100.w,
                                            child: SizedBox(
                                              width: 80.w,
                                              child: AppText(
                                                text:
                                                    LocaleKeys.total_cart.tr(),
                                                color: Colors.grey,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 110.w,
                                            child: AppText(
                                              textAlign: TextAlign.end,
                                              text:
                                                  '${AppCubit.get(context).cartList[index].totalWithValue} ${LocaleKeys.sar.tr()}',
                                              size: 14.sp,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
