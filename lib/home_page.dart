import 'package:flutter/material.dart';
import 'package:my_app/auth.dart';

class HomePage extends StatelessWidget {

  HomePage({this.auth, this.userDeslogar});

  final BaseAuth auth;
  final VoidCallback userDeslogar;


  void _deslogar() async {
    try{
      await auth.signOut();
      userDeslogar();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Página Principal'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Deslogar', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: _deslogar,
          )
        ],
      ),
      body: new Container(
        child: new Center(
          child: new Text('Bem-vindo!', style: new TextStyle(fontSize: 32.0))
        ),
      )
    );
  }
}