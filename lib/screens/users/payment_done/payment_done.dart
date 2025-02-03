import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/alert_dialog.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/home_layout/home_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/service/model/show_cart_items_model.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../generated/locale_keys.g.dart';
import 'widget/custom_dialog_goto_orders.dart';
import 'widget/custom_shipping_method.dart';
import 'widget/custom_total_price_container.dart';
import 'widget/payment_choice_container.dart';
import 'widget/payment_locat_index.dart';

class PaymentDone extends StatefulWidget {
  final ShowCartItemsModel cartItemsModel;
  const PaymentDone({super.key, required this.cartItemsModel});

  @override
  State<PaymentDone> createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  @override
  void initState() {
    AppCubit.get(context).changePaymentIndex(index: -1);
    AppCubit.get(context).changePaymentlocatIndex(index: -1);
    AppCubit.get(context).changeShipIndex(index: -1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is StoreOrderSuccess) {
          AppCubit.get(context).changebottomNavIndex(2);
          AppRouter.navigateAndFinish(context, const HomeLayout());
          customAlertDialog(
            alertDialogHeight: 331.h,
            alertDialogWidth: 311.w,
            context: context,
            child: const CustomDialogGoToOrders(),
          );
        } else if (state is StoreOrderFailure) {
          showFlashMessage(
            context: context,
            type: FlashMessageType.error,
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
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
                  // const CustomAddPaymentContainer(),
                  const PaymentLocatContaine(),
                  const CustomShippingMethod(),
                  CusomTotalPriceContainer(
                    cartItemsModel: widget.cartItemsModel,
                  ),
                  AppButton(
                    onPressed: () {
                      if (AppCubit.get(context).paymentlocatIndex == -1 ||
                          AppCubit.get(context).shipIndex == -1 ||
                          AppCubit.get(context).paymentIndex == -1) {
                        showFlashMessage(
                          context: context,
                          type: FlashMessageType.error,
                          message: LocaleKeys.complete_the_selections.tr(),
                        );
                      } else {
                        AppCubit.get(context).storeOrder(
                            cartId: widget.cartItemsModel.id.toString());
                      }
                    },
                    child: state is StoreOrderLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : AppText(
                            text: LocaleKeys.payment_confirmation.tr(),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
