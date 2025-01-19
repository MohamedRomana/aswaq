import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/transfer_fields.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _phoneController = TextEditingController();
final _idController = TextEditingController();

class TransferWarrantyCertificate extends StatelessWidget {
  const TransferWarrantyCertificate({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: CustomAppBar(
          text: LocaleKeys.transfer_warranty_certificate.tr(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TransferFields(
              nameController: _nameController,
              phoneController: _phoneController,
              idController: _idController,
            ),
            AppButton(
              top: 24.h,
              radius: 15.r,
              onPressed: () {},
              child: AppText(
                text: LocaleKeys.transfer_certificate.tr(),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
