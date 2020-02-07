import 'package:flutter/material.dart';
import 'package:simpleloginui/services/auth.dart';
import 'package:simpleloginui/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  String _email, _password;
  String error = '';
  bool isLoading = false;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('Sign in to Brew Crew'),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => navigate(),
                  icon: Icon(Icons.person, color: Colors.brown[600]),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.brown[600]),
                  ),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
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
                        onPressed: () => signIn(),
                        color: Colors.brown,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(widget.error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0))
                  ],
                ),
              ),
            ));
  }

  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() => widget.isLoading = true);
      final result = await _auth.signInWithEmailAndPassword(
          widget._email, widget._password);
      if (result == null) {
        setState(
            () => widget.error = 'could not sign in with those credentials');
        widget.isLoading = false;
      }
    }
  }

  navigate() {
    widget.toggleView();
  }
}
