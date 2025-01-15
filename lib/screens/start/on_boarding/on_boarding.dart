// ignore_for_file: deprecated_member_use

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aswaq/core/constants/colors.dart';
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/app_text.dart';
import 'package:aswaq/gen/assets.gen.dart';
import 'widgets/on_boarding_buttons.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double currPage = 0.0;
  PageController pageController = PageController(initialPage: 0);
  List pagesList = [
    {
      "image1": Assets.img.onboarding1.path,
    },
    {
      "image1": Assets.img.onboarding2.path,
    },
    {
      "image1": Assets.img.onboarding3.path,
    },
  ];

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).intro();
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          currPage = pageController.page!;
        });
      });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: state is GetIntroLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: pagesList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            PositionedDirectional(
                              top: -130,
                              start: 40.w,
                              end: 40.w,
                              child: Column(
                                children: [
                                  Image.asset(
                                    pagesList[index]['image1'],
                                    fit: BoxFit.cover,
                                  ),
                                  AppText(
                                    top: 48.h,
                                    bottom: 20.h,
                                    text: AppCubit.get(context).onBoardingList[index].title,
                                    size: 30.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  AppText(
                                    text: AppCubit.get(context)
                                        .onBoardingList[index]
                                        .desc,
                                    lines: 3,
                                    size: 14.sp,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            CustomOnBoardingButtons(
                              pagesList: pagesList,
                              currPage: currPage,
                              pageController: pageController,
                            ),
                          ],
                        );
                      },
                    ),
                    PositionedDirectional(
                      bottom: 50.h,
                      end: 20.w,
                      start: 20.w,
                      child: DotsIndicator(
                        dotsCount: pagesList.length,
                        position: currPage,
                        decorator: DotsDecorator(
                          activeColor: AppColors.primary,
                          color: const Color(0xff878787).withOpacity(0.3),
                          size: Size.square(12.r),
                          activeSize: Size(20.w, 12.h),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
