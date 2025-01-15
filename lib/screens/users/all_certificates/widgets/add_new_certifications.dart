import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../generated/locale_keys.g.dart';

final _categoryControllder = TextEditingController();
class AddNewCertificationBottSheet extends StatelessWidget {
  const AddNewCertificationBottSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: LocaleKeys.insert_certificate_into_category.tr(),
            size: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                bottom: 6.h,
                start: 20.w,
                text: LocaleKeys.category.tr(),
                size: 18.sp,
              ),
              AppInput(
                border: 10.r,
                filled: true,
                enabledBorderColor: Colors.grey,
                hint: LocaleKeys.choose_appropriate_category.tr(),
                controller: _categoryControllder,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: 25.sp,
                ),
                read: true,
                onTap: () async {
                  String? value = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        backgroundColor: AppColors.borderColor,
                        title: AppText(
                          text: LocaleKeys.enter_section.tr(),
                          size: 21.sp,
                        ),
                        // children: AppCubit.get(context).citiesList.map(
                        //   (value) {
                        //     return SimpleDialogOption(
                        //       onPressed: () {
                        //         AuthCubit.get(context).cityId =
                        //             value.id.toString();
                        //         Navigator.pop(context, value.title);
                        //       },
                        //       child: AppText(
                        //         text: value.title,
                        //         size: 18.sp,
                        //         color: AppColors.primary,
                        //       ),
                        //     );
                        //   },
                        // ).toList(),
                      );
                    },
                  );
                  if (value != null) {
                    // locationController.text = value;
                  }
                },
              ),
            ],
          ),
          AppButton(
            onPressed: () {},
            child: AppText(
              text: LocaleKeys.add_certificate.tr(),
              size: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
