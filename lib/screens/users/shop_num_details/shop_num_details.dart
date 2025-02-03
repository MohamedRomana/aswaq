import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/payment_done/payment_done.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/carts_list_view.dart';
import 'widgets/cost_container.dart';
import 'widgets/custom_shop_num_shimmer.dart';

class ShopNumDetails extends StatefulWidget {
  final int id;
  const ShopNumDetails({super.key, required this.id});

  @override
  State<ShopNumDetails> createState() => _ShopNumDetailsState();
}

class _ShopNumDetailsState extends State<ShopNumDetails> {
  @override
  void initState() {
    AppCubit.get(context).cartItems(cartItemId: widget.id.toString());
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
              text:
                  '${LocaleKeys.shop_details_number.tr()} ${AppCubit.get(context).cartItemsModel?.salerName}',
            ),
          ),
          body: state is CartItemsLoading &&
                  AppCubit.get(context).cartItemsModel == null
              ? const CustomShopNumShimmer()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const CartsListView(),
                      const CostContainer(),
                      AppButton(
                        top: 24.h,
                        bottom: 140.h,
                        onPressed: () {
                          AppRouter.navigateTo(
                            context,
                            PaymentDone(
                              cartItemsModel:
                                  AppCubit.get(context).cartItemsModel!,
                            ),
                          );
                        },
                        child: AppText(
                          text: LocaleKeys.complete_order.tr(),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
