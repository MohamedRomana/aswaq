import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../gen/assets.gen.dart';

class SwiperContainer extends StatelessWidget {
  const SwiperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        curve: Curves.fastOutSlowIn,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(Assets.img.swiper.path),
        ),
        autoplay: true,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: AppColors.primary,
            size: 8.r,
            activeSize: 11.r,
          ),
        ),
      ),
    );
  }
}
