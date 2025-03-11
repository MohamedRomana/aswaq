import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/alert_dialog.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../../core/widgets/custom_login_dialog.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../widgets/shop_location.dart';

class StoreProfile extends StatelessWidget {
  const StoreProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 150.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey,
                    Color.fromARGB(255, 219, 218, 218),
                  ],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PositionedDirectional(
                    top: 50.h,
                    start: 10.w,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: AppText(
                            text: LocaleKeys.store_information.tr(),
                            color: Colors.black,
                            size: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 130.w),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppRouter.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    top: 110.h,
                    start: 20.w,
                    child: Container(
                      height: 75.w,
                      width: 75.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1.r,
                            blurRadius: 5.r,
                            offset: Offset(1, 3.r),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000.r),
                        child: AppCachedImage(
                          image: AppCubit.get(context)
                                  .showProviderModel['avatar'] ??
                              "",
                          height: 75.w,
                          width: 75.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Row(
              children: [
                AppText(
                  start: 16.w,
                  bottom: 16.h,
                  text: AppCubit.get(context).showProviderModel['first_name'] ??
                      "",
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                SizedBox(
                  height: 35.h,
                  child: AppButton(
                    end: 16.w,
                    onPressed: () {
                      if (CacheHelper.getUserId() == "") {
                        customAlertDialog(
                          dialogBackGroundColor: Colors.white,
                          context: context,
                          child: const CustomLoginDialog(),
                        );
                      } else {
                        AppCubit.get(context).addFavorite(
                            providerId: AppCubit.get(context)
                                .showProviderModel['id']
                                .toString());
                      }
                    },
                    elevation: WidgetStateProperty.all(5.r),
                    shadowColor: WidgetStateProperty.all(Colors.black),
                    width: 100.w,
                    color: Colors.red,
                    child: AppText(
                      text: '+ ${LocaleKeys.favorite.tr()}',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 16.w),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Share.share(
                        "https://www.google.com/maps/search/?api=1&query=${AppCubit.get(context).showProviderModel['lat']},${AppCubit.get(context).showProviderModel['lng']}");
                  },
                  child: Container(
                    height: 35.w,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.copy,
                        height: 24.w,
                        width: 24.w,
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    customBottomSheet(
                      context: context,
                      enableDrag: false,
                      child: ShopLocation(
                        lat:
                            AppCubit.get(context).showProviderModel['lat'] ?? 0,
                        lng:
                            AppCubit.get(context).showProviderModel['lng'] ?? 0,
                        address: '',
                      ),
                    );
                  },
                  child: Container(
                    height: 35.h,
                    width: 93.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primary, width: 2.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: AppText(
                        text: LocaleKeys.view_on_map.tr(),
                        color: AppColors.primary,
                        size: 10.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
