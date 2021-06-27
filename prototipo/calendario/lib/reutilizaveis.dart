import 'package:calendario/atividades.dart';
import 'package:calendario/disciplinas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendario.dart';
import 'perfil.dart';

//Esse aquivo contem metodos com funções que retornam metodos de UI
//que serão utilizados em toda a aplicação

// drawer que contem as opções do aplicativo

Widget gaveta(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            '"Nome do app"',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Perfil'),
          onTap: () {
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  Perfil(title: "Perfil")));
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_today_outlined),
          title: Text('Calendario'),
          onTap: () {
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  Calendario(title: "Calendario")));
          },
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet_sharp),
          title: Text('Atividades'),
          onTap: () {
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  ListaAtividades()));
          },
        ),
        ListTile(
          leading: Icon(Icons.apartment_sharp),
          title: Text('Disciplinas'),
          onTap: () {
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  Disciplinas()));
          },
        ),
      ],
    ),
  );
}
