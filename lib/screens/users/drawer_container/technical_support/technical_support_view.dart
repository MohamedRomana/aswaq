import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/locale_keys.g.dart';

class TechnicalSupportView extends StatelessWidget {
  const TechnicalSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(115.h),
        child: CustomAppBar(
          text: LocaleKeys.support_and_complaints.tr(),
        ),
      ),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/61ac84c880b2296cfdd01712/1fm4udcia',
        visitor: TawkVisitor(
            // name: AppCubit.get(context).userInfo["first_name"] ?? "",
            // email: AppCubit.get(context).userInfo["email"] ?? "",
            ),
        onLoad: () {
          debugPrint('Hello Tawk!');
        },
        onLinkTap: (String url) {
          debugPrint(url);
        },
        placeholder: Padding(
          padding: EdgeInsets.all(16.w),
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey,
            child: Container(
              height: 500.h,
              width: 343.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                color: AppColors.primary,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
