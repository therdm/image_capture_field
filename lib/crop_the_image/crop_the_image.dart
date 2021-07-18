import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CropTheImage extends StatelessWidget {
  final Uint8List inputImageData;
  final double? aspectRatio;

  CropTheImage({
    Key? key,
    required this.inputImageData,
    required this.aspectRatio,
  }) : super(key: key);

  final _controller = CropController();

  final Rx<Uint8List?> outputImageData = Rx<Uint8List?>(null);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: outputImageData.value == null ? Colors.white60 : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Crop(
              image: outputImageData.value == null
                  ? inputImageData
                  : outputImageData.value!,
              controller: _controller,
              aspectRatio: aspectRatio,
              onCropped: (image) {
                outputImageData.value = image;
                _controller.area = Rect.largest;
                // _controller.aspectRatio = 1;
                // do something with image data
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  outputImageData.value == null
                      ? ElevatedButton.icon(
                          onPressed: () {
                            _controller.crop();
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.deepOrangeAccent)),
                          icon: Icon(Icons.crop),
                          label: Text('CROP'),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(outputImageData.value);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.green)),
                          icon: Icon(Icons.done),
                          label: Text('Done'),
                        ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
