import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'ListBorderHelper.dart';
import 'PropertiesPage.dart';

class ObjectsWithRelationsPage extends StatefulWidget {
  ObjectsWithRelationsPage(this.ids, this.tableName, {this.selectedRelations, Key key}) : super(key: key);

  final List<String> ids;
  final String tableName;
  final List<String> selectedRelations;

  @override
  createState() => _ObjectsWithRelations();
}

class _ObjectsWithRelations extends State<ObjectsWithRelationsPage> {

  void _didSelectRowAtIndex(int index) async {
    final properties = await Backendless.data.describe(widget.tableName);

    final route = MaterialPageRoute(
      builder: (context) => PropertiesPage(
        tableName: widget.tableName,
        operation: "Find with related",
        properties: properties,
      )
    );

    Navigator.push(context, route);
  }

  Widget _prepareListItem(BuildContext context, int index) {
    return Container(
      height: 80,
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.ids[index]),
          ),
        ),
        onTap: () => _didSelectRowAtIndex(index),
      ),
      decoration: BoxDecoration(
        border: ListBorderHelper.borderForIndex(index, of: widget.ids.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select object"),
      ),
      body: ListView.builder(
        itemCount: widget.ids.length,
        itemBuilder: _prepareListItem,
      ),
    );
  }
}