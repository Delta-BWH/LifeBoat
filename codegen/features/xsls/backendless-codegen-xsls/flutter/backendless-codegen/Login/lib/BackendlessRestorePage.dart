import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

class BackendlessRestorePage extends StatefulWidget {
  BackendlessRestorePage({Key key}) : super(key: key);

  @override
  _BackendlessRestorePageState createState() => _BackendlessRestorePageState();
}

class _BackendlessRestorePageState extends State<BackendlessRestorePage> {

  final _emailController = TextEditingController();

  void _onRestore() {
    final email = _emailController.text;
    Backendless.userService.restorePassword(email)
      .then( (_) => Navigator.pop(context) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backendless Restore"),
      ),
      body: Center(
        child: Container(
          height: 120,
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.75,
                child: CupertinoTextField(
                 placeholder: "Email",
                  controller: _emailController,
                ),
              ),
              Container(
                height: 10,
              ),
              CupertinoButton(
                child: Text("Restore"),
                onPressed: _onRestore,
              )
            ],
          ),
        ),
      )
    );
  }
}