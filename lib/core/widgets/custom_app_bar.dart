import 'package:aswaq/core/widgets/app_router.dart';
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
  final String? text;
  const CustomAppBar({
    super.key,
    this.isHome = false,
    this.isMarket = false,
    this.text,
    this.isSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isHome!) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.search,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
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
            Column(
              children: [
                SizedBox(
                  height: 120.h,
                  width: double.infinity,
                  child: Row(
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
                                      borderRadius:
                                          BorderRadiusDirectional.only(
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
                                          text: LocaleKeys.sortByHighestRating
                                              .tr(),
                                          color: Colors.black,
                                          size: 16.sp,
                                        ),
                                        const Divider(
                                            thickness: 1, color: Colors.grey),
                                        AppText(
                                          text: LocaleKeys
                                              .sort_by_most_requested
                                              .tr(),
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
                          SvgPicture.asset(
                            Assets.svg.search,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          } else ...{
            SizedBox(
              height: 120.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: text!,
                    size: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      if (isSearch!) ...{
                        SvgPicture.asset(
                          Assets.svg.search,
                          height: 24.w,
                          width: 24.w,
                          fit: BoxFit.cover,
                        ),
                      } else ...{
                        const SizedBox.shrink()
                      },
                      SizedBox(width: 6.w),
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
                    ],
                  ),
                ],
              ),
            ),
          }
        ],
      ),
    );
  }
}
