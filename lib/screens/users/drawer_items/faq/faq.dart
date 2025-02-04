// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_bottom_nav.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import 'widgets/faq_shimmer.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  void initState() {
    AppCubit.get(context).changeFaqIndexs(index: -1);
    AppCubit.get(context).getQuestions();
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
              text: LocaleKeys.faq.tr(),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 25.h),
                Image.asset(
                  Assets.img.logo.path,
                  height: 115.h,
                  width: 240.w,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20.h),
                state is GetQuestionsLoading
                    ? const FaqShimmer()
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AppCubit.get(context).questionsList.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 16.h,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (AppCubit.get(context).changeFaqIndex == index) {
                              AppCubit.get(context).changeFaqIndexs(index: -1);
                            } else {
                              AppCubit.get(context)
                                  .changeFaqIndexs(index: index);
                            }
                          },
                          child: Column(
                            children: [
                              AppCubit.get(context).changeFaqIndex == index
                                  ? Container(
                                      margin: EdgeInsets.all(16.sp),
                                      clipBehavior: Clip.antiAlias,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.sp),
                                      width: 343.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: const Color(0xffFBFBFB),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5.r,
                                            spreadRadius: 1.r,
                                            color: Colors.grey,
                                            offset: Offset(0, 5.r),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 285.w,
                                                child: AppText(
                                                  text: AppCubit.get(context)
                                                      .questionsList[index]
                                                      .title,
                                                  size: 12.sp,
                                                  lines: 2,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_up,
                                                color: Colors.black,
                                                size: 24.sp,
                                              )
                                            ],
                                          ),
                                          AppText(
                                            top: 10.h,
                                            bottom: 10.h,
                                            text: AppCubit.get(context)
                                                .questionsList[index]
                                                .desc,
                                            lines: 20,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.all(16.sp),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.sp),
                                      height: 50.h,
                                      width: 343.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: AppColors.primary,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5.r,
                                            spreadRadius: 1.r,
                                            color: Colors.grey,
                                            offset: Offset(0, 5.r),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 285.w,
                                            child: AppText(
                                              text: AppCubit.get(context)
                                                  .questionsList[index]
                                                  .title,
                                              lines: 2,
                                              size: 12.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 24.sp,
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(height: 160.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
