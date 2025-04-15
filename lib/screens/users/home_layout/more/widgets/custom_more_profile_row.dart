import 'package:aswaq/core/cache/cache_helper.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/screens/users/notifications/notifications.dart';
import 'package:aswaq/screens/users/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';

class CustomMoreProfileRow extends StatefulWidget {
  const CustomMoreProfileRow({super.key});

  @override
  State<CustomMoreProfileRow> createState() => _CustomMoreProfileRowState();
}

class _CustomMoreProfileRowState extends State<CustomMoreProfileRow> {
  @override
  void initState() {
    // AppCubit.get(context).showUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            top: 50.h,
            bottom: 24.h,
            start: 16.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  CacheHelper.getUserId() == ""
                      ? const SizedBox()
                      : AppRouter.navigateTo(context, const Profile());
                },
                child: Row(
                  children: [
                    CacheHelper.getUserId() == "" ||
                            state is ShowUserLoading &&
                                AppCubit.get(context).showUserMap.isEmpty
                        ? Container(
                            height: 36.w,
                            width: 36.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.svg.user,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: AppCachedImage(
                              image:
                                  AppCubit.get(context).showUserMap['avatar'] ??
                                      "",
                              height: 36.w,
                              width: 36.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                    CacheHelper.getUserId() == ""
                        ? AppText(
                            start: 10.w,
                            text: "Guest",
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                          )
                        : AppText(
                            start: 10.w,
                            text: AppCubit.get(context)
                                    .showUserMap['full_name'] ??
                                "",
                            size: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                  ],
                ),
              ),
              CacheHelper.getUserId() == ""
                  ? const SizedBox.shrink()
                  : InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppRouter.navigateTo(context, const Notifications());
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 16.w),
                        child: SvgPicture.asset(
                          Assets.svg.notificationBing,
                          height: 24.w,
                          width: 24.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
