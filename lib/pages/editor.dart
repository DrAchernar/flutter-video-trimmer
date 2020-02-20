import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class Editor extends StatefulWidget {
  File picked;

  Editor({this.picked});

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.picked)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 120, 10, 0),
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}
