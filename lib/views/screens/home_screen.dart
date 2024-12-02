import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';
import 'package:google_maps/views/screens/poetry_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void shareToWhatsApp(String text) async {
    final encodedText = Uri.encodeComponent(text);
    final whatsappUrl = "whatsapp://send?text=$encodedText";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {}
  }

  List<String> catagoryImages = ['assets/images/sad_background.jpg', 'assets/images/love_background.jpg', 'assets/images/funny_background.png'];
  List<String> poets = [
    "مرزا غالب",
    "شاکر شجاع آبادی",
    "بلھے شاہ",
    'احمد فراز',
    "سچل سرمست",
    "جون ایلیا",
    "خواجہ فرید",
    'پروین شاکر',
    'امجد اسلام امجد',
    "رحمان بابا",
    "وارث شاہ",
    "فراق گورکھپوری",
    "علامہ محمد اقبال",
    "شہید بھگت",
    "جوش ملیح آبادی",
    "ساحر لدھیانوی",
    "رفیق خاور",
    "حسرت موہانی",
    "میر تقی میر",
  ];
  List<String> poetImages = [
    'assets/images/mirza_ghalib_image.jpg',
    'assets/images/shakir_shuja_abadi.jpg',
    'assets/images/Bulleh_Shah_image.jpg',
    'assets/images/ahmad_fraz_image.jpg',
    'assets/images/sachal_sarmast_image.png',
    'assets/images/john_alya_image.jpg',
    'assets/images/khawja_fareed_image.jpg',
    'assets/images/parveen_shakir_image.jpg',
    'assets/images/amjad_islam_image.jpg',
    'assets/images/rehman_baba_image.jpg',
    'assets/images/waris_shah_image.png',
    'assets/images/fraq_gorpori_image.png',
    'assets/images/alama_iqbal_image.jpg',
    'assets/images/shaheed_bhagat.jpg',
    'assets/images/josh_abadi.jpg',
    'assets/images/sahir_lodhanvi_image.jpg',
    'assets/images/rafeeq_khawar_image.jpg',
    'assets/images/hasrat mohani.png',
    'assets/images/mir_taqi_mir_image.jpg',
  ];
  List<String> midImages = ['assets/images/sad_image.jpg', 'assets/images/love_mid_image.jpg', 'assets/images/funny_mid_image.png'];
  List<String> languageFlag = [
    'assets/images/urdu_language.jpg',
    'assets/images/punjabi_language.jpg',
    'assets/images/saraiki_image.jpg',
    'assets/images/sindhi_language.jpg',
    'assets/images/pashtoo_language.jpg',
    'assets/images/blochi_language.jpg',
    'assets/images/kashmari_language.png',
    'assets/images/pharsi_language.jpg',
  ];
  List<String> picsList = [
    'assets/images/sad_icon.png',
    'assets/images/love_icon.png',
    'assets/images/funny_icon.png',
  ];
  List<String> languageList = ["اردو", "پنجابی", "سرائیکی", "سندھی", "پشتو", "بلوچی", "کشمیری", "فارسی"];

  List<String> title = ['😥 اداس شاعری', '💖 محبت کی شاعری', '😂 مزاحیہ شاعری'];
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('ur');
    await flutterTts.setSpeechRate(0.2);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  List data = MySharedPreferences.getStringList('myList');

  @override
  Widget build(BuildContext context) {
    print(data);
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.black12,
          title: const Text(
            'Home Screen',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                  Positioned(
                      left: mediaQuerySize.height * 0.012.w,
                      top: mediaQuerySize.height * 0.0045.h,
                      child: Text(
                        data.length.toString(),
                        style: TextStyle(fontSize: 10, color: Colors.yellow),
                      )),
                ],
              ),
            )
          ],
        ),
        drawer: const Drawer(
          backgroundColor: Colors.black,
          child: Text('sad'),
        ),
        body: Container(
          height: mediaQuerySize.height.h,
          width: mediaQuerySize.width.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      return GestureDetector(
                        onTap: () {
                          index == 0
                              ? Get.to(() => PoetryScreen(
                                    name: '',
                                    isSadPoetry: true,
                                  ))
                              : index == 1
                                  ? Get.to(() => PoetryScreen(
                                        name: '',
                                        isLovePoetry: true,
                                      ))
                                  : Get.to(() => PoetryScreen(
                                        name: '',
                                        isFunnyPoetry: true,
                                      ));

                          print('tapped index===$index');
                        },
                        child: Container(
                          width: mediaQuerySize.width.w,
                          height: mediaQuerySize.height * 0.4.h,
                          // margin: EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/background.jpg')), borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            width: mediaQuerySize.width.w,
                            height: mediaQuerySize.height * 0.4.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      midImages[index],
                                    )),
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              width: mediaQuerySize.width.w,
                              height: mediaQuerySize.height * 0.4.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black.withOpacity(0.675)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  title[index],
                                  style: TextStyle(fontFamily: 'boldFont', color: Colors.white, fontSize: mediaQuerySize.width * 0.07.w),
                                ),
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
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
                  ),
                  SizedBox(height: mediaQuerySize.height * 0.025.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'بہترین شعراء',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        poets.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                index == 0
                                    ? Get.to(() => PoetryScreen(
                                          name: '',
                                          isMirzaGhalibPoetry: true,
                                        ))
                                    : index == 1
                                        ? Get.to(() => PoetryScreen(
                                              name: '',
                                              isShakirShujabadiPoetry: true,
                                            ))
                                        : index == 2
                                            ? Get.to(() => PoetryScreen(
                                                  name: '',
                                                  isBollayShahPoetry: true,
                                                ))
                                            : index == 2
                                                ? Get.to(() => PoetryScreen(
                                                      name: '',
                                                      isBollayShahPoetry: true,
                                                    ))
                                                : index == 3
                                                    ? Get.to(() => PoetryScreen(
                                                          name: '',
                                                          isAhmadFrazPoetry: true,
                                                        ))
                                                    : index == 4
                                                        ? Get.to(() => PoetryScreen(
                                                              name: '',
                                                              isSachalSarmastPoetry: true,
                                                            ))
                                                        : index == 5
                                                            ? Get.to(() => PoetryScreen(
                                                                  name: '',
                                                                  isJhonEliaPoetry: true,
                                                                ))
                                                            : index == 6
                                                                ? Get.to(() => PoetryScreen(
                                                                      name: '',
                                                                      isKhawajaFareedPoetry: true,
                                                                    ))
                                                                : index == 7
                                                                    ? Get.to(() => PoetryScreen(
                                                                          name: '',
                                                                          isParveenShakirPoetry: true,
                                                                        ))
                                                                    : index == 8
                                                                        ? Get.to(() => PoetryScreen(
                                                                              name: '',
                                                                              isAmjadIslamPoetry: true,
                                                                            ))
                                                                        : index == 9
                                                                            ? Get.to(() => PoetryScreen(
                                                                                  name: '',
                                                                                  isRehmanBabaPoetry: true,
                                                                                ))
                                                                            : index == 10
                                                                                ? Get.to(() => PoetryScreen(
                                                                                      name: '',
                                                                                      isWarisShahPoetry: true,
                                                                                    ))
                                                                                : index == 11
                                                                                    ? Get.to(() => PoetryScreen(
                                                                                          name: '',
                                                                                          isGorakpuriPoetry: true,
                                                                                        ))
                                                                                    : index == 12
                                                                                        ? Get.to(() => PoetryScreen(
                                                                                              name: '',
                                                                                              isAllamaIqbalPoetry: true,
                                                                                            ))
                                                                                        : index == 13
                                                                                            ? Get.to(() => PoetryScreen(
                                                                                                  name: '',
                                                                                                  isShaheedBhagatPoetry: true,
                                                                                                ))
                                                                                            : index == 14
                                                                                                ? Get.to(() => PoetryScreen(
                                                                                                      name: '',
                                                                                                      isJoshAbadiPoetry: true,
                                                                                                    ))
                                                                                                : index == 15
                                                                                                    ? Get.to(() => PoetryScreen(
                                                                                                          name: '',
                                                                                                          isSeharLodhanviPoetry: true,
                                                                                                        ))
                                                                                                    : index == 16
                                                                                                        ? Get.to(() => PoetryScreen(
                                                                                                              name: '',
                                                                                                              isRafiqKhawarPoetry: true,
                                                                                                            ))
                                                                                                        : index == 17
                                                                                                            ? Get.to(() => PoetryScreen(
                                                                                                                  name: '',
                                                                                                                  isHasratMohaniPoetry: true,
                                                                                                                ))
                                                                                                            : index == 18
                                                                                                                ? Get.to(() => PoetryScreen(
                                                                                                                      name: '',
                                                                                                                      isMirTakiMirPoetry: true,
                                                                                                                    ))
                                                                                                                : '';
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: mediaQuerySize.height * 0.1.h,
                                    width: mediaQuerySize.width * 0.17.w,
                                    decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(poetImages[index])), color: Colors.amber, shape: BoxShape.circle),
                                  ),
                                  Text(
                                    poets[index],
                                    style: const TextStyle(fontFamily: 'boldFont'),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: mediaQuerySize.height * 0.02.h),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'مختلف زبانیں',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: mediaQuerySize.width,
                    child: GridView.builder(
                      shrinkWrap: true, // This makes the GridView take only as much space as needed
                      physics: const NeverScrollableScrollPhysics(), // Disables scrolling of the GridView

                      itemCount: languageList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              index == 0
                                  ? Get.to(() => PoetryScreen(
                                        name: '',
                                        isUrduPoetry: true,
                                      ))
                                  : index == 1
                                      ? Get.to(() => PoetryScreen(
                                            name: '',
                                            isPunjabiPoetry: true,
                                          ))
                                      : index == 2
                                          ? Get.to(() => PoetryScreen(
                                                name: '',
                                                isSaraikiPoetry: true,
                                              ))
                                          : index == 3
                                              ? Get.to(() => PoetryScreen(
                                                    name: '',
                                                    isSindiPoetry: true,
                                                  ))
                                              : index == 4
                                                  ? Get.to(() => PoetryScreen(
                                                        name: '',
                                                        isPashtoPoetry: true,
                                                      ))
                                                  : index == 5
                                                      ? Get.to(() => PoetryScreen(
                                                            name: '',
                                                            isBalochiPoetry: true,
                                                          ))
                                                      : index == 6
                                                          ? Get.to(() => PoetryScreen(
                                                                name: '',
                                                                isKashmariPoetry: true,
                                                              ))
                                                          : index == 7
                                                              ? Get.to(() => PoetryScreen(
                                                                    name: '',
                                                                    isFarsiPoetry: true,
                                                                  ))
                                                              : '';
                            },
                            child: Container(
                              decoration: BoxDecoration(image: DecorationImage(colorFilter: const ColorFilter.mode(Color.fromARGB(170, 0, 0, 0), BlendMode.colorBurn), fit: BoxFit.cover, image: AssetImage(languageFlag[index])), color: Colors.amber, borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                languageList[index],
                                style: TextStyle(fontFamily: 'boldFont', color: Colors.white, fontSize: mediaQuerySize.width * 0.06.w),
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
      ),
    );
  }
}
