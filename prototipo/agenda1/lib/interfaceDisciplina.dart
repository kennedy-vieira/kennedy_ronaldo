import 'disciplina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dataBase.dart';
import 'utilitarios.dart';
import 'package:agenda/interfaceAtividade.dart';

class InterfaceDisciplina extends StatefulWidget {
  final int idUsuario;
  InterfaceDisciplina(this.idUsuario);
  @override
  _InterfaceDisciplinaState createState() => _InterfaceDisciplinaState(idUsuario);
}

class _InterfaceDisciplinaState extends State<InterfaceDisciplina> {
  final int idUsuario;
  _InterfaceDisciplinaState(this.idUsuario);
  List<Disciplina> disciplinas = [];
  @override
  void initState() {
    super.initState();
    carregaLista();
  }

  void carregaLista() async {
    List<Disciplina> auxDisciplinas = await dbController().getDisciplinas(idUsuario);
    setState(() {
      disciplinas = auxDisciplinas;
    });
  }

  @override
  Widget build(BuildContext context) {
    carregaLista();
    if (!disciplinas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Disciplinas'),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(

          child: ListView.builder(
              itemCount: disciplinas.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(children: [
                              Text('Disciplina : ' + disciplinas[index].nome.toString()),
                              Text('Codigo : ' +
                                  disciplinas[index].codDisciplina.toString()),
                            ]),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: PopupMenuButton<int>(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: 0,
                                        child: Text('Menu de opções'),
                                      ),
                                      PopupMenuItem(
                                          value: 1,
                                          child: TextButton(
                                            onPressed: () {
                                              dbController().deleteDisciplinas(
                                                  disciplinas[index]
                                                      .id!);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Excluir"),
                                          )),
                                      PopupMenuItem(
                                        value:2,
                                        child: TextButton(onPressed: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => InterfaceAtividadeDisciplina(idUsuario,disciplinas[index].codDisciplina,disciplinas[index].nome.toString())));
                                        },
                                        child : Text('Ver atividades'),)
                                      ),
                                    ],
                                    icon: Icon(Icons.settings),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ));
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NovaDisciplina(idUsuario)));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Disciplinas'),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(
          child: Text('Não há disciplinas cadastradas!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NovaDisciplina(idUsuario)));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
    }
  }
}

class NovaDisciplina extends StatefulWidget {
  final int idUsuario;
  NovaDisciplina(this.idUsuario);
  @override
  _NovaDisciplinaState createState() => _NovaDisciplinaState(idUsuario);
}

class _NovaDisciplinaState extends State<NovaDisciplina> {
  final int idUsuario;
  _NovaDisciplinaState(this.idUsuario);
  var nomeDisciplina = TextEditingController();
  var codigoDisciplina = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Disciplina'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: TextField(
            key : Key('nome'),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Nome da Disciplina'),
            controller: nomeDisciplina,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: TextField(
            key : Key('cod'),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Codigo da disciplina'),
            controller: codigoDisciplina,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            dbController().insereDisciplina(Disciplina(
                nome: nomeDisciplina.text,
                codDisciplina: codigoDisciplina.text,
                idUsuario: idUsuario));
            Navigator.pop(context);
          }),
    );
  }
}
