import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/getxControllers/poetry_controller.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';
import 'package:google_maps/controllers/utills/app_textStyles.dart';
import 'package:google_maps/controllers/utills/data_list.dart';
import 'package:google_maps/views/screens/poetry_screen.dart';
import 'package:google_maps/views/widgets/common_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  bool isOffline;
  HomeScreen({super.key, required this.isOffline});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PoetryController poetryController = Get.put(PoetryController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(poetryController.data);
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: mediaQuerySize.height.h,
          width: mediaQuerySize.width.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.lightBlueColor, AppColors.dartBlue],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: mediaQuerySize.height * 0.075.h,
                    width: mediaQuerySize.width.w,
                    decoration: BoxDecoration(color: AppColors.blackColor12, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp), bottomRight: Radius.circular(10.sp))),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.02.w),
                        child: Row(children: [
                          Expanded(
                            child: Center(
                              child: Text(widget.isOffline ? 'Offline Poetry' : 'Online Poetry', style: AppTextstyles.appBarTextStyle()),
                            ),
                          ),
                          Obx(() {
                            return CommonWidgets.commonFavoriteIcon(
                              poetryController.data.length,
                              () {
                                Get.to(
                                    transition: Transition.upToDown,
                                    duration: Duration(milliseconds: 500),
                                    () => PoetryScreen(
                                          name: '',
                                          isFavorite: true,
                                        ));
                              },
                            );
                          }),
                        ]))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.02.w, vertical: mediaQuerySize.height * 0.015.h),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return GestureDetector(
                            onTap: () {
                              index == 0
                                  ? Get.to(
                                      transition: Transition.fade,
                                      duration: Duration(milliseconds: 500),
                                      () => PoetryScreen(
                                            isOffline: widget.isOffline,
                                            name: '',
                                            isSadPoetry: true,
                                          ))
                                  : index == 1
                                      ? Get.to(
                                          transition: Transition.fade,
                                          duration: Duration(milliseconds: 500),
                                          () => PoetryScreen(
                                                isOffline: widget.isOffline,
                                                name: '',
                                                isLovePoetry: true,
                                              ))
                                      : Get.to(
                                          transition: Transition.fade,
                                          duration: Duration(milliseconds: 500),
                                          () => PoetryScreen(
                                                isOffline: widget.isOffline,
                                                name: '',
                                                isFunnyPoetry: true,
                                              ));
                            },
                            child: Container(
                              width: mediaQuerySize.width.w,
                              height: mediaQuerySize.height * 0.4.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp), boxShadow: [BoxShadow(color: AppColors.blackColor12, spreadRadius: 0.2, blurRadius: 3)], border: Border.all(color: AppColors.whiteColor)),
                              child: Container(
                                width: mediaQuerySize.width.w,
                                height: mediaQuerySize.height * 0.4.h,
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.3, blurRadius: 3)],
                                    image: DecorationImage(fit: BoxFit.cover, image: AssetImage(widget.isOffline ? ListData.midImages[index] : ListData.onlineSliderImages[index])),
                                    borderRadius: BorderRadius.circular(12.sp)),
                                child: Container(
                                  width: mediaQuerySize.width.w,
                                  height: mediaQuerySize.height * 0.4.h,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp), color: AppColors.blackColor.withOpacity(0.8)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(ListData.title[index], style: AppTextstyles.simpleTextStyle().copyWith(fontSize: mediaQuerySize.width * 0.07.w)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: mediaQuerySize.height * 0.3.h,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: mediaQuerySize.height * 0.025.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.015.w),
                    child: Text(
                      'بہترین شعراء',
                      style: TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      ListData.poets.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.018.w, vertical: mediaQuerySize.height * 0.012.h),
                          child: GestureDetector(
                            onTap: () {
                              index == 0
                                  ? Get.to(
                                      transition: Transition.fade,
                                      duration: Duration(milliseconds: 500),
                                      () => PoetryScreen(
                                            isOffline: widget.isOffline,
                                            name: '',
                                            isMirzaGhalibPoetry: widget.isOffline ? false : true,
                                            isMirTakiMirPoetry: widget.isOffline ? true : false,
                                          ))
                                  : index == 1
                                      ? Get.to(
                                          transition: Transition.fade,
                                          duration: Duration(milliseconds: 500),
                                          () => PoetryScreen(
                                                isOffline: widget.isOffline,
                                                name: '',
                                                isShakirShujabadiPoetry: widget.isOffline ? false : true,
                                                isHasratMohaniPoetry: widget.isOffline ? true : false,
                                              ))
                                      : index == 2
                                          ? Get.to(
                                              transition: Transition.fade,
                                              duration: Duration(milliseconds: 500),
                                              () => PoetryScreen(
                                                    isRafiqKhawarPoetry: widget.isOffline ? true : false,
                                                    isOffline: widget.isOffline,
                                                    name: '',
                                                    isBollayShahPoetry: widget.isOffline ? false : true,
                                                  ))
                                          : index == 3
                                              ? Get.to(
                                                  transition: Transition.fade,
                                                  duration: Duration(milliseconds: 500),
                                                  () => PoetryScreen(
                                                        isSeharLodhanviPoetry: widget.isOffline ? true : false,
                                                        isOffline: widget.isOffline,
                                                        name: '',
                                                        isAhmadFrazPoetry: widget.isOffline ? false : true,
                                                      ))
                                              : index == 4
                                                  ? Get.to(
                                                      transition: Transition.fade,
                                                      duration: Duration(milliseconds: 500),
                                                      () => PoetryScreen(
                                                            isJoshAbadiPoetry: widget.isOffline ? true : false,
                                                            isOffline: widget.isOffline,
                                                            name: '',
                                                            isSachalSarmastPoetry: widget.isOffline ? false : true,
                                                          ))
                                                  : index == 5
                                                      ? Get.to(
                                                          transition: Transition.fade,
                                                          duration: Duration(milliseconds: 500),
                                                          () => PoetryScreen(
                                                                isShaheedBhagatPoetry: widget.isOffline ? true : false,
                                                                isOffline: widget.isOffline,
                                                                name: '',
                                                                isJhonEliaPoetry: widget.isOffline ? false : true,
                                                              ))
                                                      : index == 6
                                                          ? Get.to(
                                                              transition: Transition.fade,
                                                              duration: Duration(milliseconds: 500),
                                                              () => PoetryScreen(
                                                                    isAllamaIqbalPoetry: widget.isOffline ? true : false,
                                                                    isOffline: widget.isOffline,
                                                                    name: '',
                                                                    isKhawajaFareedPoetry: widget.isOffline ? false : true,
                                                                  ))
                                                          : index == 7
                                                              ? Get.to(
                                                                  transition: Transition.fade,
                                                                  duration: Duration(milliseconds: 500),
                                                                  () => PoetryScreen(
                                                                        isGorakpuriPoetry: widget.isOffline ? true : false,
                                                                        isOffline: widget.isOffline,
                                                                        name: '',
                                                                        isParveenShakirPoetry: widget.isOffline ? false : true,
                                                                      ))
                                                              : index == 8
                                                                  ? Get.to(
                                                                      transition: Transition.fade,
                                                                      duration: Duration(milliseconds: 500),
                                                                      () => PoetryScreen(
                                                                            isWarisShahPoetry: widget.isOffline ? true : false,
                                                                            isOffline: widget.isOffline,
                                                                            name: '',
                                                                            isAmjadIslamPoetry: widget.isOffline ? false : true,
                                                                          ))
                                                                  : index == 9
                                                                      ? Get.to(
                                                                          transition: Transition.fade,
                                                                          duration: Duration(milliseconds: 500),
                                                                          () => PoetryScreen(
                                                                                isRehmanBabaPoetry: true,
                                                                                isOffline: widget.isOffline,
                                                                                name: '',
                                                                              ))
                                                                      : index == 10
                                                                          ? Get.to(
                                                                              transition: Transition.fade,
                                                                              duration: Duration(milliseconds: 500),
                                                                              () => PoetryScreen(
                                                                                    isAmjadIslamPoetry: widget.isOffline ? true : false,
                                                                                    isOffline: widget.isOffline,
                                                                                    name: '',
                                                                                    isWarisShahPoetry: widget.isOffline ? false : true,
                                                                                  ))
                                                                          : index == 11
                                                                              ? Get.to(
                                                                                  transition: Transition.fade,
                                                                                  duration: Duration(milliseconds: 500),
                                                                                  () => PoetryScreen(
                                                                                        isParveenShakirPoetry: widget.isOffline ? true : false,
                                                                                        isOffline: widget.isOffline,
                                                                                        name: '',
                                                                                        isGorakpuriPoetry: widget.isOffline ? false : true,
                                                                                      ))
                                                                              : index == 12
                                                                                  ? Get.to(
                                                                                      transition: Transition.fade,
                                                                                      duration: Duration(milliseconds: 500),
                                                                                      () => PoetryScreen(
                                                                                            isKhawajaFareedPoetry: widget.isOffline ? true : false,
                                                                                            isOffline: widget.isOffline,
                                                                                            name: '',
                                                                                            isAllamaIqbalPoetry: widget.isOffline ? false : true,
                                                                                          ))
                                                                                  : index == 13
                                                                                      ? Get.to(
                                                                                          transition: Transition.fade,
                                                                                          duration: Duration(milliseconds: 500),
                                                                                          () => PoetryScreen(
                                                                                                isJhonEliaPoetry: widget.isOffline ? true : false,
                                                                                                isOffline: widget.isOffline,
                                                                                                name: '',
                                                                                                isShaheedBhagatPoetry: widget.isOffline ? false : true,
                                                                                              ))
                                                                                      : index == 14
                                                                                          ? Get.to(
                                                                                              transition: Transition.fade,
                                                                                              duration: Duration(milliseconds: 500),
                                                                                              () => PoetryScreen(
                                                                                                    isSachalSarmastPoetry: widget.isOffline ? true : false,
                                                                                                    isOffline: widget.isOffline,
                                                                                                    name: '',
                                                                                                    isJoshAbadiPoetry: widget.isOffline ? false : true,
                                                                                                  ))
                                                                                          : index == 15
                                                                                              ? Get.to(
                                                                                                  transition: Transition.fade,
                                                                                                  duration: Duration(milliseconds: 500),
                                                                                                  () => PoetryScreen(
                                                                                                        isAhmadFrazPoetry: widget.isOffline ? true : false,
                                                                                                        isOffline: widget.isOffline,
                                                                                                        name: '',
                                                                                                        isSeharLodhanviPoetry: widget.isOffline ? false : true,
                                                                                                      ))
                                                                                              : index == 16
                                                                                                  ? Get.to(
                                                                                                      transition: Transition.fade,
                                                                                                      duration: Duration(milliseconds: 500),
                                                                                                      () => PoetryScreen(
                                                                                                            isBollayShahPoetry: widget.isOffline ? true : false,
                                                                                                            isOffline: widget.isOffline,
                                                                                                            name: '',
                                                                                                            isRafiqKhawarPoetry: widget.isOffline ? false : true,
                                                                                                          ))
                                                                                                  : index == 17
                                                                                                      ? Get.to(
                                                                                                          transition: Transition.fade,
                                                                                                          duration: Duration(milliseconds: 500),
                                                                                                          () => PoetryScreen(
                                                                                                                isShakirShujabadiPoetry: widget.isOffline ? true : false,
                                                                                                                isOffline: widget.isOffline,
                                                                                                                name: '',
                                                                                                                isHasratMohaniPoetry: widget.isOffline ? false : true,
                                                                                                              ))
                                                                                                      : index == 18
                                                                                                          ? Get.to(
                                                                                                              transition: Transition.fade,
                                                                                                              duration: Duration(milliseconds: 500),
                                                                                                              () => PoetryScreen(
                                                                                                                    isOffline: widget.isOffline,
                                                                                                                    name: '',
                                                                                                                    isMirTakiMirPoetry: widget.isOffline ? false : true,
                                                                                                                  ))
                                                                                                          : '';
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: mediaQuerySize.height * 0.1.h,
                                  width: mediaQuerySize.width * 0.17.w,
                                  decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(widget.isOffline ? ListData.poetImages.reversed.toList()[index] : ListData.poetImages[index])), color: AppColors.blackColor, shape: BoxShape.circle),
                                ),
                                Text(widget.isOffline ? ListData.poets.reversed.toList()[index] : ListData.poets[index], style: AppTextstyles.simpleTextStyle().copyWith(fontSize: 14))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: mediaQuerySize.height * 0.015.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.015.w),
                    child: Text(
                      'مختلف زبانیں',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaQuerySize.width.w,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ListData.languageList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            index == 0
                                ? Get.to(
                                    transition: Transition.fade,
                                    duration: Duration(milliseconds: 500),
                                    () => PoetryScreen(
                                          isOffline: widget.isOffline,
                                          name: '',
                                          isUrduPoetry: true,
                                        ))
                                : index == 1
                                    ? Get.to(
                                        transition: Transition.fade,
                                        duration: Duration(milliseconds: 500),
                                        () => PoetryScreen(
                                              isOffline: widget.isOffline,
                                              name: '',
                                              isPunjabiPoetry: true,
                                            ))
                                    : index == 2
                                        ? Get.to(
                                            transition: Transition.fade,
                                            duration: Duration(milliseconds: 500),
                                            () => PoetryScreen(
                                                  isOffline: widget.isOffline,
                                                  name: '',
                                                  isSaraikiPoetry: true,
                                                ))
                                        : index == 3
                                            ? Get.to(
                                                transition: Transition.fade,
                                                duration: Duration(milliseconds: 500),
                                                () => PoetryScreen(
                                                      isOffline: widget.isOffline,
                                                      name: '',
                                                      isSindiPoetry: true,
                                                    ))
                                            : index == 4
                                                ? Get.to(
                                                    transition: Transition.fade,
                                                    duration: Duration(milliseconds: 500),
                                                    () => PoetryScreen(
                                                          isOffline: widget.isOffline,
                                                          name: '',
                                                          isPashtoPoetry: true,
                                                        ))
                                                : index == 5
                                                    ? Get.to(
                                                        transition: Transition.fade,
                                                        duration: Duration(milliseconds: 500),
                                                        () => PoetryScreen(
                                                              isOffline: widget.isOffline,
                                                              name: '',
                                                              isBalochiPoetry: true,
                                                            ))
                                                    : index == 6
                                                        ? Get.to(
                                                            transition: Transition.fade,
                                                            duration: Duration(milliseconds: 500),
                                                            () => PoetryScreen(
                                                                  isOffline: widget.isOffline,
                                                                  name: '',
                                                                  isKashmariPoetry: true,
                                                                ))
                                                        : index == 7
                                                            ? Get.to(
                                                                transition: Transition.fade,
                                                                duration: Duration(milliseconds: 500),
                                                                () => PoetryScreen(
                                                                      isOffline: widget.isOffline,
                                                                      name: '',
                                                                      isFarsiPoetry: true,
                                                                    ))
                                                            : '';
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.whiteColor.withOpacity(0.7)),
                                boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.3, blurRadius: 3)],
                                image: DecorationImage(opacity: widget.isOffline ? 1 : 0.7, colorFilter: const ColorFilter.mode(Color.fromARGB(170, 0, 0, 0), BlendMode.colorBurn), fit: BoxFit.cover, image: AssetImage(ListData.languageFlag[index])),
                                color: AppColors.blackColor,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Center(
                                child: Text(
                              ListData.languageList[index],
                              style: AppTextstyles.simpleTextStyle().copyWith(fontSize: mediaQuerySize.width * 0.06.w),
                            )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
