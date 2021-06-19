import 'package:calendario/evento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'reutilizaveis.dart';
import 'db.dart';

class NovaAtividade extends StatefulWidget {
  @override
  _NovaAtividadeState createState() => _NovaAtividadeState();
}

class _NovaAtividadeState extends State<NovaAtividade> {
  DateTime? _data;
  TextEditingController _titulo = TextEditingController();
  TextEditingController _disciplina = TextEditingController();
  TextEditingController _prioridade = TextEditingController();
  List<NovoEvento>? lista;

  Future<void> ashowDialog(BuildContext context) async {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('erro'),
              content: Text('Os campos data e disciplina são obrigatorios'),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ok')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nova Atividade'),
        ),
        endDrawer: gaveta(context),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Titulo',
                  ),
                  controller: _titulo,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child:
                  Text(_data == null ? 'selecione uma data' : _data.toString()),
              /*
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'data',
                  ),
                )*/
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextButton(
                  child: Text("selecione a data"),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: new DateTime(2050, 12, 31))
                        .then((temp) {
                      setState(() {
                        _data = temp;
                      });
                    });
                    //print(_data.toString());
                  },
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Disciplina',
                  ),
                  controller: _disciplina,
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prioridade',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _prioridade,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Center(
                child: TextButton(
                  child: Text('salvar'),
                  onPressed: () {
                    if (_data != null &&
                        _disciplina.text != '' &&
                        _prioridade.text != '') {
                      Db().insereEvento(new NovoEvento(
                          date: (_data)!,
                          disciplina: _disciplina.text,
                          prioridade: int.parse(_prioridade.text),
                          title: _titulo.text));
                      Navigator.pop(context);
                    }
                    //salva no db
                    else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                              'Todos os campos precisam ser preenchidos'),
                          content: const Text(
                              'Todos os campos precisam ser preenchidos'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }

                    //Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        )));
  }
}

class ListaAtividades extends StatefulWidget {
  @override
  _ListaAtividadesState createState() => _ListaAtividadesState();
}

class _ListaAtividadesState extends State<ListaAtividades> {
  List<NovoEvento> lista = [];

  void carregaLista() async {
    List<NovoEvento> temp = await Db().eventos();
    setState(() {
      lista = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    carregaLista();
    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades'),
      ),
      endDrawer: gaveta(context),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Data :' + lista[index].date.toString()),
                        Text('Titulo :' +
                            (lista[index].title == null
                                ? ''
                                : lista[index].title!)),
                        Text('Disciplina :' + lista[index].disciplina),
                        Text('Status : ' +
                            ((lista[index].date.year == DateTime.now().year &&
                                    lista[index].date.month ==
                                        DateTime.now().month &&
                                    lista[index].date.day == DateTime.now().day)
                                ? 'Pra hoje'
                                : (lista[index].date.isAfter(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day))
                                    ? 'Em dia'
                                    : 'Atrasado'))),
                      ],
                    ),
                    IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: () {
                          Db().deleteEvento(lista[index].id!);
                        },
                        icon: Icon(Icons.delete)),
                    IconButton(
                        alignment: Alignment.centerLeft,
                        onPressed: () {
                          //exclui o item do banco de dados
                          Db().deleteEvento(lista[index].id!);
                          //conclui a tarefa e dá os pontos ao usuario
                        },
                        icon: Icon(Icons.verified)),
                  ],
                ),
              ),
            );
          },
          itemCount: lista.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NovaAtividade()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
