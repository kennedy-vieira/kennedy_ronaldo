import 'package:agenda/interfaceAtividade.dart';

import 'interfaceDisciplina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'interfaceCalendario.dart';
import 'interfacePerfil.dart';

//Esse aquivo contem metodos com funções que retornam metodos de UI
//que serão utilizados em toda a aplicação

// drawer que contem as opções do aplicativo

Widget gaveta(BuildContext context,int idUsuario) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),

        ListTile(
          leading: Icon(Icons.calendar_today_outlined),
          title: Text('Calendario'),
           onTap: () {
             Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>  Calendario(title: "Calendario",idUsuario: idUsuario,)));
           },
        ),
        ExpansionTile(title: Text('Atividades'),
          leading: Icon(Icons.account_balance_wallet_sharp),
          children: [
          TextButton(onPressed: (){
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  InterfaceAtividade(idUsuario)));
          }, child: Text('Todas')),

          TextButton(onPressed: (){
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  InterfaceAtividadeStatus('Concluido',idUsuario)));
          }, child: Text('Concluidas')),

          TextButton(onPressed: (){
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  InterfaceAtividadeStatus('A fazer',idUsuario)));
          }, child: Text('A fazer')),
        ],),
        ListTile(
          leading: Icon(Icons.apartment_sharp),
          title: Text('Disciplinas'),
          onTap: () {
            Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  InterfaceDisciplina(idUsuario)));
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Perfil'),
           onTap: () {
             Navigator.pop(context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>  InterfacePerfil(idUsuario)));
           },
        ),
      ],
    ),
  );
}
