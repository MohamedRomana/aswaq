import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';

class CustomTypeChoice extends StatelessWidget {
  const CustomTypeChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          children: [
            AppText(
              top: 32.h,
              bottom: 22.h,
              text: 'اختر نوع الحساب',
              size: 30.sp,
              color: Colors.black,
              family: Assets.fonts.norsalBold,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changeTypeIndexs(index: 0);
              },
              child: Container(
                padding: EdgeInsets.all(10.r),
                margin: EdgeInsets.only(bottom: 16.h),
                height: 50.h,
                width: 311.w,
                decoration: BoxDecoration(
                  color: AppColors.containers,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'مستخدم',
                      color: AppCubit.get(context).changeTypeIndex == 0
                          ? Colors.black
                          : Colors.grey,
                      size: 14.sp,
                      family: Assets.fonts.norsalBold,
                    ),
                    Container(
                      height: 22.w,
                      width: 22.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppCubit.get(context).changeTypeIndex == 0
                              ? AppColors.primary
                              : const Color(0xff707070),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          color: AppCubit.get(context).changeTypeIndex == 0
                              ? AppColors.primary
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changeTypeIndexs(index: 1);
              },
              child: Container(
                padding: EdgeInsets.all(10.r),
                height: 50.h,
                width: 311.w,
                decoration: BoxDecoration(
                  color: AppColors.containers,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: 'مقدم خدمة',
                      color: AppCubit.get(context).changeTypeIndex == 1
                          ? Colors.black
                          : Colors.grey,
                      size: 14.sp,
                      family: Assets.fonts.norsalBold,
                    ),
                    Container(
                      height: 22.w,
                      width: 22.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppCubit.get(context).changeTypeIndex == 1
                              ? AppColors.primary
                              : const Color(0xff707070),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          color: AppCubit.get(context).changeTypeIndex == 1
                              ? AppColors.primary
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
