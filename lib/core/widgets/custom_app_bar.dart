// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/screens/users/search/search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../../screens/users/home_layout/markets/widgets/filter_bottom_sheet.dart';
import '../service/cubit/app_cubit.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget {
  final bool? isHome;
  final bool? isMarket;
  final bool? isSearch;
  final bool? isHomeLayout;
  final String? text;
  final bool? isStore;
  final bool? isProduct;

  const CustomAppBar({
    super.key,
    this.isHome = false,
    this.isMarket = false,
    this.isHomeLayout = false,
    this.text,
    this.isSearch = false,
    this.isStore = false,
    this.isProduct = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          // height: 90.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          margin: EdgeInsets.only(bottom: isStore! || isProduct! ? 0.h : 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:
                    isHome! || isProduct! ? Colors.transparent : Colors.grey.withOpacity(0.3),
                blurRadius: 5.r,
                spreadRadius: 1.r,
                offset: Offset(0, 3.r),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isMarket!) ...{
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
                                return const FilterBottomSheet();
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
      },
    );
  }
}
