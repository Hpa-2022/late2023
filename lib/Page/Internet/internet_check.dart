import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternet extends StatefulWidget {
  const CheckInternet({super.key});

  @override
  State<CheckInternet> createState() => _CheckInternetState();
}

class _CheckInternetState extends State<CheckInternet> {
  late StreamSubscription internetSubscription; //Internet connection checker
  bool hasInternet = true;

  @override
  void initState() {
    initNetwork();

    super.initState();
  }

  void initNetwork() async {
    bool firstCheckHasInternet = await InternetConnectionChecker()
        .hasConnection; // internet check-na code

    //Only internet connection checker
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
        hasInternet = firstCheckHasInternet;
      });
    }
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Internet Connection"),
      ),
      body: Stack(
        children: [
          const Column(
            children: [
              Text("Testing Internet"),
            ],
          ),
          widgetCheckInternet(),
        ],
      ),
    );
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
              color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("No Internet Connection!"),
                    // const CircularProgressIndicator(),
                    ElevatedButton(
                        onPressed: () {
                          initNetwork();
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
