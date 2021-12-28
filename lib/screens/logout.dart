import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';


class LogoutDialog extends StatefulWidget {
  LogoutDialog({Key key,}) : super(key: key);
  @override
  _LogoutDialogState createState() =>
      _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 170,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              SizedBox(width: 18.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Logout",
                            style: TextStyle(
                                color: Colors.pink[900], fontSize: 15)),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.help,
                            color: Colors.pink,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text("Are you sure you want to logout?"),
                    ),
                    SizedBox(height: 10.0),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Icon(Icons.close),
                            color: Colors.red,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            child: Icon(Icons.done),
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              logout(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  logout(BuildContext co) async {
    final prefs = await StreamingSharedPreferences.instance;
    prefs.clear();
    Navigator.pop(co);
    Navigator.of(context).pushNamed('/');

  }
} 
