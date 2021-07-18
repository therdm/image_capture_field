import 'package:flutter/material.dart';

class OpenWithCameraOrGallery extends StatelessWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;
  final Color iconBackgroundColor;
  const OpenWithCameraOrGallery({
    Key? key,
    required this.onTapCamera,
    required this.onTapGallery,
    required this.iconBackgroundColor,
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
                  iconBackgroundColor: iconBackgroundColor,
                ),
                const SizedBox(width: 30),
                OpenWithButton(
                  iconName: 'Gallery',
                  iconData: Icons.photo,
                  onTap: onTapGallery,
                  iconBackgroundColor: iconBackgroundColor,
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
    required this.iconBackgroundColor,
  }) : super(key: key);
  final Function() onTap;
  final IconData iconData;
  final String iconName;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: iconBackgroundColor,
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
