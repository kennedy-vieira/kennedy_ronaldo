import 'package:agenda/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'usuario.dart';
import 'dataBase.dart';

class InterfaceBemVindo extends StatefulWidget {
  @override
  _InterfaceBemVindoState createState() => new _InterfaceBemVindoState();
}

class _InterfaceBemVindoState extends State<InterfaceBemVindo> {
  List<Usuario> listausuarios = [];
  // lista que armazena os usuarios a serem exibidos

  void carregausuarios() async {
    var usu = await dbController().getUsuarios();
    setState(() {
      listausuarios = usu;
    });
  }

  void initState() {
    carregausuarios();
  }

  Future<dynamic> _showOptions(BuildContext context) async {
    return showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione o usuario'),
            content:
                Text('tela de login deve aparecer a lista de usuarios aqui'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  title: "Pagina inicial",
                                  idUsuario: 1,
                                )));
                  },
                  child: Text('ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    _showOptions(context);
                  },
                  child: Text('Login')),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InterfaceCadastroUsuario()));
                  },
                  child: Text('Novo usuario')),
            ],
          ),
        ),
      ),
    );
  }
}

class InterfaceCadastroUsuario extends StatefulWidget {
  @override
  _InterfaceCadastroUsuarioState createState() =>
      new _InterfaceCadastroUsuarioState();
}

class _InterfaceCadastroUsuarioState extends State<InterfaceCadastroUsuario> {
  var nomeUsuario = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nova Disciplina'),
        ),
        body: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nome do usuario'),
                controller: nomeUsuario,
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: TextButton(
                onPressed: () {
                  if (nomeUsuario.text.isNotEmpty) {
                    dbController().criaUsuario(nomeUsuario.text);
                  }
                  Navigator.pop(context);
                },
                child: Text('salvar'),
              )),
        ]));
  }
}
