import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_input.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:aswaq/screens/users/shop_screen/widgets/custom_products_gride_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../gen/assets.gen.dart';

final _searchController = TextEditingController();

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    _searchController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          text: LocaleKeys.search.tr(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                start: 13.w,
                bottom: 16.h,
                text: LocaleKeys.search_term.tr(),
              ),
              AppInput(
                border: 10.r,
                bottom: 16.h,
                filled: true,
                hint: LocaleKeys.enter_search_term.tr(),
                // controller: searchController,
              ),
              AppButton(
                onPressed: () {},
                bottom: 20.h,
                child: AppText(
                  color: Colors.white,
                  family: Assets.fonts.norsalBold,
                  text: LocaleKeys.search.tr(),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.only(
                    top: 10.h, start: 10.w, end: 10.w, bottom: 150.h),
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
            ],
          ),
        ),
      ),
    );
  }
}
