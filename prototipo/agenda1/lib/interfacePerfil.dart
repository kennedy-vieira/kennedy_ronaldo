import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utilitarios.dart';

class InterfacePerfil extends StatefulWidget {
  @override
  _InterfacePerfilState createState() => _InterfacePerfilState();
}

class _InterfacePerfilState extends State<InterfacePerfil> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      endDrawer: gaveta(context),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

}