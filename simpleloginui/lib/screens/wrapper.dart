import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleloginui/models/user-model.dart';
import 'package:simpleloginui/screens/authenticate/authenticate.dart';
import 'package:simpleloginui/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Home();
    } else {
      return Authenticate();
    }
    //use this to return widget dynamically based on auth status
  }
}
