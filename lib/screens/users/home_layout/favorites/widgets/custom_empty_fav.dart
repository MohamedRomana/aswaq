import 'package:aswaq/core/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomEmptyFav extends StatelessWidget {
  final bool isCart;
  final bool isMarket;

  const CustomEmptyFav({
    super.key,
    this.isCart = false,
    this.isMarket = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomLottieWidget(
          lottieName: Assets.img.notiEmpty,
        ),
        if (isMarket)
          AppText(
            top: 16.h,
            text: isCart
                ? LocaleKeys.emptyCart.tr()
                : LocaleKeys.favoritesEmpty.tr(),
            size: 24.sp,
            color: AppColors.primary,
            fontStyle: FontStyle.italic,
          ),
        SizedBox(height: 140.h),
      ],
    );
  }
}
