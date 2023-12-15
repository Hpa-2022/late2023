import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage(this.name, {super.key});
  final String name;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop("lil Nigga");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Second Page"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("This text is from First page ${widget.name}"),
            ],
          ),
        ),
      ),
    );
  }
}
