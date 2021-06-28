import 'atividade.dart';

class Disciplina{
  var codDisciplina;
  var nome;
  List<Atividade> atividades = [];
  //adicionar required no nome
  Disciplina({this.nome, this.codDisciplina});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'codDisciplina': codDisciplina,
    };
  }
}