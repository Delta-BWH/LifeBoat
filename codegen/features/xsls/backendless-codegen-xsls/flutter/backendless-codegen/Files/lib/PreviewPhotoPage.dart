import 'package:flutter/material.dart';
import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';

class PreviewPhotoPage extends StatefulWidget {
	final File photo;

	const PreviewPhotoPage ({
    	Key key,
    	@required this.photo,
  	}) : super(key: key);

	@override
	_PreviewPhotoPageState createState() => _PreviewPhotoPageState();
}

class _PreviewPhotoPageState extends State<PreviewPhotoPage> {

  void _uploadPhoto() {
    final fileName = widget.photo.path
      .split("/")
      .last
      .replaceAll(" ", "_");

    _showIndicator();
    Backendless.files.upload(widget.photo, "photos/" + fileName)
      .then( (urlPath) {
        Backendless.data.of("MyPhotos").save({"path": urlPath})
          .then( (_) {
            Navigator.popUntil(context, (r) => r.isFirst );
          });
      });
  }

  void _takeOtherPhoto() {
    widget.photo
    .delete()
    .then( (_) {
      Navigator.pop(context); 
    });
  }

  void _showIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          width: 100,
          height: 100,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black38,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
          ),
        );
      } 
    );
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
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.77,
              child: Image.file(widget.photo)
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: 130,
                      padding: EdgeInsets.only(left: 10, top: 0, bottom: 8, right: 0),
                      child: RaisedButton(
                        onPressed: _uploadPhoto,
                        child: Text("Upload"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 130,
                      padding: EdgeInsets.only(left: 0, top: 0, bottom: 8, right: 10),
                      child: RaisedButton(
                        onPressed: _takeOtherPhoto,
                        child: Text("New photo"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}