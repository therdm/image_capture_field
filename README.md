# image_capture_field

ImageCaptureField is as easy-to-use as a TextField which works with it's own controller to take image input

## Getting Started

### Define a ImageCaptureController

final imageCaptureController = ImageCaptureController();

getters in the ImageCaptureController
   imageName => name of the picked image 
   imageData => image data in Uint8List
   isBlank => there is any image already picked or not
you can use where ever needed

### Put as a child of any child or may be as a children of Column

Just like below Code put it anywhere in your code

```
ImageCaptureController(
    controller: imageCaptureController,
    width: 300,
    height: 200,
    borderRadiusValue: 10,
    bottomRightDistance: 24,
),
```
               
And it is done
you can now pick any image and access it by 
`imageCaptureController.imageData`

### Crop functionality added you can use it by setting 

#### In the ImageCaptureField() pass the property:

`includeCropper: true`
#### To fix cropper aspect ratio

`spectRatio : width / height or any double`

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
