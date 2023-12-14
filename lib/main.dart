import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:late2023/Admob/admob_test_page.dart';
import 'package:late2023/Page/Internet/connection_plus.dart';
import 'package:late2023/Page/Internet/internet_check.dart';
import 'package:late2023/Page/Quiz/quiz.dart';
import 'package:late2023/Page/Quiz2/quiz_home.dart';
import 'package:late2023/Page/Webview/inappwebview.dart';
import 'package:late2023/Page/Webview/stackwithweb.dart';
import 'package:late2023/Page/Webview/webview.dart';
import 'package:late2023/Page/button_flutter.dart';
import 'package:late2023/Page/stack_page.dart';
import 'package:late2023/Page/timer_page.dart';
import 'package:late2023/Theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: ['E46609DD331AF2754D38B3DCE3ED011B']);
  MobileAds.instance.updateRequestConfiguration(configuration);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter = _counter + 2;
    });
  }

  void _setZero() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.green,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16.0),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.amber[100],
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'WebView Flutter without stack',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const WebViewPage()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'WebView with Stack',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const StackWithWeb()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'InappwebView',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const GoogleTranslator()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Quiz App',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const QuizPage()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Quiz Second',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const QuizSecondHome()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Stack Page',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const StackPage()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Buttons',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ButtonFlutter()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Timer',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const TimerPage()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Check Internet Connection',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CheckInternet()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Check Internet Connection PLUS',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ConnectionPlusPage()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ListTile(
                  title: const Text(
                    'Admob Testing',
                  ),
                  tileColor: Colors.red,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AdmobTestPage()),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  selectedTileColor: Colors.orange[100],
                ),
              ),
            ),
            Text('Click to floating Button for increment in $_counter'),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: _increment,
            tooltip: 'Increment',
            heroTag: 'Increment',
            child: const Icon(
              Icons.add,
              color: Colors.green,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: _setZero,
            tooltip: 'Set to Zero',
            heroTag: 'Zero',
            child: Icon(
              Icons.exposure_zero,
              color: Colors.red[200],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
