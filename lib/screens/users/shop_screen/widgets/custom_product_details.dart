// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/screens/users/home_layout/home_layout.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  const ProductDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 210.h,
                  child: Swiper(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    curve: Curves.fastOutSlowIn,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        Assets.img.wash.path,
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
                          width: 150.w,
                          child: AppText(
                            text: 'اسم المنتج',
                            size: 19.sp,
                            family: Assets.fonts.norsalBold,
                          ),
                        ),
                        SizedBox(
                          width: 150.w,
                          child: AppText(
                            top: 16.h,
                            bottom: 16.h,
                            text: 'اسم القسم',
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 90.w,
                      child: AppText(
                        text: '‏350 ${LocaleKeys.sar.tr()}',
                        color: AppColors.primary,
                        size: 22.sp,
                        family: Assets.fonts.norsalBold,
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
                    AppText(
                      bottom: 7.h,
                      text: LocaleKeys.product_description.tr(),
                      size: 16.sp,
                    ),
                    AppText(
                      bottom: 16.h,
                      text:
                          'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "هنا يوجد محتوى نصي، هنا يوجد محتوى نصي" فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخال "lorem ipsum" في أي محرك بحث ستظهر العديد من المواقع الحديثة العهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدة ومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة، وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها.',
                      color: Colors.grey,
                      size: 14.sp,
                      lines: 3,
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
                    if (AppCubit.get(context).requestIndex == 0) {
                      AppCubit.get(context).changerequestIndex(index: -1);
                    } else {
                      AppCubit.get(context).changerequestIndex(index: 0);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 30.h),
                    child: Row(
                      children: [
                        Container(
                          height: 22.w,
                          width: 22.w,
                          decoration: BoxDecoration(
                            color: AppCubit.get(context).requestIndex == 0
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
                        AppText(
                          start: 8.w,
                          text: LocaleKeys.request_warranty_certificate.tr(),
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).increseCount();
                          },
                          child: Container(
                            height: 20.w,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 15.sp,
                            ),
                          ),
                        ),
                        AppText(
                          start: 11.w,
                          end: 11.w,
                          text: AppCubit.get(context).count.toString(),
                          size: 16.sp,
                          family: Assets.fonts.norsalBold,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            AppCubit.get(context).decreseCount();
                          },
                          child: Container(
                            height: 20.w,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 15.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        AppCubit.get(context).changebottomNavIndex(3);
                        AppRouter.navigateAndFinish(
                            context, const HomeLayout());
                      },
                      child: Container(
                        height: 50.h,
                        width: 155.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Row(
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
                              family: Assets.fonts.norsalBold,
                            ),
                          ],
                        ),
                      ),
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
