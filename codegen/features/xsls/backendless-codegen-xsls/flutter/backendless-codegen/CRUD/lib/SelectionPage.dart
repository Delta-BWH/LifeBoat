import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'CodeSamplePage.dart';
import 'RetrievePage.dart';
import 'ListBorderHelper.dart';
import 'package:flutter/cupertino.dart';

class SelectionPage extends StatefulWidget {
  SelectionPage({Key key, this.tableName, this.properties, this.selectionType}) : super(key: key);

  final String tableName;
  final List<ObjectProperty> properties;
  final SelectionType selectionType;

  @override
  createState() => _SelectionState();
}

class _SelectionState extends State<SelectionPage> {

  List<bool> _propertiesSelection;

  @override
  void initState() {
    super.initState();

    _propertiesSelection = List.generate(widget.properties.length, (_) {
      return false;
    });
  }

  Widget _prepareListItem(BuildContext context, int index) {
    return Container(
      height: 80,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: <Widget>[
              Container(
                width: constraints.maxWidth * 0.77,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.properties[index].name),
                  ),
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.23,
                child: CupertinoSwitch(
                  value: _propertiesSelection[index],
                  onChanged: (isActive) => setState(() => _propertiesSelection[index] = isActive),
                )
              ),
            ],
          );
        }
      ),
      decoration: BoxDecoration(
        border: ListBorderHelper.borderForIndex(index, of: widget.properties.length)
      ),
    );
  }

  void _showCodeSample() {
    List<String> selectedProperties = [];

    _propertiesSelection
      .asMap()
      .forEach( (index, isActive) {
        if (isActive) {
          selectedProperties.add(widget.properties[index].name);
        }
      });

    MaterialPageRoute route;

    switch (widget.selectionType) {
      case SelectionType.sortBy:
        route = MaterialPageRoute(
          builder: (context) => CodeSamplePage(
            operation: "Find with sort",
            tableName: widget.tableName,
            sortBy: selectedProperties,
          )
        );
        break;
      case SelectionType.related:
        route = MaterialPageRoute(
          builder: (context) => CodeSamplePage(
            operation: "Find with related",
            tableName: widget.tableName,
            relationsToLoad: selectedProperties,
          )
        );
        break;
    }

    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectionType == SelectionType.sortBy ? "Sort by" : "Relations"),
        actions: <Widget>[
          GestureDetector(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text("Next"),
              )
            ),
            onTap: _showCodeSample,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.properties.length,
        itemBuilder: _prepareListItem,
      )
    );
  }
}