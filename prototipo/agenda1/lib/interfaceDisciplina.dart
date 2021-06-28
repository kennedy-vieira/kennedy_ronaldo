import 'disciplina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dataBase.dart';
import 'utilitarios.dart';

class InterfaceDisciplina extends StatefulWidget {
  @override
  _InterfaceDisciplinaState createState() => _InterfaceDisciplinaState();
}

class _InterfaceDisciplinaState extends State<InterfaceDisciplina>{
  List<Disciplina> disciplinas =[];
  @override
  void initState(){
    super.initState();
  }
  void carregaLista() async{
    List<Disciplina> auxDisciplinas = await dbController().getDisciplinas();
    setState(() {
      disciplinas = auxDisciplinas;
    });
  }
  @override
  Widget build(BuildContext context){
    carregaLista();
    if(!disciplinas.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text('Disciplinas'),
        ),
        endDrawer: gaveta(context),
        body: Center(
          child: ListView.builder(itemCount: disciplinas.length, itemBuilder: (context, index){return Padding(padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Row(
                children: [
                  Column(
                    children:[Text(disciplinas[index].nome),
                      Text(disciplinas[index].codDisciplina.toString()),]),
                  Column(
                    children: [
                      IconButton(
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            print(disciplinas[index].codDisciplina);
                            dbController().deleteDisciplinas(disciplinas[index].codDisciplina!);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),

                ]
              ),
            ));}),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text('Disciplinas'),
        ),
        body: Center(
          child: Text('Não há disciplinas cadastradas!'),
        ),
      );
    }
  }
}

class NovaDisciplina extends StatefulWidget {
  @override
  _NovaDisciplinaState createState() => _NovaDisciplinaState();
}

class _NovaDisciplinaState extends State<NovaDisciplina>{
  var nomeDisciplina = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Disciplina'),
      ),
      body: Column(
        children:<Widget>[ Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome da Disciplina'
            ),
            controller: nomeDisciplina,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          dbController().insereDisciplina(
              Disciplina(nome: nomeDisciplina.text));
          Navigator.pop(context);
        }
      ),
    );
  }

}