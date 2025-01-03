import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/shop_products_gride_view.dart';

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
        preferredSize: Size.fromHeight(100.h),
        child: CustomAppBar(
          isSearch: true,
          text: LocaleKeys.shop_page.tr(),
        ),
      ),
      body: ShopProductsGrideView(title2: title2),
    );
  }
}
