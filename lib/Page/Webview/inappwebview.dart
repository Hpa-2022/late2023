import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:late2023/Admob/admob.dart';

class GoogleTranslator extends StatefulWidget {
  const GoogleTranslator({super.key});

  @override
  State<GoogleTranslator> createState() => _GoogleTranslatorState();
}

class _GoogleTranslatorState extends State<GoogleTranslator> {
  //InAppWebView
  String loadedWeb = "loading";
  late InAppWebViewController controller;
  late PullToRefreshController pullToRefreshController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  double webProgress = 0;

  // Ads
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

//Internet connection checker
  late StreamSubscription internetSubscription;
  bool hasInternet = false;

  @override
  void initState() {
    // Internet Connection Checker
    initNetwork();

    // Ads
    _initBannerAd();

    // InappWebView
    initInAppWeb();

    super.initState();
  }

  void initNetwork() async {
    bool firstInternetCheck = await InternetConnectionChecker().hasConnection;
    print("frist check internet : $firstInternetCheck");

    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      if (mounted) {
        setState(() {
          this.hasInternet = hasInternet;
        });
      }
    });

    if (mounted) {
      setState(() {
        hasInternet = firstInternetCheck;
      });
    }
  }

  void initInAppWeb() {
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        controller.loadUrl(
            urlRequest: URLRequest(
                url: Uri.parse(
                    'https://translate.google.com/?sl=lus&tl=en&op=translate')));
      },
    );
  }

  _initBannerAd() {
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

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff303030),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          foregroundColor: Colors.red,
          backgroundColor: Colors.transparent,
          // title: const Text('Language Translator'),
        ),
        body: Stack(
          children: [
            widgetBuildChild(),
            webProgress < 1
                ? SizedBox(
                    height: 5,
                    child: LinearProgressIndicator(
                      value: webProgress,
                      color: Colors.red,
                      backgroundColor: Colors.black,
                    ),
                  )
                : const SizedBox(),
            widgetCheckLoadingOrError(),
            widgetCheckInternet(),
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
      ),
    );
  }

  void runJavaScript() {
    controller.evaluateJavascript(
        source:
            "document.getElementsByClassName('pGxpHc')[0].style.display='none'");
    controller.evaluateJavascript(
        source:
            "document.getElementsByClassName('U0xwnf')[0].style.display='none'");
    controller.evaluateJavascript(
        source:
            "document.getElementsByClassName('a88hkc')[0].style.display='none'");
    controller.evaluateJavascript(
        source:
            "document.getElementsByClassName('VlPnLc')[0].style.display='none'");
    print('Close from runjavascript');
  }

  Widget widgetBuildChild() {
    Widget child;
    child = InAppWebView(
        pullToRefreshController: pullToRefreshController,
        initialUrlRequest: URLRequest(
            url: Uri.parse(
                'https://translate.google.com/?sl=lus&tl=en&op=translate')),
        onWebViewCreated: (InAppWebViewController controllerOnCreated) {
          controller = controllerOnCreated;
        },
        initialOptions: options,
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          if (navigationAction.request.url.toString() ==
                  "https://translate.google.com/?sl=lus&tl=en&op=translate" ||
              navigationAction.request.url.toString() ==
                  "https://translate.google.com/_/TranslateWebserverUi/bscframe") {
            return NavigationActionPolicy.ALLOW;
          }
          return NavigationActionPolicy.CANCEL;
        },
        onLoadStop: (controller, url) {
          pullToRefreshController.endRefreshing();
        },
        onLoadStart: (controller, url) {
          if (mounted) {
            setState(() {
              webProgress = 0;
              loadedWeb = "loading";
            });
          }
        },
        onLoadError: (controller, url, code, message) async {
          pullToRefreshController.endRefreshing();
          if (mounted) {
            setState(() {
              loadedWeb = "error";
            });
          }
        },
        onLoadHttpError: (controller, url, statusCode, description) async {
          pullToRefreshController.endRefreshing();
          if (mounted) {
            setState(() {
              loadedWeb = "error";
            });
          }
        },
        onProgressChanged: (InAppWebViewController controller, value) {
          if (value == 100) {
            pullToRefreshController.endRefreshing();
            runJavaScript();
            if (mounted) {
              setState(() {
                loadedWeb = "finished";
                webProgress = 100;
              });
            }
          }
          if (mounted) {
            setState(() {
              webProgress = value / 100;
            });
          }
        });

    return child;
  }

  Widget widgetCheckInternet() {
    if (hasInternet) {
      return Container();
    } else {
      return Stack(
        children: <Widget>[
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "No Internet Connection",
                      style: TextStyle(fontSize: 16),
                    ),
                    // const CircularProgressIndicator(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40, 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () {
                          initNetwork();
                          setState(() {
                            loadedWeb = "loading";
                          });
                          controller.loadUrl(
                              urlRequest: URLRequest(
                                  url: Uri.parse(
                                      'https://translate.google.com/?sl=lus&tl=en&op=translate')));
                        },
                        child: const Text("Try again")),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget widgetCheckLoadingOrError() {
    Widget child;
    if (loadedWeb == "finished") {
      child = Container();
    } else if (loadedWeb == "loading") {
      child = Stack(
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
      child = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Something went wrong...',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () {
                  initNetwork();
                  setState(() {
                    loadedWeb = "loading";
                  });
                  controller.loadUrl(
                      urlRequest: URLRequest(
                          url: Uri.parse(
                              'https://translate.google.com/?sl=lus&tl=en&op=translate')));
                },
                child: const Text("Reload page")),
          ],
        ),
      );
    }
    return child;
  }
}
