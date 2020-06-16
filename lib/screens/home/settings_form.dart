import 'package:coffee/models/user.dart';
import 'package:coffee/services/database.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Text("Update your coffee settings", style: TextStyle(fontSize: 18.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.length < 3 ? 'Please enter the name' : null,
                  onChanged: (val){  setState(() => _currentName = val); },
                ),
                SizedBox(height: 10.0,),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('${sugar} sugars'),
                    );
                  }).toList(),
                  onChanged: (val){  setState(() => _currentSugars = val); },
                ),
                SizedBox(height: 10.0,),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val){  setState(() => _currentStrength = val.round()); },
                ),
                SizedBox(height: 10.0,),
                RaisedButton(
                  color: Colors.brown[400],
                  child: Text("Update", style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      DatabaseService(uid: user.uid).updateUserDate(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
//                    print(_currentName);
//                    print(_currentSugars);
//                    print(_currentStrength);
                  },
                )

              ],
            ),
          );
        }else{
          return Loading();
        }

      }
    );
  }
}
