import 'package:aswaq/screens/users/chat_details/chat_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class CustomPrevoiusChats extends StatelessWidget {
  const CustomPrevoiusChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650.h,
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, bottom: 130.h),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.r,
            spreadRadius: 1.r,
            offset: Offset(0, 5.r),
          )
        ],
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
        itemBuilder: (context, index) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            AppRouter.navigateTo(
              context,
              const ChatDetails(),
            );
          },
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.svg.profilecircle,
                height: 40.w,
                width: 40.w,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: AppText(
                          text: ' اسم تجريبي',
                          size: 14.sp,
                          color: AppColors.primary,
                          family: Assets.fonts.norsalMedium,
                        ),
                      ),
                      SizedBox(
                        width: 70.w,
                        child: AppText(
                          textAlign: TextAlign.end,
                          text: 'منذ 2 ساعة',
                          size: 12.sp,
                          family: Assets.fonts.norsalLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200.w,
                    child: AppText(
                      text: 'يريد اسم العميل التواصل معك',
                      size: 12.sp,
                      color: Colors.grey,
                      family: Assets.fonts.norsalLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
