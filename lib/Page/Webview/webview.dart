import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:late2023/Admob/admob.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  //Ads
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  String loadedWeb = "loading";

  //Initial Webview
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _initBannerAd();
    initWebController();
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

// Init WebView
  void initWebController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            runJavaScript();
            setState(() {
              loadedWeb = "finished";
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              loadedWeb = "error";
            });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SafeArea(
        child: _buildChild(),
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
      child = const Center(
        child: Text('Error'),
      );
    }
    return child;
  }
}
