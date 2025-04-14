import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../shop_screen/shop_screen.dart';
import '../../markets/widgets/custom_list_shimmer.dart';
import 'custom_empty_fav.dart';

class FavoriteStores extends StatefulWidget {
  const FavoriteStores({super.key});

  @override
  State<FavoriteStores> createState() => _FavoriteStoresState();
}

class _FavoriteStoresState extends State<FavoriteStores> {
  @override
  void initState() {
    AppCubit.get(context).showFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return  state is ShowFavoriteLoading
                ? const ShopsListShimmer()
                : AppCubit.get(context).provicersList.isEmpty
                    ? const CustomEmptyFav(isMarket: false, isProvider: true,)
                    : ListView.separated(
                        padding: EdgeInsets.all(16.r),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: AppCubit.get(context).provicersList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => AppRouter.navigateTo(
                              context,
                              ShopScreen(
                                id: AppCubit.get(context).provicersList[index]
                                    ['id'],
                              ),
                            ),
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
                                          .provicersList[index]['avatar'],
                                      height: 100.h,
                                      width: 110.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 180.w,
                                            child: AppText(
                                              text: AppCubit.get(context)
                                                  .provicersList[index]
                                                      ['first_name']
                                                  .toString(),
                                              color: Colors.black,
                                              size: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                            child: InkWell(
                                              onTap: () {
                                                AppCubit.get(context)
                                                    .changeRemoveFavIndex(
                                                        index: index);
                                                AppCubit.get(context).removeFav(
                                                  providerId:
                                                      AppCubit.get(context)
                                                          .provicersList[index]
                                                              ['id']
                                                          .toString(),
                                                  index: index,
                                                );
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 19.sp,
                                              ),
                                            ),
                                          ),
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
                                          AppText(
                                            text: AppCubit.get(context)
                                                .provicersList[index]['rate']
                                                .toStringAsFixed(1),
                                            size: 14.sp,
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
                                                  '${LocaleKeys.distanceFromYou.tr()} ${AppCubit.get(context).provicersList[index]['distance']} ${LocaleKeys.km.tr()}',
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
