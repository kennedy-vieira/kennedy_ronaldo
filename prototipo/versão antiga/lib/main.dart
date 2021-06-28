import 'package:calendario/evento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;


import 'calendario.dart';
import 'reutilizaveis.dart';
import 'db.dart';

void main() async{
  /*
  NovoEvento evnt = new NovoEvento(date: new DateTime(2021,6,7),disciplina: 'geografia');
  Db().insereEvento(evnt);
  List<NovoEvento> lista = await Db().eventos();*/
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '"Nome do app"',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Homepage(title: '"nome do app"'),
    );
  }
}

class Homepage extends StatefulWidget {
  Homepage({Key? key, required this.title}) : super(key: key);
  final String title;


  _HomepageState createState() => new _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
      ),
      endDrawer: gaveta(context),
      body: Center(
        child: Text('Homepage'),
      ),
    );
  }
}


