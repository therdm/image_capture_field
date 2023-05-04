part of image_capture_field;

class ImageCaptureField extends StatelessWidget {
  ImageCaptureField({
    Key? key,
    ImageCaptureController? controller,
    this.onImagePathChanged,
    this.onImageBytesChanged,
    this.width,
    this.height,
    this.initialImage,
    // this.onChanged,
    this.cropAspectRatio,
    this.includeCropper = true,
    this.imageQuality = 100,
    this.borderRadiusValue = 16,
    this.bottomRightDistance = 12,
    this.iconBackgroundColor = Colors.teal,
    this.iconEdit = Icons.edit,
    this.iconCamera = Icons.camera_alt,
    this.iconGallery = Icons.photo,
  })  : controller = controller ?? ImageCaptureController(),
        super(key: key);

  ///this will give you the path of the image when you are selecting any image
  final Function(String? onChanged)? onImagePathChanged;

  ///this will give you the bytes[Uint8List] of the image when you are selecting any image
  final Function(Uint8List? bytes)? onImageBytesChanged;

  ///this is the height of the widget
  final double? width;

  ///this is the height of the widget
  final double? height;

  ///this is to set an initial image if not set
  final Widget? initialImage;

  // final Function()? onChanged;

  ///this is the aspectRatio for the cropper
  final double? cropAspectRatio;

  ///depending on this [includeCropper], decides this Widget includes cropper or not
  final bool includeCropper;

  ///this is the default image compressor of image_picker ranges from 0-100
  final int imageQuality;

  ///this is the widget circular border radius value
  final double borderRadiusValue;

  ///this is the distance from bottom and right side to the camera icon of the widget
  final double bottomRightDistance;

  ///you need to pass a controller of type [ImageCaptureController] type
  ///to handle the image you picked
  final ImageCaptureController controller;

  ///this defines what color will be there background of the icons
  final Color iconBackgroundColor;

  ///this is to change edit icon of this widget
  final IconData iconEdit;

  ///this is to change camera icon of this widget
  final IconData iconCamera;

  ///this id to change gallery icon of this widget
  final IconData iconGallery;

  final _picker = ImagePicker();
  final Rx<bool> _showLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    updateImageWOCropper(ImageSource imageSource) async {
      XFile? pickedFile = await _picker.pickImage(
        source: imageSource,
        imageQuality: imageQuality,
      );

      controller.updatePickedImage(await pickedFile?.readAsBytes(), pickedFile?.path);
      onImagePathChanged?.call(pickedFile?.path);
      onImageBytesChanged?.call(await pickedFile?.readAsBytes());
      print('Image Name: ${controller.imageName}');
      if (!kIsWeb) Navigator.of(context).pop();
    }

    updateImageWithCropper(ImageSource imageSource) {
      _picker.pickImage(source: imageSource, imageQuality: imageQuality).then((pickedFile) {
        if (pickedFile != null) {
          _showLoading.value = true;
          pickedFile.readAsBytes().then((value) async {
            _showLoading.value = false;
            Uint8List? result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => CropTheImage(aspectRatio: cropAspectRatio, inputImageData: value),
              ),
            );
            controller.updatePickedImage(result, pickedFile.path);
            onImagePathChanged?.call(pickedFile.path);
            onImageBytesChanged?.call(await pickedFile?.readAsBytes());
            print('Image Name: ${controller.imageName}');
            // if (onImageChanged != null) {
            //   onImageChanged!();
            // }
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
                : updateImageWOCropper(ImageSource.gallery);
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
                  iconCamera: iconCamera,
                  iconGallery: iconGallery,
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
                    borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
                    clipBehavior: Clip.hardEdge,
                    elevation: 6,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: width,
                      height: height,
                      constraints: BoxConstraints(minWidth: 60, minHeight: 60),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: (controller.isBlank && initialImage == null)
                          ? null
                          : controller.isBlank
                              ? initialImage!
                              : Image(image: MemoryImage(controller.imageData!)),
                    ),
                  ),
                  Positioned(
                    bottom: bottomRightDistance,
                    right: bottomRightDistance,
                    child: CircleAvatar(
                      backgroundColor: iconBackgroundColor,
                      radius: 20,
                      child: Icon(
                        iconEdit,
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
