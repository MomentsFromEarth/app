import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatefulWidget {
  static const routeName = '/archive/upload';

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _image;
  final picker = ImagePicker();

  String _videoPath;
  String _thumbnailPath;

  FileImage _thumbnailImage;

  Future chooseMomentVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery, maxDuration: const Duration(seconds: 120));
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _videoPath = pickedFile.path;
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      _thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: pickedFile.path,
        imageFormat: ImageFormat.PNG,
        thumbnailPath: "$appDocPath/thumbnail.png"
      );
      updateThumbnailImage(_thumbnailPath);
    } else {
      print('No video selected.');
    }
  }

  updateThumbnailImage(String thumbnailPath) {
    setState(() {
      _thumbnailImage = new FileImage(File(thumbnailPath)); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('~/upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Video: $_videoPath"),
            SizedBox(height: 10),
            SizedBox(
              width: 320,
              height: 240,
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  image: _thumbnailImage != null ? DecorationImage(image: _thumbnailImage) : null
                ),
              )
            ),
            SizedBox(height: 10),
            FlatButton(
              child: Text('Choose'),
              color: Colors.green,
              textColor: Colors.white70,
              onPressed: chooseMomentVideo,
            ),
          ]
        )
      )
    );
  }
}