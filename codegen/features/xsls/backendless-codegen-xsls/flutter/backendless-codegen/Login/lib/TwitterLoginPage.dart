import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_twitter/flutter_twitter.dart';

class TwitterLoginPage extends StatefulWidget {
  TwitterLoginPage({Key key}) : super(key: key);

  @override
  _TwitterLoginPageState createState() => _TwitterLoginPageState();
}

class _TwitterLoginPageState extends State<TwitterLoginPage> {

  bool _isLogged = false;
  String _name;
  String _pictureURL;

  final _twitterLogin = TwitterLogin(
    consumerKey: "<YOUR-TWITTER-API-KEY>",
    consumerSecret: "<YOUR-TWITTER-API-SECRET>"
  );

  Future<void> _didLogin(TwitterLoginResult result) async {
    _name = result.session.username;
    _pictureURL = "https://pbs.twimg.com/profile_images/1111729635610382336/_65QFl7B.png";
    final token = result.session.token;
    final secret = result.session.secret;

    final beUser = await Backendless.userService.loginWithTwitter(
      token,
      secret,
      fieldsMapping: <String, String>{}
    );

    print(beUser.properties);
  }

  void _initiateTwitterLogin() async {
    final loginResult = await _twitterLogin.authorize();
    
    switch (loginResult.status) {
      case TwitterLoginStatus.loggedIn:
        _didLogin(loginResult)
          .then( (_) {
            setState(() => _isLogged = true );
          });
        break;
      case TwitterLoginStatus.cancelledByUser:
        print("~~~> Cancelled by user");
        break;
      case TwitterLoginStatus.error:
        print("~~~> Error on login: ${loginResult.errorMessage}");
        break;
    }
  }

  void _twitterLogout() {
    Backendless.userService.logout()
      .then( (_) {
        _twitterLogin.logOut()
          .then( (_) {
            setState( () => _isLogged = false );
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
                onPressed: _twitterLogout,
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
        child: Text("Twitter Login"),
        onPressed: _initiateTwitterLogin,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Twitter Login"),
      ),
      body: _isLogged ? _isLoggedWidget() : _loginWidget()
    );
  }
}