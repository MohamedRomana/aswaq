import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/gen/fonts.gen.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopDetailsShimmer extends StatelessWidget {
  const ShopDetailsShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 150.h,
                color: Colors.white,
              ),
              PositionedDirectional(
                top: 110.h,
                start: 20.w,
                child: Container(
                  width: 75.w,
                  height: 75.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(width: 2.w, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 50.h,
                      start: 16.w,
                      end: 20.w,
                    ),
                    height: 15.h,
                    width: 150.w,
                    color: Colors.white,
                  ),
                  SizedBox(width: 50.w),
                  Container(
                    height: 50.w,
                    width: 100.w,
                    margin: EdgeInsetsDirectional.only(
                      start: 16.w,
                      top: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50.w,
                    width: 50.w,
                    margin: EdgeInsetsDirectional.only(
                      start: 16.w,
                      top: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 10.h,
                      start: 10.w,
                    ),
                    height: 20.h,
                    width: 150.w,
                    color: Colors.white,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                  top: 16.h,
                  bottom: 20.h,
                ),
                height: 20.h,
                width: double.infinity,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 15.h,
                        width: 150.w,
                        color: Colors.white,
                      ),
                      AppText(
                        top: 10.h,
                        text: '5 / 5',
                        color: Colors.white,
                        family: FontFamily.norsalBold,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 15.h,
                        width: 150.w,
                        color: Colors.white,
                      ),
                      AppText(
                        top: 10.h,
                        text: '100%',
                        color: Colors.white,
                        family: FontFamily.norsalBold,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                  bottom: 16.h,
                  top: 20.h,
                ),
                height: 20.h,
                width: double.infinity,
                color: Colors.white,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    start: 16.w,
                    top: 16.h,
                  ),
                  height: 15.h,
                  width: 150.w,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(
                    end: 16.w,
                    top: 16.h,
                  ),
                  height: 45.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ]),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) => Row(
                  children: [
                    Container(
                      height: 50.w,
                      width: 50.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.readOnly(
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          initialRating: 4.5,
                          maxRating: 5,
                          isHalfAllowed: true,
                          halfFilledIcon: Icons.star_half,
                          size: 18.sp,
                        ),
                        SizedBox(height: 10.w),
                        Container(
                          height: 15.h,
                          width: 150.w,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 150.h),
        ],
      ),
    );
  }
}
