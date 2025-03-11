import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_login_dialog.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../products_details.dart';

class AddToCartRow extends StatelessWidget {
  const AddToCartRow({
    super.key,
    required this.widget,
  });

  final ProductDetailsBottomSheet widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).increseCount();
                },
                child: Container(
                  height: 25.w,
                  width: 25.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              AppText(
                start: 11.w,
                end: 11.w,
                text: AppCubit.get(context).count.toString(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppCubit.get(context).decreseCount();
                },
                child: Container(
                  height: 25.w,
                  width: 25.w,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              AppRouter.pop(context);
              showFlashMessage(
                context: context,
                type: FlashMessageType.success,
                message: state.message,
              );
            } else if (state is AddToCartFailure) {
              showFlashMessage(
                message: state.error,
                type: FlashMessageType.error,
                context: context,
              );
            }
          },
          builder: (context, state) {
            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (CacheHelper.getUserId() == "") {
                  customAlertDialog(
                    dialogBackGroundColor: Colors.white,
                    context: context,
                    child: const CustomLoginDialog(),
                  );
                } else {
                  AppCubit.get(context)
                      .addToCart(serviceId: widget.id.toString());
                }
              },
              child: Container(
                height: 50.h,
                width: 155.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: state is AddToCartLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.svg.bag,
                            height: 24.w,
                            width: 24.w,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          SizedBox(width: 3.w),
                          AppText(
                            text: LocaleKeys.add_to_cart.tr(),
                            color: Colors.white,
                            size: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
