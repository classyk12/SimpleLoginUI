import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleloginui/models/brew.dart';
import 'package:simpleloginui/shared/loading.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    List<Brew> brewList = [];
    brewList = Provider.of<List<Brew>>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: brewList?.length ??
            0, //use this to make the list nullable to avoid exceptions,
        itemBuilder: (context, index) {
          return brewList.length == 0
              ? Loading()
              : Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/coffee_icon.png'),
                        radius: 25.0,
                        backgroundColor:
                            Colors.brown[brewList[index].strenght]),
                    title: Text(brewList[index].name),
                    subtitle: Text('Takes ${brewList[index].sugars} sugar(s)'),
                  ),
                );
        },
      ),
    );
  }
}
