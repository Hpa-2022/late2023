import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:late2023/Admob/admob.dart';

class AdmobTestPage extends StatefulWidget {
  const AdmobTestPage({super.key});

  @override
  State<AdmobTestPage> createState() => _AdmobTestPageState();
}

class _AdmobTestPageState extends State<AdmobTestPage> {
  // Rewarded Ads
  RewardedAd? _rewardedAd;
  late bool loading = true;

  // Banner ads
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  // Interstitial
  InterstitialAd? _interstitial;

  @override
  void initState() {
    // initRewarded();
    initBannerAd();
    initInterstitialAd();

    super.initState();
  }

  // Rewarded ads
  void initRewarded() {
    RewardedAd.load(
        adUnitId: AdmobIDs.rewardedAdsId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                  _rewardedAd = null;
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  _rewardedAd = null;
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
            showCustomDialog();
            setState(() {
              loading = false;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
            _rewardedAd = null;
            setState(() {
              loading = false;
            });
          },
        ));
  }

// Banner Ads
  initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdmobIDs.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) => {},
      ),
      request: const AdRequest(),
    )..load();
  }

  // Interstitial ads
  void initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdmobIDs.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              _interstitial = null;
              ad.dispose();
              initInterstitialAd();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              _interstitial = null;
              ad.dispose();
              initInterstitialAd();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {});

        _interstitial = ad;
        setState(() {
          loading = false;
        });
        // _interstitial?.show();
      }, onAdFailedToLoad: (err) {
        _interstitial = null;
        setState(() {
          loading = false;
        });
        initInterstitialAd();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admob Testing"),
      ),
      body: Stack(
        children: [
          const Center(child: Text("Admob Testing")),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showCustomDialog();
                  },
                  child: const Text("show dialog")),
              ElevatedButton(
                  onPressed: () {
                    if (_interstitial != null) {
                      _interstitial?.show();
                    }
                  },
                  child: const Text("Interstitial show"))
            ],
          ),
          widgetLoadingAds()
        ],
      ),
      bottomNavigationBar: _isAdLoaded
          ? SafeArea(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: _bannerAd!.size.height.toDouble(),
                width: _bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            )
          : const SizedBox(),
    );
  }

  void showCustomDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    "Want to Learn?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ],
              ),
              const Text(
                  "To unlock this content. Please, watch an Ad or Subscribe premium version."),
              const SizedBox(
                height: 6,
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    child: const Text('GO BACK'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('REMOVE ADS'),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (_rewardedAd != null) {
                        _rewardedAd?.show(onUserEarnedReward:
                            (AdWithoutView ad, RewardItem rewardItem) {
                          // ignore: avoid_print
                          print('Reward amount: ${rewardItem.amount}');
                          setState(() {});
                        });
                      }
                    },
                    child: const Text('WATCH AD'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetLoadingAds() {
    if (loading) {
      return Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Opacity(
              opacity: 1.0,
              child: ModalBarrier(dismissible: false, color: Colors.white),
            ),
          ),
          const Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
