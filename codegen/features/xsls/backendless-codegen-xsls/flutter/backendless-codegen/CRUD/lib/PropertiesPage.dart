import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'ListBorderHelper.dart';
import 'ObjectsPage.dart';

class PropertiesPage extends StatefulWidget {

  PropertiesPage({Key key, this.tableName, this.operation,
    this.properties, this.sortBy}) : super(key: key);
  
  final String tableName;
  final String operation;
  final List<ObjectProperty> properties;
  final List<String> sortBy;

  @override
  createState() => _PropertiesState();
}

class _PropertiesState extends State<PropertiesPage> {

  Future<MaterialPageRoute> _routeForBasicFind(ObjectProperty property) async {
    final foundObjects = await Backendless.data.of(widget.tableName).find();
    final objectsToShow = foundObjects
      .map( (object) => "${object[property.name]}")
      .toList();

    return MaterialPageRoute(
      builder: (context) => ObjectsPage(rawObjects: objectsToShow, propertyType: property.type)
    );
  }

  Future<MaterialPageRoute> _routeForFindFirst(ObjectProperty property) async {
    final foundObject = await Backendless.data.of(widget.tableName).findFirst();
    final mappedObject = "${foundObject[property.name]}";

    return MaterialPageRoute(
      builder: (context) => ObjectsPage(rawObjects: [mappedObject], propertyType: property.type)
    );
  }

  Future<MaterialPageRoute> _routeForFindLast(ObjectProperty property) async {
    final foundObject = await Backendless.data.of(widget.tableName).findLast();
    final objectToShow = "${foundObject[property.name]}";

    return MaterialPageRoute(
      builder: (context) => ObjectsPage(rawObjects: [objectToShow], propertyType: property.type)
    );
  }
  
  Future<MaterialPageRoute> _routeForFindSorted(ObjectProperty property) async {
    final queryBuilder = DataQueryBuilder()
      ..sortBy = widget.sortBy;

    final foundObjects = await Backendless.data.of(widget.tableName).find(queryBuilder);
    final objectsToShow = foundObjects
      .map( (object) => "${object[property.name]}")
      .toList();

    return MaterialPageRoute(
      builder: (context) => ObjectsPage(rawObjects: objectsToShow, propertyType: property.type)
    );
  }

  void _showObjects(ObjectProperty property) async {
    MaterialPageRoute route;

    switch (widget.operation) {
      case "Basic find":
      case "Find with related":
        route = await _routeForBasicFind(property);
        break;
      case "Find first":
        route = await _routeForFindFirst(property);
        break;
      case "Find last":
        route = await _routeForFindLast(property);
        break;
      case "Find with sort":
        route = await _routeForFindSorted(property);
        break;
    }

    Navigator.push(context, route);
  }

  void _showRelatedTableProperties(ObjectProperty property) async {
    final relatedTableName = property.relatedTable;
    final properties = await Backendless.data.describe(relatedTableName);
    final propertiesToShow = properties
      .where( (property) {
        return (property.type != DataTypeEnum.RELATION
          && property.type != DataTypeEnum.RELATION_LIST);
      })
      .toList();
    final route = MaterialPageRoute(
      builder: (context) => PropertiesPage(
        tableName: relatedTableName,
        operation: widget.operation,
        properties: propertiesToShow,
      )
    );
    Navigator.push(context, route);
  }

  void _didSelectRowAtIndex(int index) async {
    final selectedProperty = widget.properties[index];

    if (selectedProperty.type != DataTypeEnum.RELATION
      && selectedProperty.type != DataTypeEnum.RELATION_LIST) {
        _showObjects(selectedProperty);
    } else {
      _showRelatedTableProperties(selectedProperty);
    }
  }

  Widget _prepareListItem(BuildContext context, int index) {
    return Container(
      height: 80,
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.properties[index].name),
          ),
        ),
        onTap: () => _didSelectRowAtIndex(index),
      ),
      decoration: BoxDecoration(
        border: ListBorderHelper.borderForIndex(index, of: widget.properties.length)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.tableName} properties"),
      ),
      body: ListView.builder(
        itemCount: widget.properties.length,
        itemBuilder: _prepareListItem,
      )
    );
  }
}