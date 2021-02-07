import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginPage extends StatefulWidget {
  GoogleLoginPage({Key key}) : super(key: key);

  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {

  bool _isLogged = false;
  String _name;
  String _pictureURL;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> _didLogin(GoogleSignInAccount account) async {
    var auth = await account.authentication;
    final token = auth.accessToken;
    _name = account.displayName;
    _pictureURL = account.photoUrl;
    if (_pictureURL == null) {
      _pictureURL = "https://www.nomadfoods.com/wp-content/uploads/2018/08/placeholder-1-e1533569576673-960x960.png";
    }
    final beUser = await Backendless.userService.loginWithGoogle(
      token,
      fieldsMapping: <String, String>{}
    );

    print(beUser.properties);
  }

  void _initiateGoogleLogin() async {
    _googleSignIn.signIn()
      .then( (account) {
        _didLogin(account)
          .then( (_) {
            setState(() => _isLogged = true );
          });
      });
  }

  void _googleLogout() {
    Backendless.userService.logout()
      .then( (_) {
        _googleSignIn.signOut()
          .then( (account) {
            setState(() => _isLogged = false );
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
                onPressed: _googleLogout,
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
        child: Text("Google Login"),
        onPressed: _initiateGoogleLogin,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Login"),
      ),
      body: _isLogged ? _isLoggedWidget() : _loginWidget()
    );
  }
}