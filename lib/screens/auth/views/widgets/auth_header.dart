import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';

class CustomAuthHeader extends StatelessWidget {
  const CustomAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      padding: EdgeInsets.only(top: 64.w),
      child: Image.asset(Assets.img.logo.path),
    );
  }
}
