import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleloginui/screens/wrapper.dart';
import 'package:simpleloginui/services/auth.dart';

import 'models/user-model.dart';

void main() => runApp(new MyApp());

//define navigation contants here
const homeRoute = '/';
const mainRoute = '/mainPage';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //use this to get the stream to be used for widget display
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.green),
          home: Wrapper()),
    );
  }
}
