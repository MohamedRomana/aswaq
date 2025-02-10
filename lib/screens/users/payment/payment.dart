// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/core/widgets/flash_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'custom_certificate_payment.dart';

class Payment extends StatefulWidget {
  final TextEditingController sectionTitleController;
  const Payment({super.key, required this.sectionTitleController});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    AppCubit.get(context).paymentIndex = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is StoreCertificatesPaymentSuccess) {
          showFlashMessage(
            message: state.message,
            type: FlashMessageType.success,
            context: context,
          );
          AppCubit.get(context).paymentIndex = -1;
          widget.sectionTitleController.clear();
          AppRouter.pop(context);
        } else if (state is StoreCertificatesPaymentFailure) {
          showFlashMessage(
            message: state.error,
            type: FlashMessageType.error,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: LocaleKeys.payment.tr(),
            ),
          ),
          body: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    width: 343.w,
                    margin: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.r,
                          spreadRadius: 1.r,
                          color: Colors.grey,
                          offset: Offset(0, 5.r),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (AppCubit.get(context).paymentIndex == 0) {
                              AppCubit.get(context)
                                  .changePaymentIndex(index: -1);
                            } else {
                              AppCubit.get(context)
                                  .changePaymentIndex(index: 0);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.svg.iconcard,
                                      height: 18.w,
                                      width: 18.w,
                                      color:
                                          AppCubit.get(context).paymentIndex ==
                                                  0
                                              ? AppColors.primary
                                              : Colors.grey,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 6.w),
                                    AppText(
                                      text: LocaleKeys.onlinePayment.tr(),
                                      size: 14.sp,
                                      color:
                                          AppCubit.get(context).paymentIndex ==
                                                  0
                                              ? Colors.black
                                              : Colors.grey,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 22.w,
                                  width: 22.w,
                                  decoration: BoxDecoration(
                                    color:
                                        AppCubit.get(context).paymentIndex == 0
                                            ? AppColors.primary
                                            : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      size: 15.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CustomCertificatePrice(),
                  AppButton(
                    onPressed: () {
                      if (AppCubit.get(context).paymentIndex == -1) {
                        showFlashMessage(
                          message: LocaleKeys.choosePaymentMethod.tr(),
                          type: FlashMessageType.warning,
                          context: context,
                        );
                      } else {
                        AppCubit.get(context).storeCertificatesPaymentSections(
                          title: widget.sectionTitleController.text,
                          // total:
                          //     AppCubit.get(context).certificatePrice.toString(),
                        );
                      }
                    },
                    top: 26.h,
                    child: state is StoreCertificatesPaymentLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : AppText(
                            text: LocaleKeys.payment_confirmation.tr(),
                            size: 16.sp,
                            color: Colors.white,
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
