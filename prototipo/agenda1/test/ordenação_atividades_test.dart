import 'package:agenda/atividade.dart';
import 'package:agenda/main.dart';
import 'package:agenda/dataBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() async{

  void carregaLista() async{
    var ativ =  await dbController().getAtividades(1);
  }

  var a = MyHomePage(title: "titulo", idUsuario: 1);
  a.createState();
  var b = a.createState();
  List<Atividade> auxAtividades = [];


  var c = await b.ordenaAtividades(auxAtividades);

  var atividadesOrdenadas = true;

  for(int i =0; i < c.length-1;i++)
    {
      DateTime aa =c[i].dataDeEntrega;
      DateTime bb = c[i+1].dataDeEntrega;
      if(!aa.isBefore(bb))
        {
          atividadesOrdenadas = false;
        }
    }
  test('Ordenação atividades', (){
    expect(atividadesOrdenadas,true);
  });
}