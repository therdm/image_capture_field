part of image_capture_field;

class ImageCaptureController {

  ImageCaptureController();

  final Rxn<Uint8List> _pickedImageUInt8List = Rxn<Uint8List>();
  final RxnString _imageName = RxnString();
  final RxnString _imagePath = RxnString();

  updatePickedImage(Uint8List? uInt8list, String? path) {
    _imagePath.value = path;
    if (uInt8list != null) {
      _pickedImageUInt8List.value = uInt8list;
      if (!kIsWeb)
        _imageName.value = path?.split('/').last;
      else
        _imageName.value = path;
      print('Image add Successful');
    } else {
      print('Image add un-successful');
    }
  }

  clear() {
    _pickedImageUInt8List.value = null;
    _imageName.value = null;
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

  ///[imageName] getter returns name of the image which you can use
  ///to upload image to the server
  String? get imageName => _imageName.value;

  ///[imagePath] getter returns name of the image which you can use
  ///to upload image to the server
  String? get imagePath => _imagePath.value;
}
