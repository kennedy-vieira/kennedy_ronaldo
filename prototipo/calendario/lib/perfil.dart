import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'reutilizaveis.dart';

class Perfil extends StatefulWidget{
  Perfil({Key? key, required this.title,}) : super(key: key);

  final String title;

  @override
  _PerfilState createState() => new _PerfilState();
}
class _PerfilState extends State<Perfil>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      endDrawer: gaveta(context),
    );
  }
}