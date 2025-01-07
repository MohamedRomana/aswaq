// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  List<bool> isFaq = List<bool>.generate(4, (index) => false);

  void toggleState(int index) {
    setState(() {
      isFaq[index] = !isFaq[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          text: LocaleKeys.faq.tr(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 25.h),
            Image.asset(
              Assets.img.logo.path,
              height: 115.h,
              width: 240.w,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => SizedBox(
                height: 16.h,
              ),
              itemBuilder: (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  toggleState(index);
                },
                child: Column(
                  children: [
                    isFaq[index]
                        ? Container(
                            margin: EdgeInsets.all(16.sp),
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            width: 343.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: const Color(0xffFBFBFB),
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: 'عنوان السؤال',
                                      size: 14.sp,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.black,
                                      size: 24.sp,
                                    )
                                  ],
                                ),
                                AppText(
                                  top: 10.h,
                                  bottom: 10.h,
                                  text:
                                      'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "هنا يوجد محتوى نصي، هنا يوجد محتوى نصي" فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخال "lorem ipsum" في أي محرك بحث ستظهر العديد من المواقع الحديثة العهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدة ومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة، وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها.',
                                  lines: 20,
                                )
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(16.sp),
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            height: 50.h,
                            width: 343.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: AppColors.primary,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5.r,
                                  spreadRadius: 1.r,
                                  color: Colors.grey,
                                  offset: Offset(0, 5.r),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: 'عنوان السؤال',
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 24.sp,
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 160.h),
          ],
        ),
      ),
    );
  }
}
