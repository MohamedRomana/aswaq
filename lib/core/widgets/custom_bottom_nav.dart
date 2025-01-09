import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../gen/assets.gen.dart';
import '../../screens/users/home_layout/home_layout.dart';
import '../service/cubit/app_cubit.dart';
import 'app_router.dart';

class CustomBottomNav extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  const CustomBottomNav({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    bool showBotton = MediaQuery.of(context).viewInsets.bottom != 0;

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButtonLocation: floatingActionButtonLocation ??
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: floatingActionButton ??
              Visibility(
                visible: !showBotton,
                child: Container(
                  padding: EdgeInsets.only(top: 3.h),
                  clipBehavior: Clip.antiAlias,
                  height: 60.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(5.r),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppCubit.get(context).changebottomNavIndex(0);
                          AppRouter.navigateAndFinish(
                              context, const HomeLayout());
                        },
                        child: SizedBox(
                          width: 50.w,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.markets,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppCubit.get(context).changebottomNavIndex(1);
                          AppRouter.navigateAndFinish(
                              context, const HomeLayout());
                        },
                        child: SizedBox(
                          width: 50.w,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.favorites,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppCubit.get(context).changebottomNavIndex(2);
                          AppRouter.navigateAndFinish(
                              context, const HomeLayout());
                        },
                        child: SizedBox(
                          width: 50.w,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.home,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppCubit.get(context).changebottomNavIndex(3);
                          AppRouter.navigateAndFinish(
                              context, const HomeLayout());
                        },
                        child: SizedBox(
                          width: 50.w,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.shoppingcart,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          AppCubit.get(context).changebottomNavIndex(4);
                          AppRouter.navigateAndFinish(
                              context, const HomeLayout());
                        },
                        child: SizedBox(
                          width: 50.w,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svg.more,
                              height: 24.w,
                              width: 24.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
      },
    );
  }
}
