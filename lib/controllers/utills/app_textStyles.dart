import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';

class AppTextstyles {
  static TextStyle appBarTextStyle() {
    return TextStyle(color: AppColors.whiteColor, fontFamily: 'boldFont', fontSize: 21.sp, fontWeight: FontWeight.bold);
  }

  static TextStyle simpleTextStyle() {
    return TextStyle(fontSize: 17.sp, color: AppColors.whiteColor, fontFamily: 'boldFont');
  }

  static TextStyle poetryTextStyle() {
    return TextStyle(fontFamily: 'boldFont', wordSpacing: 1, letterSpacing: 1, fontSize: 18, color: AppColors.whiteColor);
  }
}
