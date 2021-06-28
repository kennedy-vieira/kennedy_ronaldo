import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'reutilizaveis.dart';
import 'db.dart';
import 'evento.dart';

// Disciplinas e _Disciplinas State são para a pagina que exibe a lista de
//disciplinas

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
    carregaLista(); //não tenho certeza se precisa chamar esse metodo aqui

    //se não existir nenhuma atividade a lista vai ser vazia
    //caso for vazia
    if(lista.isEmpty){
      return Scaffold(
        appBar: AppBar(
          title: Text('Disciplinas'),
        ),
        endDrawer: gaveta(context),
        body: Center(
          child: Text('Tente inserir uma atividade primeiro'),
        )
      );
    }
    // caso lista não for vazia
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
