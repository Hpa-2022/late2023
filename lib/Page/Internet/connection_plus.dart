import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectionPlusPage extends StatefulWidget {
  const ConnectionPlusPage({super.key});

  @override
  State<ConnectionPlusPage> createState() => _ConnectionPlusPageState();
}

class _ConnectionPlusPageState extends State<ConnectionPlusPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool hasInternet = false;

  @override
  void initState() {
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status $e');
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (result.toString() == "ConnectivityResult.wifi") {
        hasInternet = true;
      } else if (result.toString() == "ConnectivityResult.data") {
        hasInternet = true;
      } else {
        hasInternet = false;
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
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
          Center(
              child:
                  Text('Connection Status: ${_connectionStatus.toString()}')),
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
                          initConnectivity();
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
