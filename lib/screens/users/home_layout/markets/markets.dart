import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import 'widgets/custom_markets_list_view.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  void initState() {
    AppCubit.get(context).allSections(sectionId: '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: const CustomAppBar(isMarket: true)),
          body: DefaultTabController(
            initialIndex: 0,
            length: AppCubit.get(context).sections.length,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(
                    top: 16.h,
                    start: 10.w,
                    bottom: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: TabBar(
                    onTap: (index) {
                      AppCubit.get(context).changeMarketIndex(index: index);
                      AppCubit.get(context).allSections(
                          sectionId: AppCubit.get(context)
                              .sections[index]
                              .id
                              .toString(),
                              );
                    },
                    padding: EdgeInsetsDirectional.only(start: -40.w),
                    physics: const BouncingScrollPhysics(),
                    isScrollable: true,
                    splashBorderRadius: BorderRadius.circular(5.r),
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColors.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 16.sp),
                    tabs: List.generate(
                      AppCubit.get(context).sections.length,
                      (index) => Tab(
                        text: AppCubit.get(context).sections[index].title,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      AppCubit.get(context).sections.length,
                      (index) => const CustomMarketsListView(),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
