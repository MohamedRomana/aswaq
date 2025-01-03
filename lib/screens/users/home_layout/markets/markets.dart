import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/colors.dart';
import 'widgets/custom_markets_list_view.dart';

class Markets extends StatelessWidget {
  const Markets({super.key});

  @override
  Widget build(BuildContext context) {
    final List title = [
      'كل المحلات',
      'مطاعم',
      'محلات',
    ];
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: const CustomAppBar(isMarket: true)),
      body: DefaultTabController(
        initialIndex: 0,
        length: title.length,
        child: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(start: 16.w, bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: TabBar(
                onTap: (index) {},
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                splashBorderRadius: BorderRadius.circular(5.r),
                dividerColor: Colors.transparent,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(19.r),
                  border: Border.all(color: Colors.black),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 16.sp),
                tabs: List.generate(
                  title.length,
                  (index) => Tab(
                    text: title[index],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  title.length,
                  (index) => const CustomMarketsListView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
