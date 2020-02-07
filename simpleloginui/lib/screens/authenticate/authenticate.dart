import 'package:flutter/material.dart';
import 'package:simpleloginui/screens/authenticate/register.dart';
import 'package:simpleloginui/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  //use this to toggle view
  void toggleView() {
    setState(() =>
        showSignIn = !showSignIn); //this allows us to toggle between states
  }

  @override
  Widget build(BuildContext context) {
    if (!showSignIn) {
      return Register(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }
}
