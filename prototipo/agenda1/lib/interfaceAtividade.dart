import 'package:agenda/atividade.dart';
import 'package:agenda/dataBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utilitarios.dart';

class InterfaceAtividade extends StatefulWidget {
  @override
  _InterfaceAtividadeState createState() => _InterfaceAtividadeState();
}

class _InterfaceAtividadeState extends State<InterfaceAtividade> {
  var disciplinas = [];
  var atividades = [];
  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas();
    var auxAtividades = await dbController().getAtividades();
    setState(() {
      disciplinas = auxDisciplinas;
      atividades = auxAtividades;
    });
  }

  @override
  Widget build(BuildContext context) {
    carregaListas();
    if (atividades.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades"),
        ),
        endDrawer: gaveta(context),
        body: Center(
          child: Text('Não existem atividades cadastradadas ainda'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InterfaceNovaAtividade()));
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('atividades'),
      ),
      endDrawer: gaveta(context),
      body: Center(
        child: ListView.builder(
            itemCount: atividades.length,
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
                            Text('Titulo : ' + atividades[index].titulo.toString()),
                            Text('Data de entrega : ' +
                                atividades[index].dataDeEntrega.toString()),
                            Text(
                                'Prioridade : ' + atividades[index].prioridade.toString()),
                            Text('Status : ' + atividades[index].status.toString()),
                            Text('id disciplina : ' +
                                atividades[index].idDisciplina.toString()),
                            Text('Valor da atividade : ' +
                                atividades[index].notaAtividade.toString()),
                            Text('Nota obtida : ' +
                                atividades[index].notaAlcancada.toString()),
                          ]),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 0,
                                        child: TextButton(
                                          child: Text('Menu de opções'),
                                          onPressed: () {},
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: TextButton(
                                          onPressed: () {
                                            dbController().deleteAtividades(
                                                atividades[index]
                                                    .id);
                                          },
                                          child: Text("Excluir"),
                                        )),
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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InterfaceNovaAtividade()));
        },
      ),
    );
  }
}

class InterfaceNovaAtividade extends StatefulWidget {
  @override
  _InterfaceNovaAtividadeState createState() => _InterfaceNovaAtividadeState();
}

class _InterfaceNovaAtividadeState extends State<InterfaceNovaAtividade> {
  var titulo = TextEditingController();
  var dataDeEntrega = TextEditingController();
  var prioridade = TextEditingController();
  var status = TextEditingController();
  var idDisciplina = TextEditingController();
  var notaAlcancada = TextEditingController();
  var notaAtividade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova disciplina'),
      ),
      endDrawer: gaveta(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da atividade'),
                  controller: titulo,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data de entrega da atividade'),
                  controller: dataDeEntrega,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Prioridade da atividade'),
                  controller: prioridade,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Status da atividade'),
                  controller: status,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da Disciplina'),
                  controller: idDisciplina,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nota alcançada na Atividade'),
                  controller: notaAlcancada,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor da atividade'),
                  controller: notaAtividade,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            dbController().insereAtividade(Atividade(
                dataDeEntrega: dataDeEntrega.text,
                titulo: titulo.text,
                prioridade: prioridade.text,
                idDisciplina: idDisciplina.text,
                status: status.text,
                notaAlcancada: notaAlcancada.text,
                notaAtividade: notaAtividade.text));
            Navigator.pop(context);
          }),
    );
  }
}
