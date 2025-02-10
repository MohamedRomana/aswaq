import 'package:aswaq/core/constants/contsants.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:aswaq/screens/users/warranty_certificate/widgets/custom_warranty_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_text.dart';
import 'widgets/certificate_status_container.dart';

class CertificateTransferRequestStatus extends StatelessWidget {
  const CertificateTransferRequestStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: LocaleKeys.certificate_transfer_request_status.tr(),
            ),
          ),
          body: state is ShowCertificatesLoading
              ? const Center(child: CustomWarrantyShimmer(isPage2: true))
              : Column(
                  children: [
                    const CertificateStatusContainer(),
                    AppCubit.get(context).showCertificateModel?.status ==
                                'agree' ||
                            AppCubit.get(context)
                                    .showCertificateModel
                                    ?.status ==
                                'new'
                        ? AppButton(
                            top: 16.h,
                            onPressed: () {
                              launchPDF(
                                pdfUrl: AppCubit.get(context)
                                        .showCertificateModel
                                        ?.file ??
                                    "",
                              );
                            },
                            child: AppText(
                              text: LocaleKeys.view_certificate.tr(),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(
                              start: 24.w,
                              text: LocaleKeys
                                  .request_rejected_due_to_invalid_data
                                  .tr(),
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                          ),
                  ],
                ),
        );
      },
    );
  }
}
