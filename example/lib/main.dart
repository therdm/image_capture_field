import 'package:flutter/material.dart';
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
  final _controller = ImageCaptureController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Image Capture'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              ImageCaptureField(
                // controller: _controller,
                includeCropper: false,
                onImagePathChanged: (path) {
                  print('PATH: $path');
                },
                iconCamera: Icons.camera,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  print(_controller.imageName);
                  print(_controller.isBlank);
                },
                child: Text('Show Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
