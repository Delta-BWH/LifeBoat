import 'package:flutter/material.dart';
import 'CodeSamplePage.dart';
import 'ListBorderHelper.dart';
import 'RetrievePage.dart';

class OperationsListPage extends StatefulWidget {

  OperationsListPage({Key key, this.tableName}) : super(key: key);

  final String tableName;

  @override
  createState() => _OperationsListState();
}

class _OperationsListState extends State<OperationsListPage> {

  final _operations = ["Create", "Retrieve", "Update", "Delete"];

  void _didSelectRowAtIndex(int index) {
    MaterialPageRoute route;

    final operation = _operations[index];

    if (operation == "Retrieve") {
      route = MaterialPageRoute(
        builder: (context) => RetrievePage(tableName: widget.tableName)
      );
    } else {
      route = MaterialPageRoute(
        builder: (context) => CodeSamplePage(tableName: widget.tableName, operation: operation)
      );
    }

    Navigator.push(context, route);
  }

  Widget _prepareListItem(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        height: 80,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(_operations[index]),
          ),
        ),
        decoration: BoxDecoration(
          border: ListBorderHelper.borderForIndex(index, of: _operations.length)
        ),
      ),
      onTap: () => _didSelectRowAtIndex(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Operations"),
      ),
      body: ListView.builder(
        itemCount: _operations.length,
        itemBuilder: _prepareListItem,
      )
    );
  }
}