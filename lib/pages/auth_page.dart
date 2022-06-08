import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maxfit/domain/AuthUser.dart';
import 'package:maxfit/services/auth_services.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Container(
          child: Align(
            child: Text(
              'MAXFIT',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white30,
            ),
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 3,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white54,
                width: 1,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: icon,
              ),
            ),
          ),
        ),
      );
    }

    Widget _button(String text, void Function() func) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        onPressed: () {
          func();
        },
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
          ),
        ),
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
              child:
                  _input(Icon(Icons.email), 'Email', _emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
              child: _input(
                  Icon(Icons.lock), 'Password', _passwordController, true),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            ),
          ],
        ),
      );
    }

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      AuthUser? authUser = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());

      if(authUser == null)
      {
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please, check your email/password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      AuthUser? authUser = await _authService.registerInWithEmailAndPassword(_email.trim(), _password.trim());

      if(authUser == null)
      {
        Fluttertoast.showToast(
            msg: "Can't Register you! Please, check your email/password!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Widget _bottomWave() {
      return Expanded(
          child: Align(
        child: ClipPath(
          child: Container(
            color: Colors.white,
            height: 300,
          ),
          clipper: BottomWaveClipper(),
        ),
        alignment: Alignment.bottomCenter,
      ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _logo(),
          SizedBox(
            height: 100.0,
          ),
          (showLogin
              ? Column(
                  children: <Widget>[
                    _form('LOGIN', _loginButtonAction),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: const Text('Not registered yet? Register!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          onTap: () {
                            setState(() {
                              showLogin = false;
                            });
                          }),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    _form('REGISTER', _registerButtonAction),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: const Text('Already registered yet? Login!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          onTap: () {
                            setState(() {
                              showLogin = true;
                            });
                          }),
                    )
                  ],
                )),
          _bottomWave()
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
