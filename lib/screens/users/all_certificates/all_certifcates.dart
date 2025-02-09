// ignore_for_file: deprecated_member_use

import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_router.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/core/widgets/custom_lottie_widget.dart';
import 'package:aswaq/screens/users/warranty_certificate/warranty_certificate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/add_new_certifications.dart';
import 'widgets/custom_all_certificate_shimmer.dart';

class AllCertifcates extends StatefulWidget {
  final int id;
  const AllCertifcates({super.key, required this.id});

  @override
  State<AllCertifcates> createState() => _AllCertifcatesState();
}

class _AllCertifcatesState extends State<AllCertifcates> {
  @override
  void initState() {
    AppCubit.get(context).allCertificate(sectionId: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: CustomAppBar(
              text: LocaleKeys.all_certificates.tr(),
            ),
          ),
          body: state is AllCertificatesLoading
              ? const CustomAllCertificateShimmer()
              : AppCubit.get(context).allCertificatesList.isEmpty
                  ? CustomLottieWidget(
                      lottieName: Assets.img.notiEmpty,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.only(
                        top: 16.h,
                        start: 16.w,
                        end: 16.w,
                        bottom: 140.h,
                      ),
                      itemCount:
                          AppCubit.get(context).allCertificatesList.length,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppRouter.navigateTo(
                            context,
                            WarrantyCertificate(
                              id: AppCubit.get(context)
                                  .allCertificatesList[index]
                                  .id,
                            ),
                          );
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
                                    text: AppCubit.get(context)
                                        .allCertificatesList[index]
                                        .title,
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
                                      return AddNewCertificationBottSheet(
                                        certId: AppCubit.get(context)
                                            .allCertificatesList[index]
                                            .id,
                                      );
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
      },
    );
  }
}
