import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/screens/home/settings_form.dart';
import 'package:coffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffee/screens/home/coffee_list.dart';
import 'package:coffee/models/coffee.dart';

class Home extends StatelessWidget{

  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){

        return Container(
          color: Colors.brown[50],
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    
    return StreamProvider<List<Coffee>>.value(
      value: DatabaseService().coffee,
      child: new Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () => _showSettingsPanel(), icon: Icon(Icons.settings), label: Text('Settings')),
            FlatButton.icon(onPressed: () async{ await _auth.signOut();}, icon: Icon(Icons.person), label: Text('Logout')),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),

            ),
            child: new CoffeeList()),
      ),
    );
  }

}