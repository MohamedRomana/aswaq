import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/certificate_transfer_request/certificate_transfer_request_status.dart';
import 'package:aswaq/screens/users/transfer_warranty/transfer_warranty_certificate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/custom_certificate_container.dart';

class WarrantyCertificate extends StatelessWidget {
  const WarrantyCertificate({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          text: LocaleKeys.warranty_certificate.tr(),
        ),
      ),
      body: Column(
        children: [
          const CustomCertficateContainer(),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppButton(
                  onPressed: () {
                    AppRouter.navigateTo(
                        context, const TransferWarrantyCertificate());
                  },
                  color: Colors.white,
                  borderColor: AppColors.primary,
                  width: 165.w,
                  radius: 15.r,
                  child: AppText(
                    text: LocaleKeys.transfer_certificate.tr(),
                    color: AppColors.primary,
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppButton(
                  onPressed: () {
                    AppRouter.navigateTo(
                        context, const CertificateTransferRequestStatus());
                  },
                  width: 165.w,
                  radius: 15.r,
                  child: AppText(
                    text: LocaleKeys.view_certificate.tr(),
                    color: Colors.white,
                    size: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
