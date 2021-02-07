import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'BackendlessRegisterPage.dart';
import 'BackendlessRestorePage.dart';

class BackendlessLoginPage extends StatefulWidget {
  BackendlessLoginPage({Key key}) : super(key: key);

  @override
  _BackendlessLoginPageState createState() => _BackendlessLoginPageState();
}

class _BackendlessLoginPageState extends State<BackendlessLoginPage> {

  bool _isLogged = false;
  String _name;
  String _pictureURL;
  bool _rememberMe = false;
  final _loginController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _didLogin(BackendlessUser user) async {
    _name = user.email;
    _pictureURL = "https://pbs.twimg.com/profile_images/1110565970119143430/-cTs4vSi.png";
  }

  void _initiateBackendlessLogin() async {
    final login = _loginController.text;
    final pass = _passController.text;

    try {
      Backendless.userService.login(login, pass, _rememberMe)
      .then( (loggedUser) {
        _didLogin(loggedUser)
          .then( (_) {
            _loginController.text = "";
            _passController.text = "";
            setState( () => _isLogged = true);
          });
      });
    } on PlatformException catch (exc) {
      print("~~~> Platform exception: ${exc.message}");
    }
  }

  void _onRegister() {
    final route = MaterialPageRoute(
      builder: (context) => BackendlessRegisterPage(),
    );
    Navigator.push(context, route);
  }

  void _onRestore() {
    final route = MaterialPageRoute(
      builder: (context) => BackendlessRestorePage(),
    );
    Navigator.push(context, route);
  }

  void _backendlessLogout() {
    Backendless.userService.logout()
      .then( (_) {
        setState( () => _isLogged = false);
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
                onPressed: _backendlessLogout,
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _loginWidget() {
    return Center(
    child: Container(
    padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.75,
            child: CupertinoTextField(
              placeholder: "Login",
              controller: _loginController,
            )
          ),
          Container(
            height: 5,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.75,
            child: CupertinoTextField(
              placeholder: "Password",
              controller: _passController,
              obscureText: true,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                Text("Remember me"),
                CupertinoSwitch(
                  value: _rememberMe,
                  onChanged: (value) => setState(() => _rememberMe = value),
                )
              ],
            ),
          ),
          Container(
            height: 10,
          ),
          CupertinoButton(
            child: Text("Login"),
            onPressed: _initiateBackendlessLogin,
          ),
          Container(
            height: 60,
          ),
          Container(
            height: 55,
            child: CupertinoButton(
              child: Text("Register"),
              onPressed: _onRegister,
            ),
          ),
          Container(
            height: 50,
            child: CupertinoButton(
              child: Text("Restore password"),
              onPressed: _onRestore,
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backendless Login"),
      ),
      body: _isLogged ? _isLoggedWidget() : _loginWidget()
    );
  }
}
