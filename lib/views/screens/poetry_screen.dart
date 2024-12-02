import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps/models/poetry_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class PoetryScreen extends StatefulWidget {
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

  PoetryScreen({
    super.key,
    required this.name,
    this.isLovePoetry = false,
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

void shareToWhatsApp(String text) async {
  final encodedText = Uri.encodeComponent(text);
  final whatsappUrl = "whatsapp://send?text=$encodedText";

  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {}
}

class _PoetryScreenState extends State<PoetryScreen> {
  late BannerAd _bannerAd;
  RxBool _isAdLoaded = false.obs;
  List<String> punjabiPoetry = ["دل کرے توں نال بہاراں وانگوں وسدا رہویں", "ساڈے خواباں دے وچ تیرا ہی ذکر رہندا اے", "وقت بدلدا اے، پر پیار دا رنگ کدے نہیں بدلدا", "محبتاں دے نال جے دل جوڑ لیا، تے ہر دکھ دور ہو جاندا اے", "تینوں دیکھ کے ساڈا دل خوش ہو جاندا اے، ہن سجنا توں ہسدے رہیں"];
  List<String> saraikiPoetry = ["مکھڑا اک شوہن دا تاں سجن توں دور تھی ونجساں", "توں تے ونج میڈی اکھ دے سامنے توں تے ونج", "مینوں کوں توں ول نہ یار میڈی جندڑی وی تمبو وانگوں ٹرئی ویسی", "سجن توں دور تھیونڑ اکھیاں دے ہنجوں رل گئے", "جندڑی ڈاڈھی کوجھ تیرا وی آں کوجھ میڈا وی آں"];

  RxList<PoetryModel> poetryList = <PoetryModel>[].obs;

  List<String> urduPoetry = [
    "دل ہی تو ہے نہ سنگ و خشت، درد سے بھر نہ آئے کیوں روئیں گے ہم ہزار بار، کوئی ہمیں ستائے کیوں محبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلےمحبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلے  ",
    "محبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلے",
    "دل ہی تو ہے نہ سنگ و خشت، درد سے بھر نہ آئے کیوں روئیں گے ہم ہزار بار، کوئی ہمیں ستائے کیوں محبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلےمحبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلے  ",
    "دل ہی تو ہے نہ سنگ و خشت، درد سے بھر نہ آئے کیوں روئیں گے ہم ہزار بار، کوئی ہمیں ستائے کیوں محبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلےمحبت میں نہیں ہے فرق جینے اور مرنے کا اسی کو دیکھ کر جیتے ہیں، جس کافر پہ دم نکلے  ",
    "ہزاروں خواہشیں ایسی کہ ہر خواہش پہ دم نکلے بہت نکلے میرے ارمان لیکن پھر بھی کم نکلے"
  ];

  RxList<QueryDocumentSnapshot<Object?>?> firebasePoetry = <QueryDocumentSnapshot<Object?>>[].obs;

  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('ur');
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  List<String> data = MySharedPreferences.getStringList('myList');

  @override
  void initState() {
    addingFav();
    addingList();

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
    super.initState();
  }

  RxList<bool> isLiked = <bool>[].obs;

  addingFav() {
    for (var i = 0; i < poetryList.length; i++) {
      isLiked.add(poetryList[i].isFavorite);
    }
  }

  addingList() {
    List.generate(
      urduPoetry.length,
      (index) => isLiked.add(false),
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('poetry')
                    .doc('zhQPUkItQTy12bEEfdRQ') // Fixed document ID
                    .collection('punjabiPoetry') // Sub-collection name
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No Data'));
                  }

                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    String poetryText = snapshot.data!.docs[i]['text']; // The text of the poetry from Firestore
                    bool isFavorite = data.contains(poetryText); // Check if it exists in the shared
                    poetryList.add(PoetryModel(text: poetryText, isFavorite: isFavorite));
                    isLiked[i] = isFavorite;

                    print(isFavorite);
                  }

                  return Column(
                    children: [
                      Container(
                        height: mediaQuerySize.height * 0.075.h,
                        width: mediaQuerySize.width.w,
                        decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back_ios_new),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    widget.isSadPoetry
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
                                                                                                                                ? 'اردو'
                                                                                                                                : widget.isPunjabiPoetry
                                                                                                                                    ? 'پنجابی'
                                                                                                                                    : widget.isSaraikiPoetry
                                                                                                                                        ? 'سرائیکی'
                                                                                                                                        : widget.isSindiPoetry
                                                                                                                                            ? 'سندھی'
                                                                                                                                            : widget.isPashtoPoetry
                                                                                                                                                ? 'پشتو'
                                                                                                                                                : widget.isBalochiPoetry
                                                                                                                                                    ? 'بلوچی'
                                                                                                                                                    : widget.isKashmariPoetry
                                                                                                                                                        ? 'کشمیری'
                                                                                                                                                        : widget.isFarsiPoetry
                                                                                                                                                            ? 'فارسی'
                                                                                                                                                            : '',
                                    style: const TextStyle(color: Colors.black87, fontFamily: 'boldFont', fontSize: 21, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mediaQuerySize.width * 0
                                  ..w,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            firebasePoetry.value = snapshot.data!.docs;

                            // for (var i = 0; i < snapshot.data!.docs.length; i++) {
                            //   // for (var da in data) {
                            //   //   print(da);
                            //   //   // if (da.toLowerCase().contains(snapshot.data!.docs[i]['text'].toString().toLowerCase())) {
                            //   //   //   likedpPoetry[i] == true;
                            //   //   // }
                            //   // }
                            //   // print('liked poetry is: ${likedpPoetry}');

                            //   // poetryList.add(PoetryModel(text: snapshot.data!.docs[i]['text'], isFavorite: likedpPoetry[i]));
                            // }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(backgroundBlendMode: BlendMode.srcOver, boxShadow: const [BoxShadow(color: Colors.black, spreadRadius: 0.1, blurRadius: 3)], color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                        child: Text(
                                          poetryList[index].text,
                                          style: const TextStyle(fontFamily: 'boldFont', fontSize: 19, letterSpacing: 2, wordSpacing: 2),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Obx(() {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Container(
                                            decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Fluttertoast.showToast(msg: 'Text copied');
                                                      Clipboard.setData(ClipboardData(text: punjabiPoetry[index]));
                                                    },
                                                    icon: const Icon(Icons.copy),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      FontAwesomeIcons.whatsapp,
                                                      color: Colors.green,
                                                      size: mediaQuerySize.width * 0.07,
                                                    ),
                                                    onPressed: () {
                                                      shareToWhatsApp(punjabiPoetry[index]);
                                                    },
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        speak(punjabiPoetry[index]);
                                                      },
                                                      icon: const Icon(Icons.headphones)),
                                                  GestureDetector(
                                                      onTap: () {
                                                        isLiked[index] = !isLiked[index];
                                                        poetryList[index].isFavorite = !poetryList[index].isFavorite;
                                                        if (poetryList[index].isFavorite) {
                                                          data.add(poetryList[index].text);
                                                        } else {
                                                          data.remove(poetryList[index].text);
                                                        }
                                                        MySharedPreferences.setStringList('myList', data);
                                                        data = MySharedPreferences.getStringList('myList');
                                                        // print();
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: isLiked[index] ? Colors.red : Colors.black,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
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
                }),
            bottomNavigationBar:
                // _isAdLoaded.value
                //     ?
                SizedBox(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
            // : const SizedBox()
            ));
  }
}
