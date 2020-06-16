import 'package:coffee/screens/home/home.dart';
import 'package:coffee/screens/wrapper.dart';
import 'package:coffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffee/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.brown[500],
          accentColor: Colors.brown[500],
        ),
        home: Home(),
//        home: Wrapper(),
      ),
    );
  }
}
