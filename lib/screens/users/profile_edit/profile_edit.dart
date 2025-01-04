// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/edit_profile_fields.dart';

final _formKey = GlobalKey<FormState>();
final _fullNameController = TextEditingController();
final _emailController = TextEditingController();
final _phoneController = TextEditingController();
final _passController = TextEditingController();

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: CustomAppBar(
          text: LocaleKeys.editprofile.tr(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            EditProfileFields(
              passController: _passController,
              fullNameController: _fullNameController,
              phoneController: _phoneController,
              emailController: _emailController,
            ),
            AppButton(
              top: 10.h,
              onPressed: () {},
              child: AppText(
                text: LocaleKeys.save.tr(),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
