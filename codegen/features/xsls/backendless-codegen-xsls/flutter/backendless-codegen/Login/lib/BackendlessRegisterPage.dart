import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

class BackendlessRegisterPage extends StatefulWidget {
  BackendlessRegisterPage({Key key}) : super(key: key);

  @override
  _BackendlessRegisterPageState createState() => _BackendlessRegisterPageState();
}

class _BackendlessRegisterPageState extends State<BackendlessRegisterPage> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();

  void _onRegister() {
    final user = BackendlessUser()
      ..email = _emailController.text
      ..password = _passController.text
      ..setProperty("name", _nameController.text);

    Backendless.userService.register(user)
      .then( (_) => Navigator.pop(context) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backendless Register"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CupertinoTextField(
                  placeholder: "Email",
                  controller: _emailController,
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CupertinoTextField(
                  placeholder: "Password",
                  controller: _passController,
                  obscureText: true,
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CupertinoTextField(
                  placeholder: "Name",
                  controller: _nameController,
                ),
              ),
              Container(
                height: 10,
              ),
              CupertinoButton(
                child: Text("Register"),
                onPressed: _onRegister,
              )
            ],
          ),
        ),
      )
    );
  }
}