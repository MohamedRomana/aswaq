import 'package:aswaq/screens/users/orders/orders.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomDialogGoToOrders extends StatelessWidget {
  const CustomDialogGoToOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          Assets.img.logo.path,
          height: 130.h,
          width: 250.w,
          fit: BoxFit.cover,
        ),
        AppText(
          text: LocaleKeys.request_sent_successfully.tr(),
          size: 16.sp,
        ),
        AppText(
          text: LocaleKeys.track_order_status.tr(),
          size: 16.sp,
        ),
        AppButton(
          onPressed: () {
            AppRouter.navigateAndPop(context, const Orders());
          },
          radius: 10.r,
          borderColor: AppColors.primary,
          color: Colors.white,
          child: AppText(
            text: LocaleKeys.orders.tr(),
            size: 16.sp,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
