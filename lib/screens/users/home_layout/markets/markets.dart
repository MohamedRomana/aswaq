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
          preferredSize: Size.fromHeight(80.h),
          child: const CustomAppBar(isMarket: true)),
      body: DefaultTabController(
        initialIndex: 0,
        length: title.length,
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
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1.r,
                //     blurRadius: 5.r,
                //     offset: Offset(-1.r, 5.r),
                //   ),
                // ],
              ),
              child: TabBar(
                onTap: (index) {},
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
