# flutrim

A video Trimmer example written v Flutter.

Used image_picker to choose video from gallery. It browse default library path to choose media.

For iOS : If you want to choose media from camera roll (not root library list),
 
you need to modify just a row in image_picker's FLTImagePickerPlugin class.
`_imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;`

Then video_player, gallery_saver and ffmpeg is enough for everything.

Enjoy and add new functions... for ex: crop and effect

-Screenshots

![s1](https://raw.githubusercontent.com/DrAchernar/flutter-video-trimmer/master/screenshots/IMG_0086.jpeg)
![s2](https://raw.githubusercontent.com/DrAchernar/flutter-video-trimmer/master/screenshots/IMG_0088.jpeg)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
