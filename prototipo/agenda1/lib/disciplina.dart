import 'atividade.dart';

class Disciplina{
  var codDisciplina;
  var nome;
  var id;
  List<Atividade> atividades = [];
  Disciplina({required this.nome, this.codDisciplina, this.id});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'codDisciplina': codDisciplina,
      'id' : id,
    };
  }
}