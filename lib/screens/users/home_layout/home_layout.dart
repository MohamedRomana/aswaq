// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/colors.dart';
import '../../../gen/assets.gen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            bool? shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(LocaleKeys.doYouWantToLeaveThisApp.tr()),
                content: Text(LocaleKeys.areYouSure.tr()),
                actions: [
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: Text(LocaleKeys.yes.tr()),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(LocaleKeys.no.tr()),
                  ),
                ],
              ),
            );
            return shouldPop ?? false;
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              height: 73.h,
              padding: EdgeInsets.only(top: 3.h),
              margin: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (AppCubit.get(context).bottomNavIndex == 0) ...{
                    Column(
                      children: [
                        Container(
                          height: 38.w,
                          width: 38.w,
                          decoration: const BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.markets,
                              height: 24.w,
                              width: 24.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AppText(
                          text: LocaleKeys.markets.tr(),
                          color: Colors.black,
                          size: 12.sp,
                        ),
                      ],
                    ),
                  } else ...{
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(0);
                      },
                      child: SizedBox(
                        width: 70.w,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.markets,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  },
                  if (AppCubit.get(context).bottomNavIndex == 1) ...{
                    Column(
                      children: [
                        Container(
                          height: 38.w,
                          width: 38.w,
                          decoration: const BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.favorites,
                              height: 24.w,
                              width: 24.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AppText(
                          text: LocaleKeys.favorites.tr(),
                          color: Colors.black,
                          size: 12.sp,
                        ),
                      ],
                    ),
                  } else ...{
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(1);
                      },
                      child: SizedBox(
                        width: 70.w,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.favorites,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  },
                  if (AppCubit.get(context).bottomNavIndex == 2) ...{
                    Column(
                      children: [
                        Container(
                          height: 38.w,
                          width: 38.w,
                          decoration: const BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.home,
                              height: 24.w,
                              width: 24.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AppText(
                          text: LocaleKeys.home.tr(),
                          color: Colors.black,
                          size: 12.sp,
                        ),
                      ],
                    ),
                  } else ...{
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(2);
                      },
                      child: SizedBox(
                        width: 70.w,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.home,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  },
                  if (AppCubit.get(context).bottomNavIndex == 3) ...{
                    Column(
                      children: [
                        Container(
                          height: 38.w,
                          width: 38.w,
                          decoration: const BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.shoppingcart,
                              height: 24.w,
                              width: 24.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60.w,
                          child: AppText(
                            textAlign: TextAlign.center,
                            lines: 2,
                            text: LocaleKeys.shopping_carts.tr(),
                            color: Colors.black,
                            size: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  } else ...{
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(3);
                      },
                      child: SizedBox(
                        width: 70.w,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.shoppingcart,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  },
                  if (AppCubit.get(context).bottomNavIndex == 4) ...{
                    Column(
                      children: [
                        Container(
                          height: 38.w,
                          width: 38.w,
                          decoration: const BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.more,
                              height: 24.w,
                              width: 24.w,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AppText(
                          text: LocaleKeys.more.tr(),
                          color: Colors.black,
                          size: 12.sp,
                        ),
                      ],
                    ),
                  } else ...{
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(4);
                      },
                      child: SizedBox(
                        width: 70.w,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.more,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  },
                ],
              ),
            ),
            body: AppCubit.get(context)
                .bottomNavScreens[AppCubit.get(context).bottomNavIndex],
          ),
        );
      },
    );
  }
}
