import 'package:coffee/services/auth.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffee/shared/constants.dart';
class Register extends StatefulWidget{

  final Function toggleView;
  Register({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return new _RegisterState();
  }
}


class _RegisterState extends State<Register>{

  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register To Coffee'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Sign In'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 3 ? 'Enter a password 3+ char' : null,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.brown[400],
                  child: Text('Register', style: TextStyle(color: Colors.white),),
                  onPressed: () async{
                    setState(() => loading = true);
                    if(_formKey.currentState.validate()){
                      dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                      if(result == null){
                        setState(() {
                          error = "Please supply a valid email";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0,),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
              ],
          )
        )
      ),
    );
  }

}
