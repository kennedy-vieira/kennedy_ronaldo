import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'reutilizaveis.dart';
import 'db.dart';
import 'evento.dart';

class Disciplinas extends StatefulWidget {
  @override
  _DisciplinasState createState() => _DisciplinasState();
}

class _DisciplinasState extends State<Disciplinas> {
  List<String> lista = [];

 @override
 void initState(){
   super.initState();
   carregaLista();
 }


  void carregaLista() async{
    List<String> temp = await Db().disciplinas();
    setState(() {
      lista = temp;

    });
  }

  @override
  Widget build(BuildContext context) {
    //carregaLista();
    return Scaffold(
      appBar: AppBar(
        title: Text('Disciplinas'),
      ),
      endDrawer: gaveta(context),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Center(
                  child: Text(lista[index]),
                ),
              ),
            );

          },
          itemCount: lista.length,
        ),
      ),
    );
  }
}
