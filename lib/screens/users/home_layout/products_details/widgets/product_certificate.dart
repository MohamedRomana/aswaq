import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../generated/locale_keys.g.dart';

class ProductCertificate extends StatelessWidget {
  const ProductCertificate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return InkWell(
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
                    text: LocaleKeys.request_warranty_certificate.tr(),
                    size: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
