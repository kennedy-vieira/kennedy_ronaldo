import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'usuario.dart';
import 'dataBase.dart';


class InterfaceBemVindo extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
          children: [
            TextButton(onPressed: (){}, child: Text('Login')),
            TextButton(onPressed: (){}, child: Text('Novo usuario')),
          ],
        ),),
      ),
    );
  }
}

class InterfaceLogin extends StatefulWidget{
  @override
  _InterfaceLoginState createState()  => new _InterfaceLoginState();

}
class _InterfaceLoginState extends State<InterfaceLogin>
{
  @override
  Widget build(BuildContext context){
    return Scaffold();
  }
}