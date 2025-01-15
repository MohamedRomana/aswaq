import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_shimmer.dart';

class FaqShimmer extends StatelessWidget {
  const FaqShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(
          height: 16.h,
        ),
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.sp),
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              height: 50.h,
              width: 343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5.r,
                    spreadRadius: 1.r,
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(0, 5.r),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24.sp,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
