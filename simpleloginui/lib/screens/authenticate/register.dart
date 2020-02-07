import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simpleloginui/services/auth.dart';
import 'package:simpleloginui/shared/loading.dart';

import '../buttom_menu.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool isLoading = false;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String error = '';
  bool showBottomMenu = false;
  final threshold = 100;

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('Sign up to Brew Crew'),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => navigate(),
                  icon: Icon(Icons.person, color: Colors.brown[600]),
                  label: Text(
                    'Login',
                    style: TextStyle(color: Colors.brown[600]),
                  ),
                )
              ],
            ),
            body: GestureDetector(
              onPanEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > threshold) {
                  setState(() => showBottomMenu = false);
                } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
                  setState(() => showBottomMenu = true);
                }
              },
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      child: Form(
                        key: widget._formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 20.0,
                            ),
                            TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a valid email' : null,
                              onChanged: (val) {
                                setState(() => widget._email = val);
                              },
                              decoration: InputDecoration(hintText: 'Email'),
                            ),
                            Container(
                              height: 20.0,
                            ),
                            TextFormField(
                              onChanged: (val) {
                                setState(() => widget._password = val);
                              },
                              validator: (val) => val.length < 6
                                  ? 'Enter a password  at least 6 char long'
                                  : null,
                              decoration: InputDecoration(hintText: 'Password'),
                              obscureText: true,
                            ),
                            Container(
                              height: 20.0,
                            ),
                            Container(
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () => signUp(),
                                color: Colors.brown,
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0))
                          ],
                        ),
                      ),
                    ),
                  ),
                  //create a blurred effect when the menu is shown
                  AnimatedOpacity(
                    opacity: showBottomMenu ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(color: Colors.black.withOpacity(0.2)),
                    ),
                  ),

                  //place bottom drawer here
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Menu(),
                    left: 0.0,
                    bottom: showBottomMenu
                        ? 0
                        : -(MediaQuery.of(context).size.height / 3.5),
                  ),
                ],
              ),
            ),
          );
  }

  signUp() async {
    if (widget._formKey.currentState.validate()) {
      setState(() => widget.isLoading = true);
      final result = await _auth.signUpWithEmailAndPassword(
          widget._email, widget._password);
      if (result == null) {
        setState(() => error = 'Enter a valid email');
        widget.isLoading = false;
      }
    }
  }

  navigate() {
    widget.toggleView();
  }
}
