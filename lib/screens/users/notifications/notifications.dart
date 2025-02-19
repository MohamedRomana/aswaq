// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/cache/cache_helper.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_login_first.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/empty_notifications.dart';
import 'widgets/notifications_shimmer.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    AppCubit.get(context).showNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: LocaleKeys.notifications.tr(),
            ),
          ),
          body: CacheHelper.getUserId() == ''
              ? const CustomLoginFirst()
              : state is ShowNotificationsLoading
                  ? const Center(
                      child: CustomNotificationShimmer(),
                    )
                  : AppCubit.get(context).notificationsModel.isEmpty
                      ? const Center(child: EmptyNotification())
                      : ListView.separated(
                          padding: EdgeInsetsDirectional.only(
                            top: 16.h,
                            bottom: 140.h,
                            start: 16.w,
                            end: 16.w,
                          ),
                          itemCount:
                              AppCubit.get(context).notificationsModel.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) => Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5.r),
                                  blurRadius: 5.r,
                                  spreadRadius: 1.r,
                                  offset: Offset(0, 5.r),
                                ),
                              ],
                            ),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      AppCubit.get(context).deleteNotification(
                                        notificationId: AppCubit.get(context)
                                            .notificationsModel[index]
                                            .id
                                            .toString(),
                                        index: index,
                                      );
                                    },
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                    icon: Icons.done,
                                    label: LocaleKeys.delete.tr(),
                                  ),
                                ],
                              ),
                              child: Container(
                                width: 343.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFCFCFC),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryLight,
                                      blurRadius: 5.r,
                                      spreadRadius: 1.r,
                                      offset: Offset(0, 5.r),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          height: 36.w,
                                          width: 36.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            color: const Color(0xff3FAD46),
                                          ),
                                          child: Icon(
                                            Icons.check_circle_outline_rounded,
                                            color: Colors.white,
                                            size: 25.sp,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              bottom: 9.h,
                                              text: AppCubit.get(context)
                                                  .notificationsModel[index]
                                                  .orderStatus,
                                              color: const Color(0xff3FAD46),
                                              size: 14.sp,
                                            ),
                                            SizedBox(
                                              height: 35.h,
                                              width: 160.w,
                                              child: AppText(
                                                text: AppCubit.get(context)
                                                    .notificationsModel[index]
                                                    .message,
                                                lines: 2,
                                                size: 12.sp,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: AppText(
                                        text: AppCubit.get(context)
                                            .notificationsModel[index]
                                            .time,
                                        color: Colors.black,
                                        size: 12.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
        );
      },
    );
  }
}
