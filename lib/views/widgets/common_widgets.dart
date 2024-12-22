import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/getxControllers/poetry_controller.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';
import 'package:google_maps/controllers/utills/app_textStyles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidgets {
  PoetryController poetryController = Get.put(PoetryController());
  void shareToWhatsApp(String text) async {
    final whatsappUrl = 'https://wa.me/?text=$text';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      print('no luanched');
    }
  }

  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('ur');
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  Widget commonContainer({
    required String Poetrytext,
    required String actionData,
    required Size mediaQuerySize,
    required void Function()? likeOnTap,
    required String likeLength,
    required bool likes,
    required Color favoriteColor,
    required bool isFavorite,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.03.w, vertical: mediaQuerySize.height * 0.01.h),
      child: Container(
        decoration: BoxDecoration(backgroundBlendMode: BlendMode.srcOver, boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.1, blurRadius: 3)], color: AppColors.highlightedColor, borderRadius: BorderRadius.circular(10.sp)),
        child: Padding(
          padding: EdgeInsets.only(top: mediaQuerySize.height * 0.025.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.06.w, vertical: mediaQuerySize.height * 0.02.h),
                child: Text(textAlign: TextAlign.center, Poetrytext, style: AppTextstyles.poetryTextStyle()),
              ),
              Padding(
                padding: EdgeInsets.only(top: mediaQuerySize.height * 0.01.h),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white60Color, width: mediaQuerySize.width * 0.002.w),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp), bottomRight: Radius.circular(10.sp)),
                    color: AppColors.blackColor12,
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w, vertical: mediaQuerySize.height * 0.015.h),
                      child: CommonWidgets().actionButtonRow(
                        isFavorite: isFavorite,
                        favoriteColor: favoriteColor,
                        likeLength: likeLength,
                        likeOnTap: likeOnTap,
                        likes: likes,
                        mediaQuerySize: mediaQuerySize,
                        actionText: actionData,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget commonAppBar(Size mediaQuerySize, String AppbarText) {
    return Container(
      height: mediaQuerySize.height * 0.075.h,
      width: mediaQuerySize.width.w,
      decoration: BoxDecoration(color: AppColors.blackColor12, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp), bottomRight: Radius.circular(10.sp))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
              ),
              onPressed: () => Get.back(),
            ),
            Expanded(
              child: Center(
                child: Text(AppbarText, style: AppTextstyles.appBarTextStyle()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget commonShimmer(Widget child) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightedColor,
      child: child,
    );
  }

  static Widget commonFavoriteIcon(int length, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.favorite, color: AppColors.redColor),
          Positioned(
            child: Text(length.toString(), style: AppTextstyles.simpleTextStyle().copyWith(fontSize: 10.sp)),
          ),
        ],
      ),
    );
  }

  static Widget timeAgoWidget(String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.timelapse,
          color: AppColors.whiteColor,
          size: 9,
        ),
        SizedBox(
          width: 3,
        ),
        Text(time, style: AppTextstyles.simpleTextStyle().copyWith(fontSize: 8.sp))
      ],
    );
  }

  Widget actionButtonRow({required Size mediaQuerySize, required String actionText, required String likeLength, required bool likes, required Color favoriteColor, required bool isFavorite, required void Function()? likeOnTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.07.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: AppColors.whiteColor,
            onPressed: () {
              Fluttertoast.showToast(msg: 'Text copied');
              Clipboard.setData(ClipboardData(text: actionText));
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.whatsapp,
              color: AppColors.greenColor,
              size: mediaQuerySize.width * 0.07,
            ),
            onPressed: () {
              shareToWhatsApp(actionText);
            },
          ),
          IconButton(
              color: AppColors.whiteColor,
              onPressed: () {
                speak(actionText);
              },
              icon: const Icon(Icons.headphones)),
          Row(
            children: [
              isFavorite
                  ? GestureDetector(
                      onTap: likeOnTap,
                      child: Icon(
                        Icons.favorite,
                        color: favoriteColor,
                      ))
                  : SizedBox(),
              likes
                  ? Text(
                      likeLength,
                      style: AppTextstyles.simpleTextStyle().copyWith(fontSize: 15.sp),
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
