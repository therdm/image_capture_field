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
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    updateImageWOCropper(ImageSource imageSource) async {
      PickedFile? pickedFile = await _picker.getImage(
        source: imageSource,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        pickedFile.readAsBytes().then((value) {
          controller.updatePickedImage(value, pickedFile.path);
          print('Image Name: ${controller.imageName}');
        });
      } //if

      Navigator.of(context).pop();
    }

    updateImageWithCropper(ImageSource imageSource) {
      _picker
          .getImage(
        source: imageSource,
        imageQuality: imageQuality,
      )
          .then((pickedFile) {
        if (pickedFile != null) {
          pickedFile.readAsBytes().then((value) async {
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

      Navigator.of(context).pop();
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
        child: Stack(
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
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: bottomRightDistance,
              right: bottomRightDistance,
              child: CircleAvatar(
                backgroundColor: Colors.teal,
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

class OpenWithCameraOrGallery extends StatelessWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;
  const OpenWithCameraOrGallery({
    Key? key,
    required this.onTapCamera,
    required this.onTapGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 25),
              child: Text(
                'Open with',
                textScaleFactor: 1.2,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                OpenWithButton(
                  iconName: 'Camera',
                  iconData: Icons.camera_alt,
                  onTap: onTapCamera,
                ),
                const SizedBox(width: 30),
                OpenWithButton(
                  iconName: 'Gallery',
                  iconData: Icons.photo,
                  onTap: onTapGallery,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OpenWithButton extends StatelessWidget {
  const OpenWithButton({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.iconName,
  }) : super(key: key);
  final Function() onTap;
  final IconData iconData;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal,
            child: Icon(iconData),
          ),
          const SizedBox(height: 5),
          Text(
            iconName,
            textScaleFactor: 0.9,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
