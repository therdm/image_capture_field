part of image_capture_field;

class ImageCaptureField extends StatelessWidget {
  ImageCaptureField({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
    this.cropAspectRatio,
    this.includeCropper = false,
    this.imageQuality = 12,
    this.borderRadiusValue = 16,
    this.bottomRightDistance = 12,
    this.iconBackgroundColor = Colors.teal,
  }) : super(key: key);

  ///this [width] is the height of the widget
  final double width;

  ///this [height] is the height of the widget
  final double height;

  ///this [cropAspectRatio] is the aspectRatio for the cropper
  final double? cropAspectRatio;

  ///depending on this [includeCropper] this Widget includes cropper or not
  final bool includeCropper;

  ///this [imageQuality] is the default image compressor of image_picker ranges from 0-100
  final int imageQuality;

  ///this [borderRadiusValue] is the widget circular border radius value
  final double borderRadiusValue;

  ///this [bottomRightDistance] is the distance from bottom and right side to the camera icon of the widget
  final double bottomRightDistance;

  ///you need to pass a controller of type [ImageCaptureController] type
  ///to handle the image you picked
  final ImageCaptureController controller;

  ///[iconBackgroundColor] defines what color will be there background of the icons
  final Color iconBackgroundColor;

  final _picker = ImagePicker();
  final Rx<bool> _showLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    updateImageWOCropper(ImageSource imageSource) async {
      PickedFile? pickedFile = await _picker.getImage(
        source: imageSource,
        imageQuality: imageQuality,
      );

      controller.updatePickedImage(
          await pickedFile?.readAsBytes(), pickedFile?.path);
      print('Image Name: ${controller.imageName}');
      if (!kIsWeb) Navigator.of(context).pop();
    }

    updateImageWithCropper(ImageSource imageSource) {
      _picker
          .getImage(
        source: imageSource,
        imageQuality: imageQuality,
      )
          .then((pickedFile) {
        if (pickedFile != null) {
          _showLoading.value = true;
          pickedFile.readAsBytes().then((value) async {
            _showLoading.value = false;
            Uint8List? result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => CropTheImage(
                    aspectRatio: cropAspectRatio, inputImageData: value),
              ),
            );
            controller.updatePickedImage(result, pickedFile.path);
          });
        } //if ends
      });
      if (!kIsWeb) Navigator.of(context).pop();
    }

    return Obx(() {
      return InkWell(
        onTap: () async {
          if (kIsWeb) {
            includeCropper
                ? updateImageWithCropper(ImageSource.gallery)
                : updateImageWOCropper(ImageSource.camera);
          } else {
            showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return OpenWithCameraOrGallery(
                  iconBackgroundColor: iconBackgroundColor,
                  onTapCamera: () {
                    includeCropper
                        ? updateImageWithCropper(ImageSource.camera)
                        : updateImageWOCropper(ImageSource.camera);
                  },
                  onTapGallery: () {
                    includeCropper
                        ? updateImageWithCropper(ImageSource.gallery)
                        : updateImageWOCropper(ImageSource.gallery);
                  },
                );
              },
            );
          }
        },
        child: _showLoading.value
            ? Center(child: Text('LOADING...'))
            : Stack(
                children: [
                  Material(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadiusValue)),
                    clipBehavior: Clip.hardEdge,
                    elevation: 6,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: controller.isBlank
                            ? null
                            : DecorationImage(
                                image: MemoryImage(controller.imageData!),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: bottomRightDistance,
                    right: bottomRightDistance,
                    child: CircleAvatar(
                      backgroundColor: iconBackgroundColor,
                      radius: 20,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
