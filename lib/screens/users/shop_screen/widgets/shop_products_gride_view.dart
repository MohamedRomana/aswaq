import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'custom_product_details.dart';
import 'custom_shop_details.dart';

class ShopProductsGrideView extends StatelessWidget {
  const ShopProductsGrideView({
    super.key,
    required this.title2,
  });

  final List title2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: title2.length,
      child: Column(
        children: [
          const CustomShopDetails(),
          Container(
            margin: EdgeInsetsDirectional.only(
              start: 13.w,
              bottom: 16.h,
              top: 30.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: TabBar(
              onTap: (index) {},
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              splashBorderRadius: BorderRadius.circular(5.r),
              dividerColor: Colors.transparent,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16.sp),
              tabs: List.generate(
                title2.length,
                (index) => Tab(
                  text: title2[index],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(
                title2.length,
                (index) => GridView.builder(
                  padding: EdgeInsetsDirectional.only(
                      top: 10.h, start: 10.w, end: 10.w, bottom: 150.h),
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 210,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          builder: (context) =>
                              const ProductDetailsBottomSheet(),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
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
                                  offset: Offset(0, 5.r),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              Assets.img.wash.path,
                            ),
                          ),
                          PositionedDirectional(
                            top: 11.h,
                            start: 16.w,
                            child: Column(
                              children: [
                                AppText(
                                  start: 10.w,
                                  text: 'اسم المنتج',
                                  size: 11.sp,
                                  family: Assets.fonts.norsalBold,
                                ),
                                AppText(
                                  top: 5.h,
                                  text: 'اسم القسم',
                                  color: AppColors.primary,
                                  size: 9.sp,
                                ),
                              ],
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 3.h,
                            start: 0,
                            child: Row(
                              children: [
                                Container(
                                  height: 37.h,
                                  width: 39.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadiusDirectional.only(
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
                            child: AppText(
                              text: '175 ${LocaleKeys.sar.tr()}',
                              size: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
