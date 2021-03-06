import 'package:agenda/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'usuario.dart';
import 'dataBase.dart';

class InterfaceBemVindo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem Vindo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InterfaceSelecionaUsuario()));
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterfaceSelecionaUsuario extends StatefulWidget {
  @override
  _InterfaceSelecionaUsuarioState createState() =>
      new _InterfaceSelecionaUsuarioState();
}

class _InterfaceSelecionaUsuarioState extends State<InterfaceSelecionaUsuario> {
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


  @override
  Widget build(BuildContext context) {
    if (listausuarios.length == 0) {
     return  Scaffold(
         appBar: AppBar(
         title: Text('Login'),
    ),
    body:AlertDialog(title: Text('Cadastre um usuario primeiro')),);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: listausuarios.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: TextButton(
                        child: Text(listausuarios[index].nome),
                        onPressed: () {
                          dbController().setIdUsuarioAtual(listausuarios[index].id);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                      title: 'P??gina Inicial',
                                      idUsuario: listausuarios[index].id)));
                        },
                      ),
                    ),
                  );
                })),
      );
    }
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
          title: Text('Novo Usuario'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
          ]),
        ));
  }
}
