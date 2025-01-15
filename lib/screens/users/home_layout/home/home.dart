// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/best_products_list_view.dart';
import 'widgets/custom_home_app_bar.dart';
import 'widgets/markets_and_shops_list.dart';
import 'widgets/swiper_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHomeAppBar(),
            const SwiperContainer(),
            const MarketsAndShopsListView(),
            const BestProductsListView(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}

