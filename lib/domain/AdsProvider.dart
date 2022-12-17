import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsProvider extends ChangeNotifier{

  BannerAd getAd(){

    BannerAd x = BannerAd(
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) async {
            print('Inline adaptive banner loaded: ${ad.responseInfo}');
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
          },
        )
    );

    x.load();

    return x;
  }
}