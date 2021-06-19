import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

//a classe NovoEvento substitui a classe Event do pacote calendar_carrousel e inlcui atributos especificos da nossa aplicação
// como uma disciplina a qual evento é relacionado e um valor de prioridade

class NovoEvento implements EventInterface {
  final DateTime date;
  final String? title;
  Widget? icon;
  Widget? dot;
  final int? id;
  final String disciplina;
  final int? prioridade;


  NovoEvento({
    this.id,
    required this.date,
    this.title,
    this.icon,
    this.dot,
    required this.disciplina,
    this.prioridade,

  });

  @override
  bool operator ==(dynamic other) {
    return this.date == other.date &&
        this.title == other.title &&
        this.icon == other.icon &&
        this.dot == other.dot &&
        this.id == other.id &&
        this.prioridade == other.prioridade &&
        this.disciplina == other.disciplina ;
  }

  @override
  String toString() {
    return 'Evento {date : $date, title : $title,icon : $icon, dot: $dot, id:$id,'
        ' prioridade: $prioridade,disciplina: $disciplina}';
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'icon': icon,
      'dot': dot,
      'id': id,
      'disciplina': disciplina,
      'prioridade': prioridade,

    };
  }

  @override
  int get hashCode => hashValues(date, title, icon, id);

  @override
  DateTime getDate() {
    return date;
  }

  @override
  int? getId() {
    return id;
  }

  @override
  Widget? getDot() {
    return dot;
  }

  @override
  Widget? getIcon() {
    return icon;
  }

  @override
  String? getTitle() {
    return title;
  }

  @override
  String getTDisciplina() {
    return disciplina;
  }

  @override
  int? getPrioridade() {
    return prioridade;
  }


}
