// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/service/cubit/app_cubit.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';

class EditProfileFields extends StatelessWidget {
  final TextEditingController passController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController cityController;
  final TextEditingController phoneController;
  const EditProfileFields({
    super.key,
    required this.passController,
    required this.phoneController,
    required this.firstNameController,
    required this.lastNameController,
    required this.cityController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              start: 18.w,
              text: LocaleKeys.edit_personal_information.tr(),
              size: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            Container(
              width: 343.w,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.sp),
              margin: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1.r,
                    blurRadius: 5.r,
                    offset: Offset(0, 5.r), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  AppInput(
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: AppCubit.get(context).showUserMap['first_name'] ?? "",
                    controller: firstNameController,
                    prefixIcon: SizedBox(
                      height: 25.w,
                      width: 25.w,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.profile,
                          height: 25.w,
                          width: 25.w,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppInput(
                    filled: true,
                    enabledBorderColor: Colors.grey,
                    hint: AppCubit.get(context).showUserMap['phone'] ?? "",
                    controller: phoneController,
                    inputType: TextInputType.phone,
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.grey,
                      size: 25.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppInput(
                    enabledBorderColor: Colors.grey,
                    bottom: 16.h,
                    filled: true,
                    hint: AppCubit.get(context).showUserMap['city_title'],
                    controller: cityController,
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 25.sp,
                    ),
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
                              text: LocaleKeys.chooseCity.tr(),
                              size: 21.sp,
                            ),
                            children: AppCubit.get(context).citiesList.map(
                              (value) {
                                return SimpleDialogOption(
                                  onPressed: () {
                                    AppCubit.get(context).cityId =
                                        value.id.toString();
                                    Navigator.pop(context, value.title);
                                  },
                                  child: AppText(
                                    text: value.title,
                                    size: 18.sp,
                                    color: AppColors.primary,
                                  ),
                                );
                              },
                            ).toList(),
                          );
                        },
                      );
                      if (value != null) {
                        cityController.text = value;
                      }
                    },
                  ),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return AppInput(
                        filled: true,
                        hint: LocaleKeys.password.tr(),
                        enabledBorderColor: Colors.grey,
                        controller: passController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.passwordValidate.tr();
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                          size: 25.sp,
                        ),
                        secureText: AppCubit.get(context).isSecureLogIn,
                        suffixIcon: AppCubit.get(context).isSecureLogIn
                            ? InkWell(
                                onTap: () {
                                  AppCubit.get(context)
                                      .isSecureLogInIcon(false);
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                    size: 21.sp,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  AppCubit.get(context).isSecureLogInIcon(true);
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                    size: 21.sp,
                                  ),
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
