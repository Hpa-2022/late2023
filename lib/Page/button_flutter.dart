import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonFlutter extends StatefulWidget {
  const ButtonFlutter({super.key});

  @override
  State<ButtonFlutter> createState() => _ButtonFlutterState();
}

class _ButtonFlutterState extends State<ButtonFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.green,
            statusBarBrightness: Brightness.light, // for IOS light is dark
            statusBarIconBrightness: Brightness.light),
        title: const Text(
          'Buttons',
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor:
            Colors.amber, // hei hi IOS ah chuan status bar and toolbar color
        // backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {},
                child: const Text('TextButton with ButtonStyle'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.blue.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||
                          states.contains(MaterialState.pressed)) {
                        return Colors.blue.withOpacity(0.12);
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'TextButton with ButtonStyle and hovered/focus/pressed state',
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused)) {
                      return Colors.red;
                    }
                    return null; // Defer to the widget's default.
                  }),
                ),
                onPressed: () {},
                child: const Text('TextButton with ButtonStyle overlayColor'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {},
                child: const Text('TextButton with TextButton.styleFrom'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  disabledBackgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: const Text(
                    'TextButton with TextButton.styleFrom disabledBackground'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('ElevatedButton'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: const BorderSide(
                      width: 3,
                      color: Colors.black,
                    ),
                    textStyle: const TextStyle(fontSize: 20)),
                child: const Text('OutlinedButton'),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.green,
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () {},
                      child: const Text('TextButton with ClipRRect'),
                    )
                  ],
                ),
              ),
              IconButton(
                iconSize: 64,
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.purple,
                ),
              ),
              ElevatedButton.icon(
                label: const Text('ElevatedButton & Icon combined (icon left)'),
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.purple,
                ),
              ),
              ElevatedButton.icon(
                label: const Icon(
                  Icons.settings,
                  color: Colors.purple,
                ),
                onPressed: () {},
                icon: const Text('ElevatedButton & Icon combined (icon right)'),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print('3D');
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.purple,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(-4, -4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '3D Button',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              // Material a Inkwell kan wrap loh chuan A main container hnuaiah a in diplay tlat.
              Material(
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const NetworkImage(
                        'https://plus.unsplash.com/premium_photo-1676068244022-b48de5936d2d?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    height: 200,
                    width: 200,
                    fit: BoxFit.fitWidth,
                    child: const Center(
                      child: Text(
                        'Inkwell - Image with text button',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Material(
                elevation: 8,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const NetworkImage(
                            'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Inkwell - Image with text below (column)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 8,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const NetworkImage(
                            'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        'Inkwell - Image with text (Row)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 8,
                color: Colors.amber,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Ink.image(
                    image: const NetworkImage(
                        'https://plus.unsplash.com/premium_photo-1676068244022-b48de5936d2d?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    height: 200,
                    width: 200,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 8,
                color: Colors.amber,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.blue,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Ink.image(
                      image: const NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1676068244022-b48de5936d2d?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                elevation: 8,
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Ink.image(
                      image: const NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1676068244022-b48de5936d2d?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(22.0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {},
                  child: Ink(
                    // Container kha Ink in kan thlak
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 20.0),
                            blurRadius: 30.0,
                            color: Colors.black12)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    child: Row(
                      children: [
                        Ink(
                          height: 50.0,
                          width: 110.0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(95.0),
                              topLeft: Radius.circular(95.0),
                              bottomRight: Radius.circular(200),
                            ),
                          ),
                          child: Text(
                            'Sial chi',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.apply(color: Colors.black),
                          ),
                        ),
                        const Icon(
                          Icons.home,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
