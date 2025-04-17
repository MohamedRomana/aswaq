// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/best_products_list_view.dart';
import 'widgets/custom-home_shimmer.dart';
import 'widgets/custom_connection_lost.dart';
import 'widgets/custom_home_app_bar.dart';
import 'widgets/markets_and_shops_list.dart';
import 'widgets/swiper_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    AppCubit.get(context).clientHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: state is ClientHomeLoading ||
                  AppCubit.get(context).clientHomeModel.isEmpty
              ? state is Timeoutt
                  ? const CustomConnectionLost()
                  : const CustomHomeShimmer()
              : SingleChildScrollView(
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
      },
    );
  }
}
