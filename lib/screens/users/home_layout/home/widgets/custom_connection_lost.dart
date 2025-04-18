import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/custom_lottie_widget.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/fonts.gen.dart';
import '../../../../../generated/locale_keys.g.dart';

class CustomConnectionLost extends StatelessWidget {
  const CustomConnectionLost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomLottieWidget(
          lottieName: Assets.img.internetLost,
        ),
        AppText(
          text: LocaleKeys.no_internet_connection.tr(),
          size: 18.sp,
          color: AppColors.primary,
          lines: 2,
        ),
        AppButton(
          top: 26.h,
          onPressed: () {
            context.read<AppCubit>().clientHome();
          },
          child: AppText(
            text: LocaleKeys.retry.tr(),
            size: 18.sp,
            family: FontFamily.norsalBold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
