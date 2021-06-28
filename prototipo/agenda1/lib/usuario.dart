import 'atividade.dart';
import 'disciplina.dart';
import 'conquista.dart';
import 'buffDebuff.dart';
class Usuario{
  var nome;
  List<Atividade> atividades = [];
  List<Disciplina> disciplinas = [];
  List<Conquista> conquistas = [];
  List<BuffDebuff> buffDebuff = [];
  var experiencia;
  var highscore;
  var id;

  Usuario({this.nome, this.experiencia,this.id});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'experiencia': experiencia,
      'id': id,
    };
  }

}
