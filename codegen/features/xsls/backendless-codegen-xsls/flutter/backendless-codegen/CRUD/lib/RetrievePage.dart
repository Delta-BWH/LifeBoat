import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'ListBorderHelper.dart';
import 'CodeSamplePage.dart';
import 'SelectionPage.dart';

enum SelectionType {
  sortBy, related
}

class RetrievePage extends StatefulWidget {

  RetrievePage({Key key, this.tableName}) : super(key: key);

  final String tableName;

  @override
  createState() => _RetrieveState();
}

class _RetrieveState extends State<RetrievePage> {

  final _retrieveOperations = ["Basic find", "Find first", "Find last", "Find with sort", "Find with related"];

  void _showFindCodeSample(String operation) {
    final route = MaterialPageRoute(
      builder: (context) => CodeSamplePage(
        tableName: widget.tableName,
        operation: operation)
    );
    Navigator.push(context, route);
  }

  void _showSortSelection(SelectionType type) async {
    final properties = await Backendless.data.describe(widget.tableName);

    List<ObjectProperty> propertiesToSort;

    switch (type) {
      case SelectionType.sortBy:
        propertiesToSort = properties
          .where( (property) {
            return (property.type != DataTypeEnum.RELATION
              && property.type != DataTypeEnum.RELATION_LIST);
          })
          .toList();
        break;
      case SelectionType.related:
        propertiesToSort = properties
          .where( (property) {
            return (property.type == DataTypeEnum.RELATION
              || property.type == DataTypeEnum.RELATION_LIST);
          })
          .toList();
        break;
    } 

    final route = MaterialPageRoute(
      builder: (context) => SelectionPage(
        tableName: widget.tableName,
        properties: propertiesToSort,
        selectionType: type,
      )
    );

    Navigator.push(context, route);
  }

  void _didSelectRowAtIndex(int index) {
    final operation = _retrieveOperations[index];

    switch (operation) {
      case "Basic find":
      case "Find first":
      case "Find last":
        _showFindCodeSample(operation);
        break;
      case "Find with sort":
        _showSortSelection(SelectionType.sortBy);
        break;
      case "Find with related":
        _showSortSelection(SelectionType.related);
        break;
    }
  }

  Widget _prepareListItem(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        height: 80,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(_retrieveOperations[index]),
          ),
        ),
        decoration: BoxDecoration(
          border: ListBorderHelper.borderForIndex(index, of: _retrieveOperations.length)
        ),
      ),
      onTap: () => _didSelectRowAtIndex(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve data"),
      ),
      body: ListView.builder(
        itemCount: _retrieveOperations.length,
        itemBuilder: _prepareListItem,
      )
    );
  }
}