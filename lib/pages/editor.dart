import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutrim/trimmer/trimmer.dart';

// ignore: must_be_immutable
class Editor extends StatefulWidget {
  File picked;

  Editor({this.picked});

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  TextEditingController timeBoxControllerStart = TextEditingController();
  TextEditingController timeBoxControllerEnd = TextEditingController();

  VideoPlayerController _videoPlayerController;
  var gradesRange = RangeValues(0, 100);

  InputDecoration timeBoxDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(0.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    fillColor: Colors.grey[200],
    filled: true,
  );

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white70),
        title: Text(
          'Flutrim',
          style: TextStyle(fontSize: 25, color: Colors.white70),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: null,
            iconSize: 35,
          )
        ],
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              height: height / 1.7,
              padding: EdgeInsets.fromLTRB(width / 28, 20, width / 28, 0),
              child: _videoPlayerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    )
                  : Container(),
            ),
            Positioned(
              top: height / 1.7,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.grey,
                margin: EdgeInsets.fromLTRB(width / 30, 0, width / 30, 0),
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 20,
                    rangeThumbShape: CustomRangeThumbShape(),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 5),
                  ),
                  child: RangeSlider(
                    min: 0,
                    max: 100,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    labels: RangeLabels(
                        '${gradesRange.start}', '${gradesRange.end}'),
                    values: gradesRange,
                    onChanged: (RangeValues value) {
                      setState(() {
                        if (value.end - value.start >= 5) {
                          gradesRange = value;
                          timeBoxControllerStart.text =
                              gradesRange.start.truncate().toString();
                          timeBoxControllerEnd.text =
                              gradesRange.end.truncate().toString();
                        } else {
                          if (gradesRange.start == value.start) {
                            gradesRange = RangeValues(
                                gradesRange.start, gradesRange.start + 5);
                          } else {
                            gradesRange = RangeValues(
                                gradesRange.end - 5, gradesRange.end);
                          }
                          timeBoxControllerStart.text =
                              gradesRange.start.truncate().toString();
                          timeBoxControllerEnd.text =
                              gradesRange.end.truncate().toString();
                        }
                        //gradesRange = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: height / 1.55,
              left: 20,
              right: 20,
              child: Container(
                height: height / 5,
                decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Start',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Colors.grey,
                                  width: 20,
                                  height: 23,
                                  padding: EdgeInsets.all(0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: null,
                                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 100,
                                  height: 23,
                                  padding: EdgeInsets.all(0.0),
                                  child: TextField(
                                    enabled: false,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    textAlign: TextAlign.center,
                                    controller: timeBoxControllerStart,
                                    decoration: timeBoxDecoration,
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 20,
                                  height: 23,
                                  padding: EdgeInsets.all(0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: null,
                                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'End',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  color: Colors.grey,
                                  width: 20,
                                  height: 23,
                                  padding: EdgeInsets.all(0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: null,
                                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 100,
                                  height: 23,
                                  padding: EdgeInsets.all(0.0),
                                  child: TextField(
                                    enabled: false,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                    textAlign: TextAlign.center,
                                    controller: timeBoxControllerEnd,
                                    decoration: timeBoxDecoration,
                                  ),
                                ),
                                Container(
                                  color: Colors.grey,
                                  width: 20,
                                  height: 23,
                                  padding: EdgeInsets.all(0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: null,
                                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              _videoPlayerController.value.isPlaying
                                  ? _videoPlayerController.pause()
                                  : _videoPlayerController.play();
                            });
                          },
                          color: Colors.grey[850],
                          child: Icon(
                            _videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(75.0),
                              side: BorderSide(color: Colors.grey[400])),
                          onPressed: () {
                            return null;
                          },
                          child: Text(
                            'Trim',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                          },
                          color: Colors.grey[850],
                          child: Icon(
                            Icons.refresh,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
