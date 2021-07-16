import 'atividade.dart';
import 'disciplina.dart';
import 'conquista.dart';
import 'buffDebuff.dart';
class Usuario{
  var nome;
  var experiencia;
  var id;

  // eu acho que essas listas são desnecessarias, já que temos que ler do db sempre
  // 16\7\21
  /*
  List<Atividade> atividades = [];
  List<Disciplina> disciplinas = [];
  List<Conquista> conquistas = [];
  List<BuffDebuff> buffDebuff = [];
  var highscore;
  */
  Usuario({this.nome, this.experiencia,this.id});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'experiencia': experiencia,
      'id': id,
    };
  }

}
