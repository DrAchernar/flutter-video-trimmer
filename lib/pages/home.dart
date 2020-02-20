import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutrim/pages/editor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Editor(picked: video)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutrim"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10,120,10,0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                RaisedButton(
                  padding: EdgeInsets.all(25),
                  color: Colors.red[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(75.0),
                      side: BorderSide(color: Colors.grey[400])
                  ),
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Icon(Icons.add, color: Colors.white, size: 50,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
