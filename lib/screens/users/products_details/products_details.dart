// ignore_for_file: deprecated_member_use
import 'package:aswaq/core/service/cubit/app_cubit.dart';
import 'package:aswaq/core/widgets/custom_app_bar.dart';
import 'package:aswaq/core/widgets/custom_bottom_nav.dart';
import 'package:aswaq/screens/users/products_details/product_store/product_store.dart';
import 'package:aswaq/screens/users/products_details/rates/product_rates.dart';
import 'package:aswaq/screens/users/products_details/widgets/items_may_like.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../generated/locale_keys.g.dart';
import '../shop_screen/widgets/custom_bottom_sheet_load.dart';
import 'widgets/add_to_cart_row.dart';
import 'widgets/product_certificate.dart';
import 'widgets/product_desc.dart';
import 'widgets/product_title_price.dart';
import 'widgets/product_images_list_view.dart';
import 'widgets/products_swiper.dart';

class ProductDetailsBottomSheet extends StatefulWidget {
  final int id;
  const ProductDetailsBottomSheet({super.key, required this.id});

  @override
  State<ProductDetailsBottomSheet> createState() =>
      _ProductDetailsBottomSheetState();
}

class _ProductDetailsBottomSheetState extends State<ProductDetailsBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _overViewKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _storeKey = GlobalKey();
  final GlobalKey _descKey = GlobalKey();
  final GlobalKey _mayLikeKey = GlobalKey();
  final GlobalKey _addCartKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    AppCubit.get(context).showService(serviceId: widget.id.toString());
    AppCubit.get(context).hasCertificate = false;
    AppCubit.get(context).count = 1;
    AppCubit.get(context).isTab = 0;
    _tabController = TabController(length: 6, vsync: this);

    _scrollController.addListener(_handleScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    double offset = _scrollController.offset;

    _updateTabIndex(offset);
  }

  void _updateTabIndex(double offset) {
    final sections = [
      _overViewKey,
      _reviewsKey,
      _storeKey,
      _descKey,
      _mayLikeKey,
      _addCartKey
    ];

    for (int i = 0; i < sections.length; i++) {
      final context = sections[i].currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;

        if (position <= 200) {
          _tabController.animateTo(i);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return CustomBottomNav(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(80.h),
                child: CustomAppBar(
                  text: LocaleKeys.product_description.tr(),
                )),
            body: state is ShowServiceLoading
                ? const CustomBottomSheetLoading()
                : DefaultTabController(
                    length: 6,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            padding:
                                const EdgeInsetsDirectional.only(start: -50),
                            labelColor: AppColors.primary,
                            dividerColor: Colors.transparent,
                            indicatorColor: AppColors.primary,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                            onTap: (index) {
                              switch (index) {
                                case 0:
                                  _scrollToSection(_overViewKey);
                                  break;
                                case 1:
                                  _scrollToSection(_reviewsKey);
                                  break;
                                case 2:
                                  _scrollToSection(_storeKey);
                                  break;
                                case 3:
                                  _scrollToSection(_descKey);
                                  break;
                                case 4:
                                  _scrollToSection(_mayLikeKey);
                                  break;
                                case 5:
                                  _scrollToSection(_addCartKey);
                                  break;
                              }
                            },
                            tabs: [
                              Tab(
                                text: LocaleKeys.overview.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.rates.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.store.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.description.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.items_you_may_like.tr(),
                              ),
                              Tab(
                                text: LocaleKeys.purchase.tr(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    key: _overViewKey,
                                    child: const ProductSwiper(),
                                  ),
                                  const ProductImagesListView(),
                                  SizedBox(height: 20.h),
                                  const ProductTitlePrice(),
                                  Container(
                                    key: _reviewsKey,
                                    child: const ProductRates(),
                                  ),
                                  Container(
                                    key: _storeKey,
                                    child: const ProductStore(),
                                  ),
                                  Container(
                                    key: _descKey,
                                    child: const ProductDesc(),
                                  ),
                                  Container(
                                    key: _mayLikeKey,
                                    child: const ItemsMayLike(),
                                  ),
                                  Container(
                                    key: _addCartKey,
                                    child: const ProductCertificate(),
                                  ),
                                  AddToCartRow(widget: widget),
                                  SizedBox(height: 120.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
