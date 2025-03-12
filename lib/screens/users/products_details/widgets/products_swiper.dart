import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_cached.dart';

class ProductSwiper extends StatelessWidget {
  const ProductSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: 230.h,
          width: 343.w,
          margin: EdgeInsetsDirectional.only(
            bottom: 20.h,
            top: 20.h,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5.r,
                spreadRadius: 1.r,
                offset: Offset(0, 5.r),
              ),
            ],
          ),
          child: Swiper(
            scrollDirection: Axis.horizontal,
            itemCount: AppCubit.get(context).serviceImages.length,
            curve: Curves.fastOutSlowIn,
            onIndexChanged: (value) {
              AppCubit.get(context).changeIsSwiperTab(index: value);
            },
            controller: AppCubit.get(context).swiperController,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AppCachedImage(
                image: AppCubit.get(context).serviceImages[index].image,
                fit: BoxFit.fill,
              ),
            ),
            pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: Colors.grey,
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
