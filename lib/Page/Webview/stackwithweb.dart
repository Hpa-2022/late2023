import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Admob/admob.dart';

class StackWithWeb extends StatefulWidget {
  const StackWithWeb({super.key});

  @override
  State<StackWithWeb> createState() => _StackWithWebState();
}

class _StackWithWebState extends State<StackWithWeb> {
  String loadedWeb = "loading";
  late StreamSubscription internetSubscription; //Internet connection checker
  bool hasInternet = true;

  //Ads
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  //Initial Webview
  late final WebViewController _controller;
  var webProgress = 0;

  @override
  void initState() {
    initNetwork();

    _initBannerAd();
    initWebController();
    super.initState();
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          foregroundColor: Colors.red,
          backgroundColor: Colors.transparent,
          title: const Text('Language Translator'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    loadedWeb = "loading";
                  });
                  _controller.loadRequest(Uri.parse(
                      'https://translate.google.com/?sl=lus&tl=en&op=translate'));
                },
                icon: const Icon(
                  Icons.replay_outlined,
                  color: Colors.black,
                )),
          ],
        ),
        body: Container(
          color: Colors.white70,
          child: Stack(
            children: [
              _buildChild(),
              webProgress < 100
                  ? SizedBox(
                      height: 5,
                      child: LinearProgressIndicator(
                        value: webProgress / 100.0,
                        color: Colors.red,
                        backgroundColor: Colors.black,
                      ),
                    )
                  : const SizedBox(),
              widgetCheckInternet(),
            ],
          ),
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

  // Init WebView
  void initWebController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                webProgress = progress;
              });
            }
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                webProgress = 0;
              });
            }
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            runJavaScript();
            if (mounted) {
              setState(() {
                loadedWeb = "finished";
                webProgress = 100;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                loadedWeb = "error";
              });
            }

            debugPrint(
                '''Page resource error: code: ${error.errorCode} description: ${error.description} errorType: ${error.errorType} isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                    'https://translate.google.com/?sl=lus&tl=en&op=translate') ||
                request.url.startsWith(
                    'https://translate.google.com/_/TranslateWebserverUi/bscframe')) {
              debugPrint('allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            }
            debugPrint('blocking navigation to ${request.url}');
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://translate.google.com/?sl=lus&tl=en&op=translate'));
  }

  void runJavaScript() {
    _controller.runJavaScript(
        "document.getElementsByClassName('pGxpHc')[0].style.display='none';"
        "document.getElementsByClassName('U0xwnf')[0].style.display='none';"
        "document.getElementsByClassName('a88hkc')[0].style.display='none';"
        "document.getElementsByClassName('VlPnLc')[0].style.display='none';");
    debugPrint('Close from runjavascript');
  }

  Widget _buildChild() {
    Widget child;
    if (loadedWeb == "finished") {
      child = WebViewWidget(controller: _controller);
    } else if (loadedWeb == "loading") {
      child = const Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
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
                  _controller.loadRequest(Uri.parse(
                      'https://translate.google.com/?sl=lus&tl=en&op=translate'));
                },
                child: const Text("Reload page")),
          ],
        ),
      );
    }
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
                          _controller.loadRequest(Uri.parse(
                              'https://translate.google.com/?sl=lus&tl=en&op=translate'));
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
}
