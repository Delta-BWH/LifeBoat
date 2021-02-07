import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PropertiesPage.dart';
import 'OperationsHelper.dart';
import 'ListBorderHelper.dart';
import 'ObjectsWithRelationsPage.dart';

class CodeSamplePage extends StatefulWidget {

  CodeSamplePage({Key key, this.tableName, this.operation,
    this.sortBy, this.relationsToLoad}) : super(key: key);

  final String tableName;
  final String operation;
  final List<String> sortBy;
  final List<String> relationsToLoad;
  
  @override
  createState() => _CodeSampleState();
}

class _CodeSampleState extends State<CodeSamplePage> {

  String _codeSample;
  TextEditingController _textFieldController;

  @override
  void initState() {
    switch (widget.operation) {
      case "Create":
        _codeSample = OperationsHelper().createObjectCodeForTable(widget.tableName);
        break;
      case "Update":
        _codeSample = OperationsHelper().updateObjectCodeForTable(widget.tableName);
        break;
      case "Delete":
        _codeSample = OperationsHelper().deleteObjectCodeForTable(widget.tableName);
        break;
      case "Basic find":
        _codeSample = OperationsHelper().basicFindObjectCodeForTable(widget.tableName);
        break;
      case "Find first":
        _codeSample = OperationsHelper().findFirstObjectCodeForTable(widget.tableName);
        break;
      case "Find last":
        _codeSample = OperationsHelper().findLastObjectCodeForTable(widget.tableName);
        break;
      case "Find with sort":
        _codeSample = OperationsHelper().findSortObjectsCodeForTable(widget.tableName, widget.sortBy);
        break;
      case "Find with related":
        _codeSample = OperationsHelper().findWithRelatedObjectsCodeForTable(widget.tableName, widget.relationsToLoad);
        break;
    }

    _textFieldController = TextEditingController();

    super.initState();
  }

  void _showBasicAlert(String title, String message) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
              Text(message)
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              child: CupertinoButton(
                child: Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        );
      }
    );
  }

  void _sendCodeByEmail(String email) async {
    try {
      final messageStatus = await Backendless.messaging.sendTextEmail(
        "Backendless CRUD sample",
        _codeSample,
        [email]
      );
      _textFieldController.text = "";
      Navigator.pop(context);
    } on PlatformException catch (e) {
      _textFieldController.text = "";
      Navigator.pop(context);
      _showBasicAlert("Error!", e.message);
    }
  }

  void _onSendByEmail() async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Send code sample"),
          content: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
              Text("Enter your email address to send code sample"),
              Container(
                height: 20,
              ),
              CupertinoTextField(
                controller: _textFieldController,
                placeholder: "Email address",
                placeholderStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15
                ),
                decoration: BoxDecoration(
                  border: ListBorderHelper.allGreyBorders(),
                  borderRadius: BorderRadius.circular(6)
                ),
              )
            ],
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              onPressed: () {
                _textFieldController.text = "";
                Navigator.pop(context);
              },
            ),
            CupertinoButton(
              child: Text("Send"),
              onPressed: () => _sendCodeByEmail(_textFieldController.text),
            )
          ],
        );
      }
    );
  }

  void _onCreate() async {
    try {
      Map<dynamic, dynamic> newObject = {"codegen": "new object"};
      final savedObject = await Backendless.data.of(widget.tableName).save(newObject);
      final objectId = savedObject["objectId"] as String;
      OperationsHelper().currentObjectId = objectId;
      _showBasicAlert("Object saved", "Object has been created.\nObject Id - $objectId");
    } on PlatformException catch (e) {
      _showBasicAlert("Error!", e.message);
    }
  }

  void _onUpdate() async {
    try {
      final id = OperationsHelper().currentObjectId;
      if (id == null) {
        _showBasicAlert("Error!", "Please, create object before updating");
      } else {
        Map<dynamic, dynamic> object = {"codegen": "updatedObject", "objectId": id};
        final updatedObject = await Backendless.data.of(widget.tableName).save(object);
        final objectId = updatedObject["objectId"] as String;
        _showBasicAlert("Object has been updated", "Object has been updated.\nObject Id - $objectId");
      }
    } on PlatformException catch (e) {
      _showBasicAlert("Error!", e.message);
    }
  }

  void _onDelete() async {
    try {
      final id = OperationsHelper().currentObjectId;
      if (id == null) {
        _showBasicAlert("Error!", "Please, create object before deleting");
      } else {
        Map<dynamic, dynamic> entity = {"objectId": "$id"};
        await Backendless.data.of(widget.tableName).remove(entity: entity);
        OperationsHelper().currentObjectId = null;
        _showBasicAlert("Object deleted", "Object has been updated.\nObject Id - $id");
      }
    } on PlatformException catch (e) {
      _showBasicAlert("Error!", e.message);
    }
  }

  void _onFind({List<String> sortBy}) async {
    try {
      final properties = await Backendless.data.describe(widget.tableName);
      final propertiesToShow = properties
        .where( (property) {
          return (property.type != DataTypeEnum.RELATION
            && property.type != DataTypeEnum.RELATION_LIST);
        })
        .toList();
      final route = MaterialPageRoute(
        builder: (context) => PropertiesPage(
          tableName: widget.tableName,
          operation: widget.operation,
          properties: propertiesToShow,
          sortBy: sortBy,
        )
      );
      Navigator.push(context, route);
    } on PlatformException catch (e) {
      _showBasicAlert("Error!", e.message);
    }
  }

  void _onFindWithRelated() async {
    try {
      final foundObjects = await Backendless.data.of(widget.tableName).find();
      final ids = foundObjects
        .map( (v) => v["objectId"] as String)
        .toList();

      final route = MaterialPageRoute(
        builder: (context) => ObjectsWithRelationsPage(ids, widget.tableName, selectedRelations: widget.relationsToLoad)
      );
      Navigator.push(context, route);
    } on PlatformException catch (e) {
      _showBasicAlert("Error!", e.message);
    }
  }

  void _runCode() {
    switch (widget.operation) {
      case "Create":
        _onCreate();
        break;
      case "Update":
        _onUpdate();
        break;
      case "Delete":
        _onDelete();
        break;
      case "Basic find":
      case "Find first":
      case "Find last":
        _onFind();
        break;
      case "Find with sort":
        _onFind(sortBy: widget.sortBy);
        break;
      case "Find with related":
        _onFindWithRelated();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Sample"),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.04,
                ),
                Container(
                  height: constraints.maxHeight * 0.68,
                  width: constraints.maxWidth * 0.9,
                  color: Color.fromARGB(255, 220, 220, 220),
                  child: Text(
                    _codeSample,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "RobotoMono"
                    ),
                  )
                ),
                Container(
                  height: constraints.maxHeight * 0.04,
                ),
                Container(
                  height: constraints.maxHeight * 0.08,
                  width: constraints.maxWidth,
                  child: GestureDetector(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Run Code",
                        style: TextStyle(
                          color: CupertinoColors.activeBlue
                        ),
                      ),
                    ),
                    onTap: _runCode,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.04,
                ),
                Container(
                  height: constraints.maxHeight * 0.08,
                  child: GestureDetector(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Send code by email",
                        style: TextStyle(
                          color: CupertinoColors.activeBlue
                        ),
                      ),
                    ),
                    onTap: _onSendByEmail,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.04,
                ),
              ],
            );
          }
        )
      )
    );
  }
}