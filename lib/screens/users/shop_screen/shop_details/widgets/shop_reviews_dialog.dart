import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_input.dart';
import '../../../../../core/widgets/app_router.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/flash_message.dart';
import '../../../../../generated/locale_keys.g.dart';

class ShopReviewsDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController commentShopController;
  const ShopReviewsDialog({
    super.key, required this.formKey, required this.commentShopController,
  });

  @override
  Widget build(BuildContext context) {
    double value = 1.0;

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              RatingBar.builder(
                initialRating: 1,
                allowHalfRating: true,
                minRating: 1,
                itemCount: 5,
                itemSize: 30.sp,
                direction: Axis.horizontal,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  value = rating;
                  debugPrint(value.toString());
                },
              ),
              AppText(
                top: 16.h,
                bottom: 20.h,
                text: LocaleKeys.Writeyourreview.tr(),
                size: 18,
                fontWeight: FontWeight.bold,
              ),
              const Divider(color: Colors.grey),
              SizedBox(height: 20.h),
              AppInput(
                controller: commentShopController,
                contentTop: 30.h,
                enabledBorderColor: Colors.grey,
                filled: true,
                border: 5.r,
                hint: LocaleKeys.yourComment.tr(),
                validate: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.please_write_your_comment.tr();
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {
                      if (state is RateProviderSuccess) {
                        showFlashMessage(
                          message: state.message,
                          type: FlashMessageType.success,
                          context: context,
                        );
                        AppRouter.pop(context);
                        commentShopController.clear();
                        value = 1.0;
                      } else if (state is RateProviderFailure) {
                        showFlashMessage(
                          message: state.error,
                          type: FlashMessageType.error,
                          context: context,
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        height: 50.h,
                        child: AppButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AppCubit.get(context).rateProvider(
                                  providerId: AppCubit.get(context)
                                      .showProviderModel['id']
                                      .toString(),
                                  rate: value.toString(),
                                  desc: commentShopController.text);
                            }
                          },
                          color: Colors.green,
                          width: 120.w,
                          child: state is RateProviderLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : AppText(
                                  text: LocaleKeys.submit.tr(),
                                  color: Colors.white,
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      onPressed: () {
                        AppRouter.pop(context);
                      },
                      color: Colors.red,
                      width: 120.w,
                      child: AppText(
                        text: LocaleKeys.cancel.tr(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
