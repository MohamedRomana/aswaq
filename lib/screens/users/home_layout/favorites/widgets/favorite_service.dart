import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../products_details/products_details.dart';
import '../../markets/widgets/custom_list_shimmer.dart';
import 'custom_empty_fav.dart';

class FavoriteServices extends StatefulWidget {
  const FavoriteServices({
    super.key,
  });

  @override
  State<FavoriteServices> createState() => _FavoriteServicesState();
}

class _FavoriteServicesState extends State<FavoriteServices> {
  @override
  void initState() {
    AppCubit.get(context).showFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is ShowFavoriteLoading
            ? const ShopsListShimmer()
            : AppCubit.get(context).favServicesList.isEmpty
                ? const CustomEmptyFav(
                    isMarket: false,
                    isService: true,
                  )
                : ListView.separated(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 16.w,
                      top: 16.h,
                      bottom: 150.h,
                    ),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: AppCubit.get(context).favServicesList.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => AppRouter.navigateTo(
                          context,
                          ProductDetailsBottomSheet(
                            id: AppCubit.get(context).favServicesList[index]
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
                                              .favServicesList[index]
                                          ['first_image'] ??
                                      "",
                                  height: 100.h,
                                  width: 110.w,
                                  fit: BoxFit.cover,
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
                                                      .favServicesList[index]
                                                  ['title'] ??
                                              "",
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
                                            AppCubit.get(context)
                                                .removeServicesFav(
                                              serviceId: AppCubit.get(context)
                                                  .favServicesList[index]['id']
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
                                  SizedBox(
                                    width: 180.w,
                                    child: AppText(
                                      text: AppCubit.get(context)
                                                  .favServicesList[index]
                                              ['section_title'] ??
                                          "",
                                      color: Colors.grey,
                                      size: 12.sp,
                                    ),
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
                                                .favServicesList[index]
                                                    ['rate_avg']
                                                .toStringAsFixed(1) ??
                                            0.0,
                                        size: 14.sp,
                                      ),
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
