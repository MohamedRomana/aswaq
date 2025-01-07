import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    AppCubit.get(context).privacyPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: CustomAppBar(
              text: LocaleKeys.privacy_policy.tr(),
            ),
          ),
          body: state is PrivacyPolicyLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.img.logo.path,
                          color: AppColors.primary,
                          height: 115.h,
                          width: 240.w,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20.h),
                        AppText(
                          text: AppCubit.get(context).privacyPolicyTitle,
                          lines: 100,
                          size: 16.sp,
                        ),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
