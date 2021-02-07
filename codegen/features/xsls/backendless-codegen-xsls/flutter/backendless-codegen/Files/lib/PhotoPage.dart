import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key, this.photo}) : super(key: key);

  final Image photo;
  
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloaded photo"),
      ),
      body: Center(
        child: widget.photo
      ),
    );
  }
}