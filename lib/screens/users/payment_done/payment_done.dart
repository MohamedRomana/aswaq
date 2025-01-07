import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/alert_dialog.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widget/custom_add_payment_container.dart';
import 'widget/custom_dialog_goto_orders.dart';
import 'widget/custom_shipping_method.dart';
import 'widget/custom_total_price_container.dart';
import 'widget/payment_choice_container.dart';
import 'widget/payment_locat_index.dart';

class PaymentDone extends StatelessWidget {
  const PaymentDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: CustomAppBar(
              text: '${LocaleKeys.shop_details_number.tr()} 1',
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  const PaymentChoiceContainer(),
                  const CustomAddPaymentContainer(),
                  const PaymentLocatContaine(),
                  const CustomShippingMethod(),
                  const CusomTotalPriceContainer(),
                  AppButton(
                    onPressed: () {
                      customAlertDialog(
                        alertDialogHeight: 331.h,
                        alertDialogWidth: 311.w,
                        context: context,
                        child: const CustomDialogGoToOrders(),
                      );
                    },
                    child: AppText(
                      text: LocaleKeys.payment_confirmation.tr(),
                      color: Colors.white,
                      family: Assets.fonts.norsalBold,
                    ),
                  ),
                  SizedBox(height: 140.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

