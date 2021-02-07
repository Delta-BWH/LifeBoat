import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PhotoPage.dart';

class BrowsePhotosPage extends StatefulWidget {
  BrowsePhotosPage({Key key, this.entities}) : super(key: key);

  final List<Map<dynamic, dynamic>> entities;
  
  @override
  _BrowsePhotosPageState createState() => _BrowsePhotosPageState();
}

class _BrowsePhotosPageState extends State<BrowsePhotosPage> {

  Widget _getRow(int position) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.25
          )
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Image.network(widget.entities[position]["path"])
              ),
              Flexible(
                  child: Text(
                    Uri.decodeFull(
                      widget.entities[position]["path"]
                        .toString()
                        .split("/")
                        .last
                    ),
                    maxLines: 3,
                    softWrap: true,
                  ),
              )
            ],
          )
        )
      ),
      onTap: () {
        final String currentImgPath = widget.entities[position]["path"];
        final photo = Image.network(currentImgPath);
        final route = MaterialPageRoute(builder: (context) => PhotoPage(photo: photo));
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Browse photos"),
      ),
      body: ListView.builder(
        itemCount: widget.entities.length,
        itemBuilder: (BuildContext context, int position) {
          return _getRow(position);
      })
    );
  }
}