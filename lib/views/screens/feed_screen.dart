import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/getxControllers/poetry_controller.dart';
import 'package:google_maps/controllers/utills/alert_dialog.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';
import 'package:google_maps/controllers/utills/app_textStyles.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';
import 'package:google_maps/views/screens/pending_poetry_screen.dart';
import 'package:google_maps/views/screens/poetry_screen.dart';
import 'package:google_maps/views/widgets/common_widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  RxString deviceId = "".obs;

  PoetryController poetryController = Get.put(PoetryController());

  @override
  void initState() {
    getDeviceId();
    super.initState();
  }

  getDeviceId() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId.value = androidInfo.id;
    poetryController.dataLength();
    await MySharedPreferences.setString('userId', deviceId.value);
  }

  GlobalKey<FormState> key = GlobalKey();
  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        onPressed: () {
          showCustomAlertDialog(context, key, deviceId.value);
        },
        child: Icon(Icons.add_to_photos_rounded),
      ),
      body: SafeArea(
        child: Container(
          height: mediaQuerySize.height.h,
          width: mediaQuerySize.width.w,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightBlueColor, AppColors.dartBlue],
          )),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('feedsPoetry').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      CommonWidgets.commonAppBar(mediaQuerySize, 'Poetry Feeds'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: mediaQuerySize.width * 0.01.w,
                                ),
                                SizedBox(
                                  width: mediaQuerySize.width * 0.2.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CommonWidgets.commonShimmer(
                                        Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(color: AppColors.blueColor, shape: BoxShape.circle),
                                          child: Center(
                                              child: Text(
                                            'A',
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: mediaQuerySize.width * 0.02.h,
                                      ),
                                      CommonWidgets.commonShimmer(
                                        Text(
                                          textAlign: TextAlign.center,
                                          'Ali',
                                        ),
                                      ),
                                      SizedBox(
                                        height: mediaQuerySize.width * 0.02.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQuerySize.width * 0.01.w,
                                ),
                                Expanded(
                                  child: CommonWidgets.commonShimmer(
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w, vertical: mediaQuerySize.height * 0.009.h),
                                      width: mediaQuerySize.width,
                                      decoration: BoxDecoration(
                                          backgroundBlendMode: BlendMode.srcOver,
                                          boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.1, blurRadius: 3)],
                                          border: Border.all(color: AppColors.white60Color, width: 0.5),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp), bottomRight: Radius.circular(12.sp)),
                                          color: AppColors.firstContainerColor),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.04.w, vertical: mediaQuerySize.height * 0.03.h),
                                            child: Text(
                                              'ye sub tera kram hy aqa, warna hym kia chez hyn',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4), child: CommonWidgets.timeAgoWidget('2 years ago')),
                                          CommonWidgets().actionButtonRow(
                                            mediaQuerySize: mediaQuerySize,
                                            actionText: '',
                                            likeLength: '',
                                            likes: true,
                                            favoriteColor: AppColors.redColor,
                                            isFavorite: true,
                                            likeOnTap: () {},
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No Poetry', style: AppTextstyles.simpleTextStyle()));
                }

                return Column(
                  children: [
                    Container(
                      height: mediaQuerySize.height * 0.075.h,
                      width: mediaQuerySize.width.w,
                      decoration: BoxDecoration(color: AppColors.blackColor12, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp), bottomRight: Radius.circular(10.sp))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(transition: Transition.upToDown, duration: Duration(milliseconds: 500), () => PendingPoetryScreen());
                                    },
                                    icon: Icon(
                                      Icons.sync,
                                      color: AppColors.amberColor,
                                    )),
                                Positioned(
                                  right: 8,
                                  bottom: 4,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                                    child: Center(child: Obx(() {
                                      return Text(
                                        poetryController.pendingPoetry.value.toString(),
                                        style: AppTextstyles.simpleTextStyle().copyWith(fontSize: 8, color: AppColors.blackColor),
                                      );
                                    })),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: Text('Poetry Feed', style: AppTextstyles.appBarTextStyle()),
                              ),
                            ),
                            Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                      transition: Transition.upToDown,
                                      duration: Duration(milliseconds: 500),
                                      () => PoetryScreen(
                                            name: '',
                                            isFavorite: true,
                                          ));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: AppColors.redColor,
                                    ),
                                    Positioned(
                                      child: Text(poetryController.data.length.toString(), style: AppTextstyles.simpleTextStyle().copyWith(fontSize: 10)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DateTime parsedTime = DateTime.parse(snapshot.data!.docs[index]['time']);
                        String timeAgo = timeago.format(parsedTime);

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mediaQuerySize.width * 0.01.w,
                            ),
                            SizedBox(
                              width: mediaQuerySize.width * 0.2.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: mediaQuerySize.height * 0.055.h,
                                    width: mediaQuerySize.width * 0.13.w,
                                    decoration: BoxDecoration(
                                        color: snapshot.data!.docs[index]['name'][0].toString().toLowerCase().contains(RegExp(r'[a-f]'))
                                            ? AppColors.firstContainerColor
                                            : snapshot.data!.docs[index]['name'][0].toString().toLowerCase().contains(RegExp(r'[g-j]'))
                                                ? AppColors.darkGreen
                                                : snapshot.data!.docs[index]['name'][0].toString().toLowerCase().contains(RegExp(r'[k-p]'))
                                                    ? AppColors.dartGrey
                                                    : snapshot.data!.docs[index]['name'][0].toString().toLowerCase().contains(RegExp(r'[q-v]'))
                                                        ? AppColors.purpleColor
                                                        : AppColors.darkRed,
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Text(
                                      snapshot.data?.docs[index]['name'][0],
                                      style: AppTextstyles.simpleTextStyle(),
                                    )),
                                  ),
                                  SizedBox(
                                    height: mediaQuerySize.width * 0.02.h,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data?.docs[index]['name'],
                                    style: AppTextstyles.simpleTextStyle(),
                                  ),
                                  SizedBox(
                                    height: mediaQuerySize.width * 0.02.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: mediaQuerySize.width * 0.01.w,
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w, vertical: mediaQuerySize.height * 0.009.h),
                                  width: mediaQuerySize.width,
                                  decoration: BoxDecoration(
                                      backgroundBlendMode: BlendMode.srcOver,
                                      boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.1, blurRadius: 3)],
                                      border: Border.all(color: AppColors.white60Color, width: 0.5),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12.sp), topRight: Radius.circular(12.sp), bottomRight: Radius.circular(12.sp)),
                                      color: AppColors.highlightedColor),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.04.w, vertical: mediaQuerySize.height * 0.03.h),
                                        child: Text(
                                          snapshot.data?.docs[index]['text'],
                                          textAlign: TextAlign.center,
                                          style: AppTextstyles.poetryTextStyle(),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5), child: CommonWidgets.timeAgoWidget(timeAgo)),
                                      Container(
                                        decoration: BoxDecoration(border: Border.all(color: AppColors.white60Color, width: 0.5), color: AppColors.blackColor12, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.sp), bottomRight: Radius.circular(10.sp))),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: mediaQuerySize.height * 0.01.h),
                                            child: CommonWidgets().actionButtonRow(
                                              mediaQuerySize: mediaQuerySize,
                                              actionText: snapshot.data?.docs[index]['text'],
                                              likeOnTap: () async {
                                                if (snapshot.data!.docs[index]['Likes'].toString().toLowerCase().contains(deviceId.value.toLowerCase())) {
                                                  await FirebaseFirestore.instance.collection('feedsPoetry').doc(snapshot.data!.docs[index].id).update({
                                                    'Likes': FieldValue.arrayRemove([deviceId.value]),
                                                  });
                                                  poetryController.data.remove(snapshot.data!.docs[index]['text']);
                                                  MySharedPreferences.setStringList('myList', poetryController.data);
                                                } else {
                                                  await FirebaseFirestore.instance.collection('feedsPoetry').doc(snapshot.data!.docs[index].id).update({
                                                    'Likes': FieldValue.arrayUnion([deviceId.value]), //
                                                  });
                                                  poetryController.data.add(snapshot.data!.docs[index]['text']);
                                                  MySharedPreferences.setStringList('myList', poetryController.data);
                                                }
                                              },
                                              likeLength: snapshot.data!.docs[index]['Likes'].length.toString(),
                                              isFavorite: true,
                                              likes: true,
                                              favoriteColor: snapshot.data!.docs[index]['Likes'].toString().toLowerCase().contains(deviceId.value.toLowerCase()) ? AppColors.redColor : AppColors.whiteColor,
                                            )),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        );
                      },
                    ))
                  ],
                );
              }),
        ),
      ),
    );
  }
}
