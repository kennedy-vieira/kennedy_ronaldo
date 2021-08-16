class Usuario{
  var nome;
  var experiencia;
  var id;

  Usuario({required this.nome, this.experiencia,this.id});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'experiencia': experiencia,
      'id': id,
    };
  }

}
