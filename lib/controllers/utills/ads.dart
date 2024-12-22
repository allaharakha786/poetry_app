import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsClass {
  InterstitialAd? interstitialAd;
  Timer? timer;
  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          print('Failed to load an interstitial ad: $error');
          interstitialAd = null;
        },
      ),
    );
  }

  void startAdTimer() {
    timer = Timer.periodic(Duration(seconds: 60), (timer) async {
      if (interstitialAd != null) {
        interstitialAd!.show();
      } else {
        loadInterstitialAd();
      }
    });
  }
}
