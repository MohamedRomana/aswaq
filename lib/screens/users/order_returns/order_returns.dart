// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/widgets/app_input.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';

final orderNumberController = TextEditingController();
final returnReasonController = TextEditingController();
class OrderReturns extends StatelessWidget {
  const OrderReturns({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: LocaleKeys.order_returns.tr(),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 32.h),
              Image.asset(
                Assets.img.logo.path,
                height: 115.h,
                width: 250.w,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 35.h),
              Container(
                width: 343.w,
                padding: EdgeInsets.all(16.r),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 5.r),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AppCubit.get(context).orderImage.isNotEmpty
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Container(
                                  height: 120.w,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(AppCubit.get(context)
                                          .orderImage
                                          .first),
                                    ),
                                  ),
                                ),
                              ),
                              PositionedDirectional(
                                end: 0,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    AppCubit.get(context).removeOrderImage();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              AppCubit.get(context).getOrderImage();
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10.r),
                              color: Colors.grey,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: SizedBox(
                                  height: 120.w,
                                  width: 120.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey,
                                      ),
                                      AppText(
                                        text: LocaleKeys.attach_photo.tr(),
                                        size: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    AppInput(
                      top: 16.h,
                      filled: true,
                      border: 10.r,
                      color: const Color(0xffEFEFEF),
                      enabledBorderColor: Colors.grey,
                      hint: LocaleKeys.order_number.tr(),
                      controller: orderNumberController,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(
                          Assets.svg.edit,
                          height: 24.w,
                          width: 24.w,
                          color: Colors.grey,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AppInput(
                      top: 16.h,
                      filled: true,
                      border: 10.r,
                      color: const Color(0xffEFEFEF),
                      enabledBorderColor: Colors.grey,
                      hint: LocaleKeys.reason_for_returning_product.tr(),
                      controller: returnReasonController,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}
