import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleloginui/models/brew.dart';
import 'package:simpleloginui/screens/home/brew-list.dart';
import 'package:simpleloginui/screens/home/settings_form.dart';
import 'package:simpleloginui/services/auth.dart';
import 'package:simpleloginui/services/database.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //use this to open bottom sheet
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
                child: SettingsForm());
          });
    }

    AuthService _auth = AuthService();
    //this helps to listen to changes and update accordingly
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Brew Crew'),
          titleSpacing: 5.0,
          actions: <Widget>[
            FlatButton.icon(
              label: Text('Logout', style: TextStyle(color: Colors.brown[100])),
              icon: Icon(
                Icons.person,
                color: Colors.brown[100],
              ),
              onPressed: () {
                _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.brown[100]),
              label:
                  Text('Settings', style: TextStyle(color: Colors.brown[100])),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/coffee_bg.png'),
                  fit: BoxFit.cover),
            ),
            child: BrewList()),
      ),
    );
  }
}
