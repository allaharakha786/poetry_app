import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';
import 'package:google_maps/controllers/utills/app_textStyles.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';
import 'package:google_maps/views/widgets/common_widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class PendingPoetryScreen extends StatefulWidget {
  PendingPoetryScreen({super.key});

  @override
  State<PendingPoetryScreen> createState() => _PendingPoetryScreenState();
}

RxString id = ''.obs;

class _PendingPoetryScreenState extends State<PendingPoetryScreen> {
  @override
  void initState() {
    getId();
    super.initState();
  }

  getId() async {
    id.value = await MySharedPreferences.getString('userId');
    print(id.value);
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return Container(
              height: mediaQuerySize.height.h,
              width: mediaQuerySize.width.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.lightBlueColor, AppColors.dartBlue],
              )),
              child: id.value.length >= 2
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('pendingFeeds').where('userId', isEqualTo: id.value).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Column(
                            children: [
                              CommonWidgets.commonAppBar(mediaQuerySize, 'Pending Poetry'),
                              Expanded(
                                child: CommonWidgets.commonShimmer(
                                  ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(backgroundBlendMode: BlendMode.srcOver, boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.3, blurRadius: 3)], color: AppColors.firstContainerColor, borderRadius: BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                                  child: Text(
                                                    'Ar',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 15),
                                                  child: Container(
                                                    decoration: BoxDecoration(color: AppColors.whiteColor, border: Border.all(color: AppColors.whiteColor, width: 0.5), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.sp), bottomRight: Radius.circular(10.sp))),
                                                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), child: SizedBox()),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Text(
                            'No pending poetry',
                            style: AppTextstyles.simpleTextStyle(),
                          ));
                        }
                        return Column(
                          children: [
                            CommonWidgets.commonAppBar(mediaQuerySize, 'Pending Poetry'),
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  DateTime parsedTime = DateTime.parse(snapshot.data?.docs[index]['time']);

                                  String timeAgo = timeago.format(parsedTime);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.03.w, vertical: mediaQuerySize.height * 0.01.h),
                                    child: Container(
                                      decoration: BoxDecoration(backgroundBlendMode: BlendMode.srcOver, boxShadow: [BoxShadow(color: AppColors.whiteColor, spreadRadius: 0.1, blurRadius: 3)], color: AppColors.firstContainerColor, borderRadius: BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: mediaQuerySize.height * 0.035.h),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.12.w, vertical: mediaQuerySize.height * 0.01.h),
                                              child: Text(snapshot.data?.docs[index]['text'], style: AppTextstyles.poetryTextStyle()),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.025.w, vertical: mediaQuerySize.height * 0.012.h),
                                              child: CommonWidgets.timeAgoWidget(timeAgo),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      })
                  : SizedBox());
        }),
      ),
    );
  }
}
