import 'package:aswaq/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_router.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/flash_message.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../payment/payment.dart';

final _secrtionController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class AddNewCategoryBottomSheet extends StatelessWidget {
  const AddNewCategoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          height: 300.h,
          // width: double.infinity,
          margin: MediaQuery.of(context).viewInsets,
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: LocaleKeys.add_new_category.tr(),
                size: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    bottom: 6.h,
                    start: 20.w,
                    text: LocaleKeys.section.tr(),
                    size: 18.sp,
                  ),
                  AppInput(
                    border: 10.r,
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: LocaleKeys.enter_section.tr(),
                    controller: _secrtionController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.enter_section.tr();
                      } else {
                        return null;
                      }
                    },
                    // suffixIcon: Icon(
                    //   Icons.arrow_drop_down,
                    //   color: Colors.grey,
                    //   size: 25.sp,
                    // ),
                    // read: true,
                    // onTap: () async {
                    //   String? value = await showDialog<String>(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return SimpleDialog(
                    //         backgroundColor: AppColors.borderColor,
                    //         title: AppText(
                    //           text: LocaleKeys.enter_section.tr(),
                    //           size: 21.sp,
                    //         ),
                    //         // children: AppCubit.get(context).citiesList.map(
                    //         //   (value) {
                    //         //     return SimpleDialogOption(
                    //         //       onPressed: () {
                    //         //         AuthCubit.get(context).cityId =
                    //         //             value.id.toString();
                    //         //         Navigator.pop(context, value.title);
                    //         //       },
                    //         //       child: AppText(
                    //         //         text: value.title,
                    //         //         size: 18.sp,
                    //         //         color: AppColors.primary,
                    //         //       ),
                    //         //     );
                    //         //   },
                    //         // ).toList(),
                    //       );
                    //     },
                    //   );
                    //   if (value != null) {
                    //     // locationController.text = value;
                    //   }
                    // },
                  ),
                ],
              ),
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is StoreCertificatesSuccess) {
                    showFlashMessage(
                      message: state.message,
                      type: FlashMessageType.success,
                      context: context,
                    );
                    _secrtionController.clear();
                    AppRouter.pop(context);
                    AppRouter.navigateTo(context, const Payment());
                  } else if (state is StoreCertificatesFailure) {
                    showFlashMessage(
                      message: state.error,
                      type: FlashMessageType.error,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppCubit.get(context).storeCertificatesSections(
                          title: _secrtionController.text,
                        );
                      }
                    },
                    child: state is StoreCertificatesLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : AppText(
                            text: LocaleKeys.add_certificate.tr(),
                            size: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
