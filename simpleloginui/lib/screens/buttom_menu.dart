import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      child: Container(
        color: Colors.brown[600],
        height: height / 3.5 + 60,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 0.0),
          child: Column(children: <Widget>[
            Icon(Icons.keyboard_arrow_up, size: 20.0, color: Colors.white),
            Text('Social Logins',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
            Text('Choose whichever you use frequently',
                style: TextStyle(color: Colors.white, fontSize: 10.0)),
            SizedBox(height: 20.0),
            SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Login with google',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 20.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )),
            // SizedBox(height: 20.0),
            SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.blue[300],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Login with Twitter',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 20.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Login with facebook',
                            style: TextStyle(color: Colors.white)),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'The Brew Crew App @2020',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
