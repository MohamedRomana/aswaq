import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          height: 209.h,
          padding: EdgeInsets.all(28.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(15.r),
              topStart: Radius.circular(15.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  AppCubit.get(context).allSections(
                    sectionId: AppCubit.get(context)
                        .sections[AppCubit.get(context).marketIndex]
                        .id
                        .toString(),
                    isDistance: true,
                    filter: "distance",
                  );
                  AppRouter.pop(context);
                },
                child: SizedBox(
                  width: 343.w,
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: LocaleKeys.sortByNearest.tr(),
                    color: Colors.black,
                    size: 16.sp,
                  ),
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              InkWell(
                onTap: () {
                  AppCubit.get(context).allSections(
                    sectionId: AppCubit.get(context)
                        .sections[AppCubit.get(context).marketIndex]
                        .id
                        .toString(),
                    filter: "rate",
                  );
                  AppRouter.pop(context);
                },
                child: SizedBox(
                  width: 343.w,
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: LocaleKeys.sortByHighestRating.tr(),
                    color: Colors.black,
                    size: 16.sp,
                  ),
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              InkWell(
                onTap: () {
                  AppCubit.get(context).allSections(
                    sectionId: AppCubit.get(context)
                        .sections[AppCubit.get(context).marketIndex]
                        .id
                        .toString(),
                    filter: "order",
                  );
                  AppRouter.pop(context);
                },
                child: SizedBox(
                  width: 343.w,
                  child: AppText(
                    textAlign: TextAlign.center,
                    text: LocaleKeys.sort_by_most_requested.tr(),
                    color: Colors.black,
                    size: 16.sp,
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
