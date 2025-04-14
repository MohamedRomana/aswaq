// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_login_first.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/favorite_service.dart';
import 'widgets/favorite_stores.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: LocaleKeys.favorites.tr(),
              isHomeLayout: true,
            ),
          ),
          body: CacheHelper.getUserId() == ""
              ? const CustomLoginFirst()
              : DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(
                          start: 5.w,
                          end: 5.w,
                          bottom: 16.h,
                          top: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(50),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: TabBar(
                          splashBorderRadius: BorderRadius.circular(25.r),
                          indicatorColor: AppColors.primary,
                          labelColor: Colors.white,
                          labelStyle: const TextStyle(
                            fontFamily: FontFamily.norsalBold,
                          ),
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(25.r)),
                          tabs: [
                            Tab(text: LocaleKeys.stores.tr()),
                            Tab(text: LocaleKeys.products.tr()),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            FavoriteStores(),
                            FavoriteServices(),
                          ],
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
