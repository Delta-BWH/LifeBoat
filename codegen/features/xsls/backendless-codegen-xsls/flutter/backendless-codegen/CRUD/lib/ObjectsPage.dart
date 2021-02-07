import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'DataMapper.dart';
import 'ListBorderHelper.dart';

class ObjectsPage extends StatefulWidget {
  ObjectsPage({Key key, this.rawObjects, this.propertyType}) : super(key: key);
  
  final List<String> rawObjects;
  final DataTypeEnum propertyType;

  @override
  createState() => _ObjectsState();
}

class _ObjectsState extends State<ObjectsPage> {

  List<String> data;

  @override
  void initState() {
    data = DataMapper.prepareData(widget.rawObjects, widget.propertyType);

    super.initState();
  }

  Widget _prepareListItem(BuildContext context, int index) {
    return Container(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(data[index]),
        ),
      ),
      decoration: BoxDecoration(
        border: ListBorderHelper.borderForIndex(index, of: data.length)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Values"),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: _prepareListItem,
      )
    );
  }
}