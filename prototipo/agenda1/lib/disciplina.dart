import 'atividade.dart';

class Disciplina{
  var codDisciplina;
  var nome;
  var id;
  var idUsuario;
  List<Atividade> atividades = [];
  Disciplina({required this.nome, this.codDisciplina, this.id,required this.idUsuario});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'codDisciplina': codDisciplina,
      'id' : id,
      'idUsuario' : idUsuario,
    };
  }
}