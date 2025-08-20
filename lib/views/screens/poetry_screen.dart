import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/getxControllers/poetry_controller.dart';
import 'package:google_maps/controllers/utills/app_colors.dart';
import 'package:google_maps/controllers/utills/app_textStyles.dart';
import 'package:google_maps/controllers/utills/data_list.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';
import 'package:google_maps/models/poetry_model.dart';
import 'package:google_maps/views/widgets/common_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class PoetryScreen extends StatefulWidget {
  bool isOffline;
  String name;

  bool isPunjabiPoetry;
  bool isUrduPoetry;
  bool isSaraikiPoetry;
  bool isSindiPoetry;
  bool isPashtoPoetry;
  bool isBalochiPoetry;
  bool isKashmariPoetry;
  bool isFarsiPoetry;

  bool isMirzaGhalibPoetry;
  bool isShakirShujabadiPoetry;
  bool isBollayShahPoetry;
  bool isAhmadFrazPoetry;
  bool isSachalSarmastPoetry;
  bool isJhonEliaPoetry;
  bool isKhawajaFareedPoetry;
  bool isParveenShakirPoetry;
  bool isAmjadIslamPoetry;
  bool isRehmanBabaPoetry;
  bool isWarisShahPoetry;
  bool isGorakpuriPoetry;
  bool isAllamaIqbalPoetry;
  bool isShaheedBhagatPoetry;
  bool isJoshAbadiPoetry;
  bool isSeharLodhanviPoetry;
  bool isRafiqKhawarPoetry;
  bool isHasratMohaniPoetry;
  bool isMirTakiMirPoetry;
  bool isFunnyPoetry;
  bool isLovePoetry;
  bool isSadPoetry;
  bool isFavorite;

  PoetryScreen({
    super.key,
    required this.name,
    this.isOffline = false,
    this.isLovePoetry = false,
    this.isFavorite = false,
    this.isSadPoetry = false,
    this.isFunnyPoetry = false,
    this.isMirzaGhalibPoetry = false,
    this.isShakirShujabadiPoetry = false,
    this.isBollayShahPoetry = false,
    this.isAhmadFrazPoetry = false,
    this.isSachalSarmastPoetry = false,
    this.isJhonEliaPoetry = false,
    this.isKhawajaFareedPoetry = false,
    this.isParveenShakirPoetry = false,
    this.isAmjadIslamPoetry = false,
    this.isRehmanBabaPoetry = false,
    this.isWarisShahPoetry = false,
    this.isGorakpuriPoetry = false,
    this.isAllamaIqbalPoetry = false,
    this.isShaheedBhagatPoetry = false,
    this.isJoshAbadiPoetry = false,
    this.isSeharLodhanviPoetry = false,
    this.isRafiqKhawarPoetry = false,
    this.isHasratMohaniPoetry = false,
    this.isMirTakiMirPoetry = false,
    this.isUrduPoetry = false,
    this.isPunjabiPoetry = false,
    this.isSaraikiPoetry = false,
    this.isSindiPoetry = false,
    this.isPashtoPoetry = false,
    this.isBalochiPoetry = false,
    this.isKashmariPoetry = false,
    this.isFarsiPoetry = false,
  });

  @override
  State<PoetryScreen> createState() => _PoetryScreenState();
}

class _PoetryScreenState extends State<PoetryScreen> {
  late BannerAd _bannerAd;

  RxBool _isAdLoaded = false.obs;

  RxList<PoetryModel> poetryList = <PoetryModel>[].obs;

  RxList<QueryDocumentSnapshot<Object?>?> firebasePoetry = <QueryDocumentSnapshot<Object?>>[].obs;

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/9214589741', // Replace with your Ad Unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          _isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
    addingIslikedList();
    // addingFav();
    addingList();

    super.initState();
  }

  PoetryController poetryController = Get.put(PoetryController());

  RxList<bool> isLiked = <bool>[].obs;
  RxList<bool> isLikedOffline = <bool>[].obs;

  addingFav() {
    for (var i = 0; i < poetryList.length; i++) {
      isLiked.add(poetryList[i].isFavorite);
    }
  }

  addingIslikedList() {
    List.generate(
      1000,
      (index) => isLiked.add(false),
    );
  }

  addingList() {
    List.generate(
      1000,
      (index) => isLikedOffline.add(false),
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int valueLength() {
      return widget.isLovePoetry
          ? ListData.lovePoetry.length
          : widget.isSadPoetry
              ? ListData.sadPoetry.length
              : widget.isFunnyPoetry
                  ? ListData.funnyPoetry.length
                  : widget.isMirTakiMirPoetry
                      ? ListData.mirTaqiMirPoetry.length
                      : widget.isHasratMohaniPoetry
                          ? ListData.hasratMohaniPoetry.length
                          : widget.isRafiqKhawarPoetry
                              ? ListData.rafiqKhawarPoetry.length
                              : widget.isSeharLodhanviPoetry
                                  ? ListData.hasratLadahnviPoetry.length
                                  : widget.isJoshAbadiPoetry
                                      ? ListData.joshMalihabadiPoetry.length
                                      : widget.isShaheedBhagatPoetry
                                          ? ListData.shaheedBhagatSinghPoetry.length
                                          : widget.isAllamaIqbalPoetry
                                              ? ListData.allamaIqbalPoetry.length
                                              : widget.isGorakpuriPoetry
                                                  ? ListData.firaqGorakhpuriPoetry.length
                                                  : widget.isWarisShahPoetry
                                                      ? ListData.warisShahPoetry.length
                                                      : widget.isRehmanBabaPoetry
                                                          ? ListData.rehmanBabaPoetry.length
                                                          : widget.isAmjadIslamPoetry
                                                              ? ListData.amjadIslamAmjadPoetry.length
                                                              : widget.isParveenShakirPoetry
                                                                  ? ListData.parveenShakirPoetry.length
                                                                  : widget.isKhawajaFareedPoetry
                                                                      ? ListData.khawajaFareedPoetry.length
                                                                      : widget.isJhonEliaPoetry
                                                                          ? ListData.johnEliaPoetry.length
                                                                          : widget.isSachalSarmastPoetry
                                                                              ? ListData.sachalSarmastPoetry.length
                                                                              : widget.isAhmadFrazPoetry
                                                                                  ? ListData.ahmadFarazPoetry.length
                                                                                  : widget.isBollayShahPoetry
                                                                                      ? ListData.bullahShahPoetry.length
                                                                                      : widget.isShakirShujabadiPoetry
                                                                                          ? ListData.shakirShujaAbadiSaraikiPoetry.length
                                                                                          : widget.isMirzaGhalibPoetry
                                                                                              ? ListData.mirzaGhalibPoetry.length
                                                                                              : widget.isUrduPoetry
                                                                                                  ? ListData.urduPoetry.length
                                                                                                  : widget.isPunjabiPoetry
                                                                                                      ? ListData.punjabiPoetry.length
                                                                                                      : widget.isSaraikiPoetry
                                                                                                          ? ListData.saraikiPoetry.length
                                                                                                          : widget.isSindiPoetry
                                                                                                              ? ListData.sindhiPoetry.length
                                                                                                              : widget.isPashtoPoetry
                                                                                                                  ? ListData.pashtoPoetry.length
                                                                                                                  : widget.isBalochiPoetry
                                                                                                                      ? ListData.balochiPoetry.length
                                                                                                                      : widget.isKashmariPoetry
                                                                                                                          ? ListData.kashmiriPoetry.length
                                                                                                                          : widget.isFarsiPoetry
                                                                                                                              ? ListData.farsiPoetry.length
                                                                                                                              : 0;
    }

    String listText(int i) {
      return widget.isLovePoetry
          ? ListData.lovePoetry[i]
          : widget.isSadPoetry
              ? ListData.sadPoetry[i]
              : widget.isFunnyPoetry
                  ? ListData.funnyPoetry[i]
                  : widget.isMirTakiMirPoetry
                      ? ListData.mirTaqiMirPoetry[i]
                      : widget.isHasratMohaniPoetry
                          ? ListData.hasratMohaniPoetry[i]
                          : widget.isRafiqKhawarPoetry
                              ? ListData.rafiqKhawarPoetry[i]
                              : widget.isSeharLodhanviPoetry
                                  ? ListData.hasratLadahnviPoetry[i]
                                  : widget.isJoshAbadiPoetry
                                      ? ListData.joshMalihabadiPoetry[i]
                                      : widget.isShaheedBhagatPoetry
                                          ? ListData.shaheedBhagatSinghPoetry[i]
                                          : widget.isAllamaIqbalPoetry
                                              ? ListData.allamaIqbalPoetry[i]
                                              : widget.isGorakpuriPoetry
                                                  ? ListData.firaqGorakhpuriPoetry[i]
                                                  : widget.isWarisShahPoetry
                                                      ? ListData.warisShahPoetry[i]
                                                      : widget.isRehmanBabaPoetry
                                                          ? ListData.rehmanBabaPoetry[i]
                                                          : widget.isAmjadIslamPoetry
                                                              ? ListData.amjadIslamAmjadPoetry[i]
                                                              : widget.isParveenShakirPoetry
                                                                  ? ListData.parveenShakirPoetry[i]
                                                                  : widget.isKhawajaFareedPoetry
                                                                      ? ListData.khawajaFareedPoetry[i]
                                                                      : widget.isJhonEliaPoetry
                                                                          ? ListData.johnEliaPoetry[i]
                                                                          : widget.isSachalSarmastPoetry
                                                                              ? ListData.sachalSarmastPoetry[i]
                                                                              : widget.isAhmadFrazPoetry
                                                                                  ? ListData.ahmadFarazPoetry[i]
                                                                                  : widget.isBollayShahPoetry
                                                                                      ? ListData.bullahShahPoetry[i]
                                                                                      : widget.isShakirShujabadiPoetry
                                                                                          ? ListData.shakirShujaAbadiSaraikiPoetry[i]
                                                                                          : widget.isMirzaGhalibPoetry
                                                                                              ? ListData.mirzaGhalibPoetry[i]
                                                                                              : widget.isUrduPoetry
                                                                                                  ? ListData.urduPoetry[i]
                                                                                                  : widget.isPunjabiPoetry
                                                                                                      ? ListData.punjabiPoetry[i]
                                                                                                      : widget.isSaraikiPoetry
                                                                                                          ? ListData.saraikiPoetry[i]
                                                                                                          : widget.isSindiPoetry
                                                                                                              ? ListData.sindhiPoetry[i]
                                                                                                              : widget.isPashtoPoetry
                                                                                                                  ? ListData.pashtoPoetry[i]
                                                                                                                  : widget.isBalochiPoetry
                                                                                                                      ? ListData.balochiPoetry[i]
                                                                                                                      : widget.isKashmariPoetry
                                                                                                                          ? ListData.kashmiriPoetry[i]
                                                                                                                          : widget.isFarsiPoetry
                                                                                                                              ? ListData.farsiPoetry[i]
                                                                                                                              : [][i];
    }

    for (var i = 0; i < valueLength(); i++) {
      String poetryText = listText(i);
      bool isFavorite = poetryController.data.contains(poetryText);
      isLikedOffline[i] = isFavorite;
    }

    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: widget.isFavorite
          ? Container(
              height: mediaQuerySize.height.h,
              width: mediaQuerySize.width.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.lightBlueColor, AppColors.dartBlue],
              )),
              child: Column(children: [
                CommonWidgets.commonAppBar(mediaQuerySize, 'پسندیدہ شاعری'),
                Expanded(
                    child: ListView.builder(
                  itemCount: poetryController.data.length,
                  itemBuilder: (context, index) {
                    return CommonWidgets().commonContainer(Poetrytext: poetryController.data[index], actionData: poetryController.data[index], mediaQuerySize: mediaQuerySize, likeOnTap: () {}, likeLength: '', likes: false, favoriteColor: AppColors.amberColor, isFavorite: false);
                  },
                ))
              ]),
            )
          : widget.isOffline
              ? Container(
                  height: mediaQuerySize.height,
                  width: mediaQuerySize.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.lightBlueColor, AppColors.dartBlue],
                  )),
                  child: Column(
                    children: [
                      CommonWidgets.commonAppBar(mediaQuerySize, appBarText()),
                      Expanded(
                          child: ListView.builder(
                        itemCount: valueLength(),
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return CommonWidgets().commonContainer(
                                Poetrytext: listText(index),
                                actionData: listText(index),
                                mediaQuerySize: mediaQuerySize,
                                likeOnTap: () {
                                  isLikedOffline[index] = !isLikedOffline[index];

                                  if (isLikedOffline[index]) {
                                    poetryController.data.add(listText(index));
                                  } else {
                                    poetryController.data.remove(listText(index));
                                  }
                                  MySharedPreferences.setStringList('myList', poetryController.data);
                                  poetryController.data.value = MySharedPreferences.getStringList('myList');
                                },
                                likeLength: '',
                                likes: true,
                                favoriteColor: isLikedOffline[index] ? AppColors.redColor : AppColors.whiteColor,
                                isFavorite: true);
                          });
                        },
                      ))
                    ],
                  ),
                )
              : Container(
                  height: mediaQuerySize.height,
                  width: mediaQuerySize.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.lightBlueColor, AppColors.dartBlue],
                  )),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('poetry')
                          .doc('zhQPUkItQTy12bEEfdRQ')
                          .collection(widget.isPunjabiPoetry
                              ? 'punjabiPoetry'
                              : widget.isUrduPoetry
                                  ? "urduPoetry"
                                  : widget.isSaraikiPoetry
                                      ? "saraikiPoetry"
                                      : widget.isSindiPoetry
                                          ? "sindhiPoetry"
                                          : widget.isPashtoPoetry
                                              ? "pashtoPoetry"
                                              : widget.isBalochiPoetry
                                                  ? "balochiPoetry"
                                                  : widget.isKashmariPoetry
                                                      ? "KashmiriPoetry"
                                                      : widget.isFarsiPoetry
                                                          ? "farsiPoetry"
                                                          : widget.isSadPoetry
                                                              ? "sadPoetry"
                                                              : widget.isFarsiPoetry
                                                                  ? "farsiPoetry"
                                                                  : widget.isMirzaGhalibPoetry
                                                                      ? "mirzaGhalib"
                                                                      : widget.isShakirShujabadiPoetry
                                                                          ? "shakirShujabadi"
                                                                          : widget.isBollayShahPoetry
                                                                              ? "bullayShah"
                                                                              : widget.isAhmadFrazPoetry
                                                                                  ? "ahmadFraz"
                                                                                  : widget.isSachalSarmastPoetry
                                                                                      ? "sachalSarmast"
                                                                                      : widget.isJhonEliaPoetry
                                                                                          ? "jhonElia"
                                                                                          : widget.isKhawajaFareedPoetry
                                                                                              ? "khawjaFareed"
                                                                                              : widget.isParveenShakirPoetry
                                                                                                  ? "parveenShakir"
                                                                                                  : widget.isAmjadIslamPoetry
                                                                                                      ? "amjadIslam"
                                                                                                      : widget.isRehmanBabaPoetry
                                                                                                          ? "rehmanBaba"
                                                                                                          : widget.isWarisShahPoetry
                                                                                                              ? "warisShah"
                                                                                                              : widget.isGorakpuriPoetry
                                                                                                                  ? "fraqGorakPuri"
                                                                                                                  : widget.isAllamaIqbalPoetry
                                                                                                                      ? "allamaIqbal"
                                                                                                                      : widget.isShaheedBhagatPoetry
                                                                                                                          ? "shaheedBhagat"
                                                                                                                          : widget.isJoshAbadiPoetry
                                                                                                                              ? "joshMilheAbadi"
                                                                                                                              : widget.isSeharLodhanviPoetry
                                                                                                                                  ? "sahirLodhanvi"
                                                                                                                                  : widget.isRafiqKhawarPoetry
                                                                                                                                      ? "rafiqKhawar"
                                                                                                                                      : widget.isHasratMohaniPoetry
                                                                                                                                          ? "hasratMohanvi"
                                                                                                                                          : widget.isMirTakiMirPoetry
                                                                                                                                              ? "mirTakiMir"
                                                                                                                                              : widget.isSadPoetry
                                                                                                                                                  ? "sadPoetry"
                                                                                                                                                  : widget.isLovePoetry
                                                                                                                                                      ? "lovePoetry"
                                                                                                                                                      : widget.isFunnyPoetry
                                                                                                                                                          ? "funnyPoetry"
                                                                                                                                                          : '') // Sub-collection name
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Column(
                            children: [
                              CommonWidgets.commonAppBar(mediaQuerySize, appBarText()),
                              Expanded(
                                child: CommonWidgets.commonShimmer(ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return CommonWidgets().commonContainer(Poetrytext: '', actionData: '', mediaQuerySize: mediaQuerySize, likeOnTap: () {}, likeLength: '', likes: false, favoriteColor: AppColors.redColor, isFavorite: false);
                                  },
                                )),
                              )
                            ],
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                              child: Text(
                            'No Data',
                            style: AppTextstyles.simpleTextStyle(),
                          ));
                        }

                        for (var i = 0; i < (snapshot.data?.docs.length ?? 0); i++) {
                          String poetryText = snapshot.data?.docs[i]['text'];
                          bool isFavorite = poetryController.data.contains(poetryText);
                          poetryList.add(PoetryModel(text: poetryText, isFavorite: isFavorite));
                          isLiked[i] = isFavorite;

                          print(isFavorite);
                        }

                        return Column(
                          children: [
                            CommonWidgets.commonAppBar(mediaQuerySize, appBarText()),
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  firebasePoetry.value = snapshot.data?.docs ?? [];
                                  var snapshotData = snapshot.data?.docs[index];

                                  return Obx(() {
                                    return CommonWidgets().commonContainer(
                                        Poetrytext: snapshotData?['text'],
                                        actionData: snapshotData?['text'],
                                        mediaQuerySize: mediaQuerySize,
                                        likeOnTap: () {
                                          isLiked[index] = !isLiked[index];
                                          poetryList[index].isFavorite = !poetryList[index].isFavorite;
                                          if (poetryList[index].isFavorite) {
                                            poetryController.data.add(poetryList[index].text);
                                          } else {
                                            poetryController.data.remove(poetryList[index].text);
                                          }
                                          MySharedPreferences.setStringList('myList', poetryController.data);
                                          poetryController.data.value = MySharedPreferences.getStringList('myList');
                                        },
                                        likeLength: '',
                                        likes: false,
                                        favoriteColor: isLiked[index] ? AppColors.redColor : AppColors.whiteColor,
                                        isFavorite: true);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                ),
      // bottomNavigationBar: widget.isOffline
      //     ? SizedBox()
      //     : widget.isFavorite
      //         ? SizedBox()
      //         : _isAdLoaded.value
      //             ? SizedBox(
      //                 height: _bannerAd.size.height.toDouble(),
      //                 width: _bannerAd.size.width.toDouble(),
      //                 child: AdWidget(ad: _bannerAd),
      //               )
      //             : SizedBox()
    ));
  }

  String appBarText() {
    return widget.isSadPoetry
        ? 'اداس شاعری'
        : widget.isLovePoetry
            ? 'محبت کی شاعری'
            : widget.isFunnyPoetry
                ? 'مزاحیہ شاعری'
                : widget.isSeharLodhanviPoetry
                    ? 'سہیر لدھیانوی'
                    : widget.isMirzaGhalibPoetry
                        ? "مرزا غالب"
                        : widget.isShakirShujabadiPoetry
                            ? "شاکر شجاع آبادی"
                            : widget.isBollayShahPoetry
                                ? "بلھے شاہ"
                                : widget.isAhmadFrazPoetry
                                    ? 'احمد فراز'
                                    : widget.isSachalSarmastPoetry
                                        ? "سچل سرمست"
                                        : widget.isJhonEliaPoetry
                                            ? "جون ایلیا"
                                            : widget.isKhawajaFareedPoetry
                                                ? "خواجہ فرید"
                                                : widget.isParveenShakirPoetry
                                                    ? "پروین شاکر"
                                                    : widget.isAmjadIslamPoetry
                                                        ? "امجد اسلام امجد"
                                                        : widget.isRehmanBabaPoetry
                                                            ? "رحمان بابا"
                                                            : widget.isWarisShahPoetry
                                                                ? "وارث شاہ"
                                                                : widget.isGorakpuriPoetry
                                                                    ? "فراق گورکھپوری"
                                                                    : widget.isAllamaIqbalPoetry
                                                                        ? "علامہ محمد اقبال"
                                                                        : widget.isShaheedBhagatPoetry
                                                                            ? "شہید بھگت"
                                                                            : widget.isJoshAbadiPoetry
                                                                                ? "جوش ملیح آبادی"
                                                                                : widget.isRafiqKhawarPoetry
                                                                                    ? " رفیق خاور"
                                                                                    : widget.isHasratMohaniPoetry
                                                                                        ? "حسرت موہانی"
                                                                                        : widget.isMirTakiMirPoetry
                                                                                            ? "میر تقی میر"
                                                                                            : widget.isUrduPoetry
                                                                                                ? 'اردو شاعری'
                                                                                                : widget.isPunjabiPoetry
                                                                                                    ? 'پنجابی شاعری'
                                                                                                    : widget.isSaraikiPoetry
                                                                                                        ? 'سرائیکی شاعری'
                                                                                                        : widget.isSindiPoetry
                                                                                                            ? 'سندھی شاعری'
                                                                                                            : widget.isPashtoPoetry
                                                                                                                ? 'پشتو'
                                                                                                                : widget.isBalochiPoetry
                                                                                                                    ? 'بلوچی'
                                                                                                                    : widget.isKashmariPoetry
                                                                                                                        ? 'کشمیری'
                                                                                                                        : widget.isFarsiPoetry
                                                                                                                            ? 'فارسی'
                                                                                                                            : '';
  }
}
