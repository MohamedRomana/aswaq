// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/service/cubit/app_cubit.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_cached.dart';
import '../../../core/widgets/app_router.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../generated/locale_keys.g.dart';
import 'widgets/edit_profile_fields.dart';

final _formKey = GlobalKey<FormState>();
final _firstNameController = TextEditingController();
final _lastNameController = TextEditingController();
final _emailController = TextEditingController();
final _phoneController = TextEditingController();
final _passController = TextEditingController();
final _cityController = TextEditingController();

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90.h),
            child: CustomAppBar(
              text: LocaleKeys.editprofile.tr(),
            ),
          ),
          body: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      AppCubit.get(context).profileImage.isEmpty
                          ? InkWell(
                              onTap: () =>
                                  AppCubit.get(context).getProfileImage(context),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: AppCachedImage(
                                      image: AppCubit.get(context)
                                              .showUserMap["avatar"] ??
                                          "",
                                      height: 120.h,
                                      width: 120.w,
                                    ),
                                  ),
                                  PositionedDirectional(
                                    end: 0,
                                    child: Icon(
                                      Icons.edit_square,
                                      color: AppColors.primary,
                                      size: 25.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Stack(
                              children: [
                                Container(
                                  height: 120.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(AppCubit.get(context)
                                          .profileImage
                                          .first),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  child: InkWell(
                                    onTap: () => AppCubit.get(context)
                                        .removeProfileImage(),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.red,
                                      size: 25.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 20.h),
                      EditProfileFields(
                        passController: _passController,
                        phoneController: _phoneController,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        cityController: _cityController,
                      ),
                      BlocConsumer<AppCubit, AppState>(
                        listener: (context, state) {
                          if (state is UpdateUserSuccess) {
                            AppRouter.pop(context);
                            showFlashMessage(
                              message: state.message,
                              type: FlashMessageType.success,
                              context: context,
                            );
                            _firstNameController.clear();
                            _lastNameController.clear();
                            _phoneController.clear();
                            _emailController.clear();
                            _cityController.clear();
                            _passController.clear();
                          } else if (state is UpdateUserFailure) {
                            showFlashMessage(
                              message: state.error,
                              type: FlashMessageType.error,
                              context: context,
                            );
                          }
                        },
                        builder: (context, state) {
                          return AppButton(
                            top: 10.h,
                            onPressed: () {
                              AppCubit.get(context).updateUser(
                                password: _passController.text,
                                firstName: _firstNameController.text.isEmpty
                                    ? AppCubit.get(context)
                                        .showUserMap["first_name"]
                                    : _firstNameController.text,
                                lastName: _lastNameController.text.isEmpty
                                    ? AppCubit.get(context)
                                        .showUserMap["last_name"]
                                    : _lastNameController.text,
                                phone: _phoneController.text.isEmpty
                                    ? AppCubit.get(context).showUserMap["phone"]
                                    : _phoneController.text,
                              );
                            },
                            child: state is UpdateUserLoading ||
                                    state is UploadImagesLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : AppText(
                                    text: LocaleKeys.save.tr(),
                                    color: Colors.white,
                                  ),
                          );
                        },
                      ),
                      SizedBox(height: 150.h),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
