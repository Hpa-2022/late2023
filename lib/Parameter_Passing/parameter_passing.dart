import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:late2023/Parameter_Passing/second_page.dart';

class ParameterPassingPage extends StatefulWidget {
  const ParameterPassingPage({super.key});

  @override
  State<ParameterPassingPage> createState() => _ParameterPassingPageState();
}

class _ParameterPassingPageState extends State<ParameterPassingPage> {
  final FocusNode hmingNode = FocusNode();
  final TextEditingController hmingController = TextEditingController();

  @override
  void initState() {
    hmingController.addListener(_hmingControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    hmingController.removeListener(_hmingControllerListener);
    super.dispose();
  }

  _hmingControllerListener() {
    print(hmingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 40,
        title: const Text("Parameter Passing and Receiving"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: hmingController,
              autofocus: true,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              focusNode: hmingNode,
              keyboardType: TextInputType.multiline,
              style: GoogleFonts.notoSerif(
                color: Colors.black,
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                labelText: 'Thawhtu hming',
                labelStyle: GoogleFonts.notoSerif(
                  color: Colors.black,
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  // focused laia border color rawn in thlak tur
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (hmingController.text.isNotEmpty) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SecondPage(hmingController.text)))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          hmingController.text = value;
                        });
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Text is empty")));
                  }
                },
                child: const Text("Pass Param to Next Page"))
          ],
        ),
      ),
    );
  }
}
