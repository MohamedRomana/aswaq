import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_shimmer.dart';

class CustomGrideViewLoading extends StatelessWidget {
  const CustomGrideViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: GridView.builder(
        padding: EdgeInsetsDirectional.only(
          top: 10.h,
          start: 10.w,
          end: 10.w,
          bottom: 150.h,
        ),
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 205.h,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemBuilder: (context, index) => Container(
          height: 210.h,
          width: 165.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
