import 'dart:convert';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart';

class FacebookLoginPage extends StatefulWidget {
  FacebookLoginPage({Key key}) : super(key: key);

  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {

  var _fbLogin = FacebookLogin();
  var _http = Client();
  bool _isLogged = false;
  String _name;
  String _pictureURL;

  Future<void> _didLogin(FacebookLoginResult result) async {
    final token = result.accessToken.token;
    var response = await _http.get("https://graph.facebook.com/v2.12/me?fields=name,picture.height(200)&access_token=$token");
    var decodedJson = json.decode(response.body);
    _name = decodedJson["name"];
    _pictureURL = decodedJson["picture"]["data"]["url"];
    final beUser = await Backendless.userService.loginWithFacebook(
      result.accessToken.token,
      fieldsMapping: <String, String>{}
    );

    print(beUser.properties);
  }

  void _initiateFacebookLogin() async {
    var loginResult = await _fbLogin.logIn(["email", "public_profile"]);
    switch (loginResult.status) {
      case FacebookLoginStatus.loggedIn:
        _didLogin(loginResult)
          .then( (_) {
            setState(() => _isLogged = true);
          });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled by user");
        break;
      case FacebookLoginStatus.error:
        print("Something goes wrong");
    }
  }

  void _fbLogout() {
    Backendless.userService.logout()
      .then( (_) {
        _fbLogin.logOut()
          .then( (_) {
            setState( () => _isLogged = false);
          });
      });
  }

  Widget _isLoggedWidget() {
    return Center(
      child: Container(
        height: 400,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(_pictureURL),
              )
            ),
            Container(
              height: 50,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10
                ),
                child: Text(
                  _name,
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
              )
            ),
            Container(
              height: 30,
            ),
            Container(
              height: 50,
              child: CupertinoButton(
                child: Text("Logout"),
                color: Colors.blue,
                onPressed: _fbLogout,
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _loginWidget() {
    return Center(
      child: CupertinoButton(
        color: CupertinoColors.activeBlue,
        child: Text("FB Login"),
        onPressed: _initiateFacebookLogin,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Login"),
      ),
      body: _isLogged ? _isLoggedWidget() : _loginWidget()
    );
  }
}