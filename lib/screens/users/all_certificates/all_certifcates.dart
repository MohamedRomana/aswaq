import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/warranty_certificate/warranty_certificate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/add_new_certifications.dart';

class AllCertifcates extends StatelessWidget {
  const AllCertifcates({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          text: LocaleKeys.all_certificates.tr(),
        ),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          bottom: 140.h,
        ),
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            AppRouter.navigateTo(context, const WarrantyCertificate());
          },
          child: Container(
            padding: EdgeInsets.all(16.r),
            height: 68.h,
            width: 343.w,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svg.done3,
                      height: 36.w,
                      width: 36.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 13.w),
                    AppText(
                      text: 'شهادة شاشة',
                      size: 24.sp,
                      family: Assets.fonts.norsalMedium,
                    )
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const AddNewCertificationBottSheet();
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    Assets.svg.more,
                    height: 24.w,
                    width: 24.w,
                    color: Colors.black,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
