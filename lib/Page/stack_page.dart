import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Example'),
      ),
      body: SafeArea(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.black,
          child: Stack(
            // fit: StackFit.expand,
            // fit: StackFit.loose,
            // clipBehavior:
            // Clip.none, // hei hi overflow: Overflow.visible thlakna a ni.
            alignment: Alignment.center,

            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  color: Colors.red,
                  width: 100,
                  height: 100,
                ),
              ),
              Positioned(
                top: 0,
                right: 50,
                child: Container(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                ),
              ),
              Positioned(
                top: 0,
                right: 50,
                child: Container(
                  color: Colors.grey,
                  width: 200,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
