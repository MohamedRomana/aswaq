// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:aswaq/screens/users/shop_screen/shop_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/alert_dialog.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_login_dialog.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../favorites/widgets/custom_empty_fav.dart';
import 'custom_list_shimmer.dart';

class CustomMarketsListView extends StatelessWidget {
  const CustomMarketsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is GetSectionsLoading
            ? const ShopsListShimmer()
            : AppCubit.get(context).sectionsProvidersList.isEmpty
                ? const CustomEmptyFav(isMarket: false)
                : ListView.separated(
                    padding: EdgeInsetsDirectional.only(
                      bottom: 130.h,
                      start: 16.w,
                      end: 16.w,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        AppCubit.get(context).sectionsProvidersList.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => AppRouter.navigateTo(
                            context,
                            ShopScreen(
                              id: AppCubit.get(context)
                                  .sectionsProvidersList[index]['id'],
                            )),
                        child: Container(
                          height: 100.h,
                          width: 343.w,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
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
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: AppCachedImage(
                                  image: AppCubit.get(context)
                                      .sectionsProvidersList[index]['avatar'],
                                  fit: BoxFit.cover,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 180.w,
                                        child: AppText(
                                          text: AppCubit.get(context)
                                                  .sectionsProvidersList[index]
                                              ['first_name'],
                                          color: Colors.black,
                                          size: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            if (CacheHelper.getUserId() == "") {
                                              customAlertDialog(
                                                dialogBackGroundColor:
                                                    Colors.white,
                                                context: context,
                                                child:
                                                    const CustomLoginDialog(),
                                              );
                                            } else {
                                              AppCubit.get(context).addFavorite(
                                                  providerId: AppCubit.get(
                                                          context)
                                                      .sectionsProvidersList[
                                                          index]['id']
                                                      .toString());
                                            }
                                          },
                                          child: Icon(
                                            AppCubit.get(context)
                                                        .sectionsProvidersList[
                                                    index]['is_user_fav']
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: Colors.red,
                                            size: 19.sp,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: const Color(0xffE5BB45),
                                        size: 15.sp,
                                      ),
                                      SizedBox(width: 3.w),
                                      SizedBox(
                                        width: 50.w,
                                        child: AppText(
                                          text:double.parse( AppCubit.get(context)
                                              .sectionsProvidersList[index]
                                                  ['rate']
                                              .toString()).toStringAsFixed(1),
                                          size: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.svg.location,
                                        color: AppColors.primary,
                                        height: 15.h,
                                        width: 15.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 3.w),
                                      SizedBox(
                                        width: 190.w,
                                        child: AppText(
                                          text:
                                              '${LocaleKeys.distanceFromYou.tr()} ${AppCubit.get(context).sectionsProvidersList[index]['distance']} ${LocaleKeys.km.tr()}',
                                          color: Colors.grey,
                                          size: 10.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      },
    );
  }
}
