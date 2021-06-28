
class Atividade{
  var id;
  var titulo;
  var dataDeEntrega;
  var prioridade;
  var status;
  var idDisciplina;
  var notaAlcancada;
  var notaAtividade;
  var idUsuario;

  Atividade({this.dataDeEntrega, this.titulo,this.idUsuario,this.prioridade,this.idDisciplina,this.id,this.status,this.notaAtividade,this.notaAlcancada});

  Map<String, dynamic> toMap() {
    return {
      'dataDeEntrega': dataDeEntrega,
      'titulo': titulo,
      'idUsuario': idUsuario,
      'idDisciplina': idDisciplina,
      'prioridade': prioridade,
      'id': id,
      'status': status,
      'notaAlcancada': notaAlcancada,
      'notaAtividade': notaAtividade,
    };
  }

}