import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';

class SwiperContainer extends StatelessWidget {
  const SwiperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: 150.h,
          width: 343.w,
          margin: EdgeInsetsDirectional.only(
              top: 20.h, bottom: 20.h, start: 20.w, end: 20.w),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.r,
                spreadRadius: 1.r,
                offset: Offset(0, 5.r),
              ),
            ],
          ),
          child: AppCubit.get(context).clientHomeModel['sliders'] == null
              ? Container(
                  height: 150.h,
                  width: 343.w,
                  margin: EdgeInsetsDirectional.only(
                      top: 20.h, bottom: 20.h, start: 20.w, end: 20.w),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.r,
                        spreadRadius: 1.r,
                        offset: Offset(0, 5.r),
                      ),
                    ],
                  ),
                )
              : Swiper(
                  itemBuilder: (context, index) => AppCachedImage(
                    image: AppCubit.get(context).clientHomeModel['sliders']
                            [index]['image'] ??
                        "",
                    fit: BoxFit.cover,
                  ),
                  autoplay: true,
                  itemCount:
                      AppCubit.get(context).clientHomeModel['sliders'].length,
                  scrollDirection: Axis.horizontal,
                  curve: Curves.fastOutSlowIn,
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: const Color(0xffB3B3B3),
                      activeColor: AppColors.primary,
                      size: 8.r,
                      activeSize: 11.r,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
