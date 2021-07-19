# image_capture_field

ImageCaptureField is as easy-to-use as a TextField which works with it's own controller to take image input with inbuilt optional image cropper

## Simple to use: Just Follow 2 steps


### 1. Define a ImageCaptureController

```
final _controller = ImageCaptureController();
```

### 2. Put as a child of any child or may be as a children of Column

Just like below Code put it anywhere in your code

```
ImageCaptureField(
    controller: _controller,
    width: 300,
    height: 200,
    includeCropper: false,
    borderRadiusValue: 10,
    bottomRightDistance: 24,
),
```
               
And it is DONE. You can NOW pick any image. <br />

Access Image Data (Uint8List) by,

```
_controller.imageData
```

and Name of the Image can be found,

```
_controller.imageName
```

all the getters in the ImageCaptureController are <br />
&nbsp; &nbsp;  `_controller.imageName => name of the picked image` <br />
&nbsp; &nbsp;  `_controller.imageData => image data in Uint8List` <br />
&nbsp; &nbsp;  `_controller.isBlank => there is any image already picked or not` <br />
you can use where ever needed

## Crop functionality added 

### You can use it by passing the property in the ImageCaptureField():

```
includeCropper: true
```

### To fix cropper aspect ratio

```
cropAspectRatio : (width/height)   or,   any ratio in double
```

## Some Screenshots

<div style="display: flex; justify-content: space-between;">
    <img src="https://i.postimg.cc/hPTcZctq/1.jpg" width="220px" alt="1"/>&nbsp; &nbsp;
    <img src="https://i.postimg.cc/0yvxLFzK/2.jpg" width="220px" alt="2"/>&nbsp; &nbsp;
    <img src="https://i.postimg.cc/wBTzBNc6/3.jpg" width="220px" alt="3"/>&nbsp; &nbsp;
    <img src="https://i.postimg.cc/857VRV09/4.jpg" width="220px" alt="4"/>&nbsp; &nbsp;
    <img src="https://i.postimg.cc/0NWsKNc7/5.jpg" width="220px" alt="5"/>&nbsp; &nbsp;
    <img src="https://i.postimg.cc/mgSRRj9X/6.jpg" width="220px" alt="6"/>&nbsp; &nbsp;
</div>

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
