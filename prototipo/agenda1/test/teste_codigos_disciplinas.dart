import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda/interfacePerfil.dart';
import 'package:agenda/main.dart';
import 'package:agenda/dataBase.dart';
import 'package:agenda/disciplina.dart';
void main(){
  //Checa se todos as disciplinas possuem códigos
  bool ValidaCodigosDisciplinas(id) {
    List<Disciplina> disciplinas = [];

    void carregaLista() async {
      List<Disciplina> auxDisciplinas = await dbController().getDisciplinas(id);
      disciplinas = auxDisciplinas;
    }
    var codigosValidos = true;
    disciplinas.forEach((element) {
      if (element.codDisciplina == null) {
        codigosValidos = false;
      }
    });
    return codigosValidos;
  }

  //Teste para verificar a integridade do banco de dados
  test('Teste nivel atual', (){
    var result = ValidaCodigosDisciplinas(0);
    expect(result,true);
  });
}

