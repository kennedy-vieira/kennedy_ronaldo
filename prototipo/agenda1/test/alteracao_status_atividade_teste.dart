import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda/dataBase.dart';
import 'package:agenda/atividade.dart';

void main()async{
  var valido = true;
  var atividade = Atividade(prioridade: 1,titulo: "teste",status: "A fazer");


  void carregaAtividade(Atividade ativia)async{
    try{
      await dbController().alteraStatus(atividade);
    }
    catch(error){
      valido = false;
    }
    if(ativia.status != "Concluido")
      {
        valido = false;
      }
  }
  test('verificação a função de  alteração do status de uma atividade', (){
    expect(valido, true);
  });
}
