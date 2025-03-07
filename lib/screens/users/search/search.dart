import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_button.dart';
import 'package:aswaq/core/widgets/app_input.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/core/widgets/custom_lottie_widget.dart';
import 'package:aswaq/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/app_cached.dart';
import '../../../gen/assets.gen.dart';
import '../shop_screen/widgets/custom_product_details.dart';

final _searchController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    _searchController.clear();
    AppCubit.get(context).searchList.clear();
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
              text: LocaleKeys.search.tr(),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      start: 13.w,
                      bottom: 16.h,
                      text: LocaleKeys.search_term.tr(),
                    ),
                    AppInput(
                      border: 10.r,
                      bottom: 16.h,
                      filled: true,
                      textInputAction: TextInputAction.search,
                      hint: LocaleKeys.enter_search_term.tr(),
                      controller: _searchController,
                      onSubmitted: (value) {
                        if (_searchController.text.isNotEmpty) {
                          AppCubit.get(context)
                              .getSearch(title: _searchController.text);
                          // _searchController.clear();
                        }
                      },
                      onChanged: (value) {
                        if (_searchController.text.isNotEmpty) {
                          AppCubit.get(context)
                              .getSearch(title: _searchController.text);
                          // _searchController.clear();
                        }
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.enter_search_term.tr();
                        } else {
                          return null;
                        }
                      },
                    ),
                    Center(
                      child: AppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AppCubit.get(context)
                                .getSearch(title: _searchController.text);
                          }
                        },
                        bottom: 20.h,
                        child: state is GetSerachLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : AppText(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                text: LocaleKeys.search.tr(),
                              ),
                      ),
                    ),
                    AppCubit.get(context).searchList.isEmpty
                        ? CustomLottieWidget(
                            lottieName: Assets.img.emptyseach,
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsetsDirectional.only(
                              top: 10.h,
                              start: 10.w,
                              end: 10.w,
                              bottom: 150.h,
                            ),
                            itemCount: AppCubit.get(context).searchList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 205.h,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.white,
                                    builder: (context) =>
                                        const ProductDetailsBottomSheet(
                                      id: 0,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 210.h,
                                  width: 165.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5.r,
                                        spreadRadius: 1.r,
                                        color: Colors.grey,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              textAlign: TextAlign.start,
                                              start: 10.w,
                                              top: 10.h,
                                              text: AppCubit.get(context)
                                                  .searchList[index]['title'],
                                              size: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150.w,
                                            child: AppText(
                                              textAlign: TextAlign.start,
                                              start: 10.w,
                                              top: 3.h,
                                              text: AppCubit.get(context)
                                                      .searchList[index]
                                                  ['section_title'],
                                              color: AppColors.primary,
                                              size: 9.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppCachedImage(
                                        image: AppCubit.get(context)
                                            .searchList[index]['first_image'],
                                        fit: BoxFit.cover,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 37.h,
                                            width: 39.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                bottomStart:
                                                    Radius.circular(10.r),
                                                topEnd: Radius.circular(10.r),
                                              ),
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                Assets.svg.bagTick,
                                                height: 24.h,
                                                width: 24.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.w,
                                            child: AppText(
                                              end: 10.w,
                                              textAlign: TextAlign.end,
                                              text:
                                                  '${AppCubit.get(context).searchList[index]['price']} ${LocaleKeys.sar.tr()}',
                                              size: 12.sp,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
