import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/custom_shop_details.dart';
import 'widgets/custom_shop_shimmer.dart';
import 'widgets/provider_gride_view.dart';

class ShopScreen extends StatefulWidget {
  final int id;
  const ShopScreen({super.key, required this.id});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    AppCubit.get(context).showProvider(providerId: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              isSearch: true,
              text: LocaleKeys.shop_page.tr(),
            ),
          ),
          body: state is ShowProviderLoading &&
                  AppCubit.get(context).showProviderModel == null
              ? const CustomShopShimmer()
              : DefaultTabController(
                  length: AppCubit.get(context).subSections.length,
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
                          onTap: (index) {
                            if (index == 0) {
                              AppCubit.get(context).showProvider(
                                  providerId: widget.id.toString());
                            } else {
                              AppCubit.get(context).allServices(
                                  subsectionId: AppCubit.get(context)
                                      .subSections[index]["id"]
                                      .toString());
                            }
                          },
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
                            AppCubit.get(context).subSections.length,
                            (index) => Tab(
                              text: AppCubit.get(context).subSections[index]
                                      ['title'] ??
                                  "",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            AppCubit.get(context).subSections.length,
                            (index) => const ProviderGrideView(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
