import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/service/cubit/app_cubit.dart';
import '../../../../../core/widgets/app_cached.dart';

class ProductImagesListView extends StatelessWidget {
  const ProductImagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SizedBox(
          height: 70.h,
          child: ListView.separated(
            itemCount: AppCubit.get(context).serviceImages.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) => InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppCubit.get(context).changeIsSwiperTab(index: index);
              },
              child: Container(
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: AppCubit.get(context).isTab == index
                      ? Border.all(
                          color: AppColors.primary,
                          width: 3.w,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5.r,
                      spreadRadius: 1.r,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: AppCachedImage(
                    image: AppCubit.get(context).serviceImages[index].image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
