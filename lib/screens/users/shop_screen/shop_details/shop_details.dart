import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_shimmer.dart';
import 'widgets/shop_details_shimmer.dart';
import 'widgets/store_products.dart';
import 'widgets/store_profile.dart';
import 'widgets/store_rates_row.dart';

class ShopDetails extends StatefulWidget {
  final int id;
  const ShopDetails({super.key, required this.id});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  void initState() {
    AppCubit.get(context).showProvider(providerId: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomNav(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return state is ShowProviderLoading
              ? const CustomShimmer(
                  child: ShopDetailsShimmer(),
                )
              : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StoreProfile(),
                      const StoreRatesRow(),
                      const StoreProducts(),
                      SizedBox(height: 120.h),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

