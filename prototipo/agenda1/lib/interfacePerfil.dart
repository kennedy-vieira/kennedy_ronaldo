import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'utilitarios.dart';

class InterfacePerfil extends StatefulWidget {
  final int idUsuario;
  InterfacePerfil(this.idUsuario);
  @override
  _InterfacePerfilState createState() => _InterfacePerfilState(idUsuario);
}

class _InterfacePerfilState extends State<InterfacePerfil> {
  final int idUsuario;
  _InterfacePerfilState(this.idUsuario);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text('Olá')
            ),
            Container(

            ),
            Container(

            ),

          ],
        ),
      ),
    );
  }

}