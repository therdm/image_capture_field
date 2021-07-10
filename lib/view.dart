part of image_capture_field;

class ImageCaptureField extends StatelessWidget {
  ImageCaptureField({
    Key? key,
    required this.controller,
    required this.width,
    required this.height,
    this.imageQuality = 12,
    this.borderRadiusValue = 16,
    this.bottomRightDistance = 12,
  }) : super(key: key);
  final double width;
  final double height;
  final int imageQuality;
  final double borderRadiusValue;
  final double bottomRightDistance;

  // final Rxn<PickedFile> pickedFile;
  final ImageCaptureController controller;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () async {
          Get.bottomSheet(
            Container(
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
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            OpenWithButton(
                              iconName: 'Camera',
                              iconData: Icons.camera_alt,
                              onTap: () async {
                                controller.pickedImage.value =
                                    await _picker.getImage(
                                            source: ImageSource.camera,
                                            imageQuality: imageQuality) ??
                                        controller.pickedImage.value;
                                Get.back();
                              },
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            OpenWithButton(
                              iconName: 'Gallery',
                              iconData: Icons.photo,
                              onTap: () async {
                                controller.pickedImage.value =
                                    await _picker.getImage(
                                            source: ImageSource.gallery,
                                            imageQuality: imageQuality) ??
                                        controller.pickedImage.value;
                                Get.back();
                              },
                            ),
                          ]),
                    ]),
              ),
            ),
          );
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
                  image: controller.pickedImage.value != null
                      ? DecorationImage(
                          image: FileImage(
                              File(controller.pickedImage.value!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
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
          CircleAvatar(backgroundColor: Colors.teal, child: Icon(iconData)),
          SizedBox(height: 5),
          Text(
            iconName,
            textScaleFactor: 0.9,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
