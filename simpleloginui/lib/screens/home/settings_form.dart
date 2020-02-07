import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleloginui/models/user-model.dart';
import 'package:simpleloginui/services/database.dart';
import 'package:simpleloginui/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String _currentName;
  String _currentSugars;
  int _currentStrenght;
  final _formKey = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //use this to get user current object
    final user = Provider.of<User>(context);

    //use this to display loader
    if (isLoading) {
      return Loading();
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid)
            .userData, //name of the stream we are currently listening to
        builder: (context, snapshot) {
          //use this to check if data is ready
          return !snapshot.hasData
              ? Loading()
              : Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text('Update your Brew Settings',
                          style: TextStyle(fontSize: 18.0)),
                      Container(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: snapshot.data.name,
                        decoration: InputDecoration(hintText: 'enter a name'),
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      DropdownButtonFormField(
                        value: _currentSugars ?? snapshot.data.sugars,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _currentSugars = val),
                      ),
                      Container(height: 60.0),
                      Slider(
                        divisions: 8,
                        min: 100,
                        max: 900,
                        value: (_currentStrenght ?? snapshot.data.strenght)
                            .toDouble(),
                        activeColor: Colors
                            .brown[_currentStrenght ?? snapshot.data.strenght],
                        inactiveColor: Colors
                            .brown[_currentStrenght ?? snapshot.data.strenght],
                        onChanged: (val) =>
                            setState(() => _currentStrenght = val.round()),
                      ),
                      Container(height: 40.0),
                      RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => isLoading = true);
                              try {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                        _currentName ?? snapshot.data.name,
                                        _currentSugars ?? snapshot.data.sugars,
                                        _currentStrenght ??
                                            snapshot.data.strenght);
                                setState(() => isLoading = false);
                                Navigator.pop(context);
                              } catch (e) {
                                print(e.toString());
                              }
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          elevation: 5.0,
                          color: Colors.brown)
                    ],
                  ),
                );
        });
  }
}
