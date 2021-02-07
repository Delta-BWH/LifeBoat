import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'PreviewPhotoPage.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage ({
      Key key,
      @required this.camera,
    }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  void _takePhoto() async {
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
            '${DateTime.now()}.jpg',
        );
      await _controller.takePicture(path);

      final photoFile = File(path);
      final viewPhotoPage = PreviewPhotoPage(photo: photoFile);
      Navigator.push(this.context, MaterialPageRoute(builder: (context) => viewPhotoPage) );

    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
      super.initState();
    
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.low,
      );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a photo"),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
             child: FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: _takePhoto,
            ),
          )
        ],
      )
    );
  }
}