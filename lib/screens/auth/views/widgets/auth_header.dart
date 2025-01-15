import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      width: 188.w,
      margin: EdgeInsets.only(top: 90.w),
      child: Image.asset(
        Assets.img.logo.path,
        fit: BoxFit.fill,
      ),
    );
  }
}
