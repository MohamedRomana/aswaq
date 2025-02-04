import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/custom_order_content_list_view.dart';
import 'widgets/custom_order_details_shimmer.dart';
import 'widgets/custom_order_information.dart';
import 'widgets/custom_order_total_price.dart';

class OrdersDetails extends StatefulWidget {
  final int id;
  const OrdersDetails({super.key, required this.id});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  @override
  void initState() {
    AppCubit.get(context).showOrders(orderId: widget.id.toString());
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
              text: LocaleKeys.orderDetails.tr(),
            ),
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    top: 16.h,
                    start: 16.w,
                    bottom: 16.h,
                    end: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: TabBar(
                    splashBorderRadius: BorderRadius.circular(5.r),
                    labelColor: Colors.white,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: AppColors.primary,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    tabs: [
                      Container(
                        width: 165.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Tab(
                          text: LocaleKeys.order_contents.tr(),
                        ),
                      ),
                      Container(
                        width: 165.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Tab(
                          text: LocaleKeys.order_details.tr(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: state is ShowOrdersLoading
                            ? const CustomOrderDetailShimmer()
                            : const Column(
                                children: [
                                  CustomOrderContentListView(),
                                  CustomOrderTotalPrice(),
                                ],
                              ),
                      ),
                      const SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CustomOrderInformation(),
                            CustomOrderTotalPrice(),
                          ],
                        ),
                      ),
                    ],
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

