// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/core/widgets/custom_lottie_widget.dart';
import 'package:aswaq/screens/users/home_layout/markets/widgets/custom_list_shimmer.dart';
import 'package:aswaq/screens/users/orders_details/orders_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    AppCubit.get(context).allOrders();
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
              text: LocaleKeys.orders.tr(),
            ),
          ),
          body: state is AllOrdersLoading
              ? const ShopsListShimmer()
              : AppCubit.get(context).ordersList.isEmpty
                  ? CustomLottieWidget(
                      lottieName: Assets.img.emptyorder,
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsetsDirectional.only(
                        top: 10.h,
                        bottom: 140.h,
                        start: 16.w,
                        end: 16.w,
                      ),
                      itemCount: AppCubit.get(context).ordersList.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                            context,
                            OrdersDetails(
                              id: AppCubit.get(context).ordersList[index]['id'],
                            ),
                          );
                        },
                        child: Container(
                          width: 343.w,
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.r,
                                spreadRadius: 1.r,
                                color: Colors.grey.withOpacity(0.5.r),
                                offset: Offset(0, 5.r),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      AppText(
                                        text:
                                            '${LocaleKeys.orderNumber.tr()}  ',
                                        size: 14.sp,
                                      ),
                                      SizedBox(
                                        width: 110.w,
                                        child: AppText(
                                          text: AppCubit.get(context)
                                              .ordersList[index]['id']
                                              .toString(),
                                          color: AppColors.primary,
                                          size: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  SizedBox(
                                    width: 150.w,
                                    child: AppText(
                                      text: AppCubit.get(context)
                                                  .ordersList[index]
                                              ['order_date_format'] ??
                                          "",
                                      color: Colors.grey,
                                      size: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 90.w,
                                    child: Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: AppText(
                                        textAlign: TextAlign.end,
                                        text: AppCubit.get(context)
                                                    .ordersList[index]
                                                ['order_duration'] ??
                                            '',
                                        size: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Container(
                                    height: 35.h,
                                    width: 93.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: 93.w,
                                        child: AppText(
                                          textAlign: TextAlign.center,
                                          text: AppCubit.get(context)
                                                      .ordersList[index]
                                                  ['status_f'] ??
                                              '',
                                          size: 12.sp,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
