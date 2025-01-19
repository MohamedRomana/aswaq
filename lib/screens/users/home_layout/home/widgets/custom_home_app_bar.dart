import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../profile/profile.dart';
import '../../../search/search.dart';

class CustomHomeAppBar extends StatefulWidget {
  const CustomHomeAppBar({super.key});

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {
  @override
  void initState() {
    AppCubit.get(context).showUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, top: 60.h, end: 16.w),
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
                    CacheHelper.getUserId() == '' ||
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
                    SizedBox(width: 6.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: LocaleKeys.welcome_dear_customer.tr(),
                          size: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        AppText(
                          text: LocaleKeys.thank_you_for_your_preference.tr(),
                          size: 12.sp,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppRouter.navigateTo(context, const Search());
                    },
                    child: SvgPicture.asset(
                      Assets.svg.search,
                      height: 24.w,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
