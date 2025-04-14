import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.w,
      width: 350.w,
      margin: EdgeInsetsDirectional.only(top: 50.h),
      child: Image.asset(
        Assets.img.logo.path,
        fit: BoxFit.fill,
      ),
    );
  }
}
