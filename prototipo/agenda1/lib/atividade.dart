class Atividade {
  var id;
  var titulo;
  var dataDeEntrega;
  var prioridade;
  var status;
  var idDisciplina;
  var notaAlcancada;
  var notaAtividade;
  var idUsuario;
  var descricao;

  Atividade({
    this.dataDeEntrega,
    this.titulo,
    this.idUsuario,
    required this.prioridade,
    this.idDisciplina,
    this.id,
    this.status,
    this.notaAtividade,
    this.notaAlcancada,
    this.descricao,
  });

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
      'descricao': descricao,
    };
  }

  int getPrioridadeint() {
    if (this.prioridade.toString() == 'Alta') {
      return 1;
    }
    if (this.prioridade.toString() == 'Media') {
      return 2;
    } else {
      return 3;
    }
  }
}
