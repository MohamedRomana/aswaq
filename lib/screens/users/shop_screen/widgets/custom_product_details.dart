// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/cache/cache_helper.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_cached.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alert_dialog.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_login_dialog.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'custom_bottom_sheet_load.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final int id;
  const ProductDetailsBottomSheet({super.key, required this.id});

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet> {
  @override
  void initState() {
    AppCubit.get(context).showService(serviceId: widget.id.toString());
    AppCubit.get(context).hasCertificate = false;
    AppCubit.get(context).count = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: state is ShowServiceLoading
              ? const CustomBottomSheetLoading()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 210.h,
                        width: 300.w,
                        child: Swiper(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppCubit.get(context).serviceImages.length,
                          curve: Curves.fastOutSlowIn,
                          autoplay: true,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: AppCachedImage(
                              image: AppCubit.get(context)
                                  .serviceImages[index]
                                  .image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          pagination: SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.grey,
                              activeColor: AppColors.primary,
                              size: 8.r,
                              activeSize: 11.r,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 170.w,
                                child: AppText(
                                  text: AppCubit.get(context)
                                          .showServiceModel
                                          ['title'],
                                  size: 19.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 150.w,
                                child: AppText(
                                  top: 16.h,
                                  bottom: 16.h,
                                  text: AppCubit.get(context)
                                          .showServiceModel['section_title'],
                                  size: 16.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 150.w,
                            child: AppText(
                              textAlign: TextAlign.end,
                              text:
                                  '${AppCubit.get(context).showServiceModel['price']} ${LocaleKeys.sar.tr()}',
                              color: AppColors.primary,
                              size: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 343.w,
                            child: AppText(
                              bottom: 7.h,
                              text: LocaleKeys.product_description.tr(),
                              size: 16.sp,
                            ),
                          ),
                          SizedBox(
                            width: 343.w,
                            child: AppText(
                              bottom: 16.h,
                              text: AppCubit.get(context)
                                      .showServiceModel
                                      ['desc'] ??
                                  '',
                              color: Colors.grey,
                              size: 14.sp,
                              lines: 3,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppCubit.get(context).changeCertificate();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.h, bottom: 30.h),
                          child: Row(
                            children: [
                              Container(
                                height: 22.w,
                                width: 22.w,
                                decoration: BoxDecoration(
                                  color: AppCubit.get(context).hasCertificate
                                      ? AppColors.primary
                                      : Colors.transparent,
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
                              SizedBox(
                                width: 300.w,
                                child: AppText(
                                  start: 8.w,
                                  text: LocaleKeys.request_warranty_certificate
                                      .tr(),
                                  size: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
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
                                    AppCubit.get(context).addToCart(
                                        serviceId: widget.id.toString());
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
