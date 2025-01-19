import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:aswaq/screens/users/all_certificates/all_certifcates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';
import 'widgets/add_new_category_bottom_sheet.dart';

class Certificates extends StatelessWidget {
  const Certificates({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: LocaleKeys.certificates.tr(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  AppRouter.navigateTo(context, const AllCertifcates());
                },
                child: Container(
                  height: 68.h,
                  width: 343.w,
                  padding: EdgeInsets.all(16.r),
                  clipBehavior: Clip.antiAlias,
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
                    children: [
                      SvgPicture.asset(
                        Assets.svg.done3,
                        height: 36.w,
                        width: 36.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 13.w),
                      AppText(
                        text: LocaleKeys.all_certificates.tr(),
                        size: 24.sp,
                        family: Assets.fonts.norsalMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppButton(
              top: 12.h,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const AddNewCategoryBottomSheet(),
                );
              },
              child: AppText(
                text: LocaleKeys.add_new_category.tr(),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 150.h,),
          ],
        ),
      ),
    );
  }
}
