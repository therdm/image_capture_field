import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_capture_field/image_capture_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Initializer(),
    );
  }
}

class Initializer extends StatelessWidget {
  Initializer({Key? key}) : super(key: key);
  final textEditingController = TextEditingController();
  final imageCaptureController = ImageCaptureController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Image Capture'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
              ),
              SizedBox(height: 12),
              ImageCaptureField(
                controller: imageCaptureController,
                width: 300,
                height: 200,
                cropAspectRatio: 3 / 2,
                includeCropper: true,
                borderRadiusValue: 10,
                bottomRightDistance: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  print(imageCaptureController.imageName);
                  // print(imageCaptureController.isBlank);
                },
                child: Text('Show info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
