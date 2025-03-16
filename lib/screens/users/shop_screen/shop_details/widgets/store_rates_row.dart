import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/alert_dialog.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'shop_reviews_comments.dart';
import 'shop_reviews_dialog.dart';

final _formKey = GlobalKey<FormState>();
final _commentShopController = TextEditingController();

class StoreRatesRow extends StatefulWidget {
  const StoreRatesRow({super.key});

  @override
  State<StoreRatesRow> createState() => _StoreRatesRowState();
}

class _StoreRatesRowState extends State<StoreRatesRow> {
  @override
  void initState() {
    _commentShopController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    num rate = AppCubit.get(context).showProviderModel['rate'];
    num rateCount = AppCubit.get(context).showProviderModel['rate_count'];
    num percentage = (rate * rateCount) / (5 * rateCount) * 100;
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 15.h,
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              color: Colors.grey.withOpacity(0.2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    AppText(
                      start: 16.w,
                      bottom: 10.h,
                      text: LocaleKeys.store_category.tr(),
                      size: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        start: 16.w,
                        text:
                            '${((percentage / 100) * 5).toStringAsFixed(1)}/5',
                        size: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    AppText(
                      start: 16.w,
                      bottom: 10.h,
                      text: LocaleKeys.customer_reviews.tr(),
                      size: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: AppText(
                        start: 16.w,
                        text: '${percentage.toStringAsFixed(1)}%',
                        size: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 15.h,
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
              color: Colors.grey.withOpacity(0.2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  start: 16.w,
                  bottom: 10.h,
                  text: LocaleKeys.store_rating.tr(),
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 40.h,
                  child: AppButton(
                    end: 16.w,
                    width: 100.w,
                    onPressed: () {
                      customAlertDialog(
                        alertDialogWidth: 300.w,
                        alertDialogHeight: 360.h,
                        context: context,
                        child: ShopReviewsDialog(
                          formKey: _formKey,
                          commentShopController: _commentShopController,
                        ),
                      );
                    },
                    child: AppText(
                      text: LocaleKeys.confirmRating.tr(),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const ShopReviewsComments(),
            SizedBox(height: 20.h),
            Divider(
              color: Colors.black,
              indent: 20.w,
              endIndent: 20.w,
            ),
          ],
        );
      },
    );
  }
}
