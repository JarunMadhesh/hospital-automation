import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Intelligent hospitals'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? image;

  Future takeImage() async {
    try {
      final XFile? photo = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 75);

      if (photo == null) return;
      print("\n\n\n");
      print("path:");
      print(photo.path);

      setState(() {
        image = photo.path;
      });
    } on PlatformException catch (e) {
      print("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Take photo',
            ),
            (image != null)
                ? Image.file(
                    File(image!),
                    height: 300,
                    width: 160,
                    fit: BoxFit.fill,
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => takeImage(),
        child: const Icon(
          Icons.camera,
          size: 30,
        ),
      ),
    );
  }
}
