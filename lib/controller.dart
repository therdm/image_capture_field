import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageCaptureController {
  Rxn<PickedFile> pickedImage = Rxn<PickedFile>();
  get image => pickedImage.value;
}
