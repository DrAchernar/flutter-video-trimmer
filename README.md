# flutrim

Example of a Flutter video trimmer. It picks a video from the gallery, lets you set a start and end, cuts that range, and saves the result back to the gallery.

Plugins used when this was published (February 2020):

- `flutter_ffmpeg` 0.2.10
- `video_player` 0.10.7
- `image_picker` 0.6.3+1
- `gallery_saver` ^1.0.7

The original iOS note said the camera roll (instead of the library root) needed a one-line change inside `image_picker`'s `FLTImagePickerPlugin`:

`_imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;`

That edit lives in the plugin cache, so it disappears on the next `pub get`.

## Notes from 18 October 2026

Reviewed again on this date. These points describe the code as it stands; they are not part of the original 2020 readme.

- Snapshot of the February 2020 tree. It is not being ported to current Flutter.
- Written with Flutter 1.12. The Dart constraint is `>=2.1.0 <3.0.0`, so `flutter pub get` fails on Dart 3.8 (Flutter 3.32) and on any null-safe Dart SDK. Building it needs a Flutter 1.12-era SDK.
- `flutter_ffmpeg` 0.2.10 is the discontinued plugin. `gallery_saver` is listed in `pubspec.yaml` and is missing from `pubspec.lock`.
- Android application id is still `com.example.flutrim`. The release build is signed with the debug key.
- The trim command in `lib/pages/editor.dart` is `-i <path> -ss <start> -t <duration> -c copy <output>`. `-ss` comes after `-i`, and the streams are copied. The cut sticks to the previous keyframe, so audio can start while the picture stays frozen. That is the report in issue #2. Timestamps are not reset, so trimming an already trimmed file can inflate the duration metadata. That is the report in issue #3.
- FFmpeg's return code is ignored. `execute(...).then` still shows "Finished!" when the command fails. A space in the file path also breaks the command, because the path is not quoted.
- The playback clock is a `Timer.periodic` created inside `build`. Each frame adds another timer, and `dispose` does not cancel them.
- Cancelling the gallery picker reads `video.path` when `video` is null. The info button does nothing (`onPressed: null`).
- The widget test imports `package:flutter_video_trimmer/main.dart`. The package name is `flutrim`, and the test still expects a counter.
- Dependabot's two high alerts are the old transitive `archive` package in `pubspec.lock` (filename spoofing and path traversal). The app does not use that package directly.
