import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/core/widgets/flash_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_router.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/transfer_fields.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _idController = TextEditingController();

class TransferWarrantyCertificate extends StatelessWidget {
  final int id;
  const TransferWarrantyCertificate({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: LocaleKeys.transfer_warranty_certificate.tr(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TransferFields(
                nameController: _nameController,
                phoneController: _phoneController,
                idController: _idController,
              ),
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is TransferCertificateSuccess) {
                    showFlashMessage(
                      message: state.message,
                      type: FlashMessageType.success,
                      context: context,
                    );
                    _nameController.clear();
                    _phoneController.clear();
                    _idController.clear();
                    AppRouter.pop(context);
                  } else if (state is TransferCertificateFailure) {
                    showFlashMessage(
                      message: state.error,
                      type: FlashMessageType.error,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    top: 24.h,
                    radius: 15.r,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppCubit.get(context).transferCertificate(
                          certificateId: id.toString(),
                          name: _nameController.text,
                          phone: _phoneController.text,
                          idNumber: _idController.text,
                        );
                      }
                    },
                    child: state is TransferCertificateLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : AppText(
                            text: LocaleKeys.transfer_certificate.tr(),
                            color: Colors.white,
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
