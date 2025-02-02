import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_input.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_cached.dart';
import '../../../gen/assets.gen.dart';
import '../shop_screen/widgets/custom_product_details.dart';

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
        preferredSize: Size.fromHeight(80.h),
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
              Center(
                child: AppButton(
                  onPressed: () {},
                  bottom: 20.h,
                  child: AppText(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    text: LocaleKeys.search.tr(),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.only(
                  top: 10.h,
                  start: 10.w,
                  end: 10.w,
                  bottom: 150.h,
                ),
                itemCount: 12,
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
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) => const ProductDetailsBottomSheet(id: 0,),
                      );
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
                                  text: 'اسم المنتج',
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
                                  text: 'اسم القسم',
                                  color: AppColors.primary,
                                  size: 9.sp,
                                ),
                              ),
                            ],
                          ),
                          const AppCachedImage(
                            image: '',
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              SizedBox(
                                width: 100.w,
                                child: AppText(
                                  end: 10.w,
                                  textAlign: TextAlign.end,
                                  text: '150 ${LocaleKeys.sar.tr()}',
                                  size: 12.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
