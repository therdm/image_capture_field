part of image_capture_field;

class ImageCaptureController {
  Rxn<Uint8List> _pickedImageUInt8List = Rxn<Uint8List>();
  String? _imageName;

  updatePickedImage(Uint8List? uInt8list, String? path) {
    if (uInt8list != null) {
      _pickedImageUInt8List.value = uInt8list;
      if (!kIsWeb)
        _imageName = path?.split('/').last;
      else
        _imageName = path;
      print('Image add Successful');
    } else {
      print('Image add un-successful');
    }
  }
  //
  // updatePickedImageWeb(PickedFile? file) async {
  //   if (file != null) {
  //     _pickedImageUInt8List.value = await file.readAsBytes();
  //     if (!kIsWeb)
  //       _imageName = file.path.split('/').last;
  //     else
  //       _imageName = file.path;
  //     print('Image add Successful');
  //   } else {
  //     print('Image add un-successful');
  //   }
  // }

  ///[isBlankU] says whether the [imageData] is null or not
  bool get isBlank => _pickedImageUInt8List.value == null;

  ///Here the getter returns a PickedFile which you can use

  ///this [imageData] returns Uint8List which you can use in any platform
  ///such as Android, iOS, Web etc
  ///to upload to your server such as cloudFirestore
  ///for example: for file => File.fromRawPath(imageData);
  Uint8List? get imageData => _pickedImageUInt8List.value;

  ///below [imageName] getter returns name of the image which you can use
  ///to upload image to the server
  String? get imageName => _imageName;
}
