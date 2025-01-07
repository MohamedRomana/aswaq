import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/screens/users/profile/profile.dart';
import 'package:aswaq/screens/users/search/search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../constants/colors.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isHome;
  final bool? isMarket;
  final bool? isSearch;
  final bool? isHomeLayout;
  final String? text;
  const CustomAppBar({
    super.key,
    this.isHome = false,
    this.isMarket = false,
    this.isHomeLayout = false,
    this.text,
    this.isSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: isHome! ? Colors.transparent : Colors.grey.withOpacity(0.5),
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0, 3.r),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isHome!) ...{
            Padding(padding: EdgeInsets.only(top: 50.h)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    AppRouter.navigateTo(context, const Profile());
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 36.w,
                        width: 36.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.svg.user,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Column(
                        children: [
                          AppText(
                            text: LocaleKeys.welcome_dear_customer.tr(),
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          AppText(
                            text: LocaleKeys.thank_you_for_your_preference.tr(),
                            size: 12.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppRouter.navigateTo(context, const Search());
                      },
                      child: SvgPicture.asset(
                        Assets.svg.search,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    SvgPicture.asset(
                      Assets.svg.location,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
              ],
            ),
          } else if (isMarket!) ...{
            Padding(padding: EdgeInsets.only(top: 30.h)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: LocaleKeys.markets_and_shops.tr(),
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 209.h,
                              padding: EdgeInsets.all(28.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(15.r),
                                  topStart: Radius.circular(15.r),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: LocaleKeys.sortByNearest.tr(),
                                    color: Colors.black,
                                    size: 16.sp,
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.grey),
                                  AppText(
                                    text: LocaleKeys.sortByHighestRating.tr(),
                                    color: Colors.black,
                                    size: 16.sp,
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.grey),
                                  AppText(
                                    text:
                                        LocaleKeys.sort_by_most_requested.tr(),
                                    color: Colors.black,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        Assets.svg.filter,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppRouter.navigateTo(context, const Search());
                      },
                      child: SvgPicture.asset(
                        Assets.svg.search,
                        height: 24.w,
                        width: 24.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          } else ...{
            Padding(padding: EdgeInsets.only(top: 30.h)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 260.w,
                  child: AppText(
                    text: text!,
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    if (isSearch!) ...{
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(context, const Search());
                        },
                        child: SvgPicture.asset(
                          Assets.svg.search,
                          height: 24.w,
                          width: 24.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    } else ...{
                      const SizedBox.shrink()
                    },
                    SizedBox(width: 6.w),
                    if (isHomeLayout!) ...{
                      const SizedBox.shrink()
                    } else ...{
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => AppRouter.pop(context),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                          size: 24.sp,
                        ),
                      ),
                    }
                  ],
                ),
              ],
            ),
          }
        ],
      ),
    );
  }
}
