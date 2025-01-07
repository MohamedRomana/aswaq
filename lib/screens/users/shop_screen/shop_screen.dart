import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/custom_products_gride_view.dart';
import 'widgets/custom_shop_details.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List title2 = [
      'كل المنتجات',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم',
      'اسم القسم'
    ];
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          isSearch: true,
          text: LocaleKeys.shop_page.tr(),
        ),
      ),
      body: DefaultTabController(
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
                padding: EdgeInsetsDirectional.only(start: -40.w),
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
                      top: 10.h,
                      start: 10.w,
                      end: 10.w,
                      bottom: 150.h,
                    ),
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 210.h,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                    ),
                    itemBuilder: (context, index) {
                      return const CustomProductsGridView();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
