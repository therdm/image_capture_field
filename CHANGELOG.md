## 0.2.0

width and height properties are no more required , and a new property initialImage (ImageProvider) added
and includeCropper is now by default set to true, you need to set it to false if you don't need it

## 0.1.3

Cleaner ReadMe and option to give icons background color added. to match this widget according to your theme

## 0.1.2

Bug fix in web support and showing Loading... when going to cropper page

## 0.1.1

More clean and clear ReadMe and some screenshots
 

## 0.1.0

Crop functionality added you can use it by setting 
includeCropper: true;
fix cropper aspect ratio => aspectRatio : width / height or whatever you want
in the ImageCaptureController
getter imagePickedFile of type PickedFile is removed

made it more simple 
getters in the ImageCaptureController
   imageName => name of the picked image 
   imageData => image data in Uint8List
   isBlank => there is any image already picked or not
 

## 0.0.6

in the ImageCaptureController
image is now => imagePickedFile
newly added getter imageUInt8List to get image as Uint8List and imageName to get image name

## 0.0.5

some bug fixes for web support

## 0.0.4

Enabling Web Support, and some bug fixes

## 0.0.3

ImageCaptureController now has two property : image (Picked File), isBlank (boolean)

## 0.0.2

Specified what you get in return from controller.image (PickedFile) instead of dynamic 

## 0.0.1

ImageCaptureField is as easy-to-use as a TextField which works with it's own controller to take image input 


