import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'utilitarios.dart';
import 'dataBase.dart';

class Evento implements EventInterface {
  final DateTime date;
  final String? title;
  final String? disciplina;
  String status;
  String prioridade;
  Widget? icon;
  Widget? dot;
  final int? id;
  Evento(
      {required this.date,
      required this.title,
      this.icon,
      this.dot,
      this.id,
      required this.disciplina,
      required this.prioridade,
      required this.status}) {}

  DateTime getDate() {
    return date;
  }

  String getStatus() {
    return status;
  }

  String getPrioridade() {
    return prioridade;
  }

  String? getTitle() {
    return title;
  }

  String? getDisciplina() {
    return disciplina;
  }

  Widget? getIcon() {
    return icon;
  }

  Widget? getDot() {
    return dot;
  }

  int? getId() {
    return id;
  }
}

// classe Calendario e _CalendarioState são para a pagina calendario

class Calendario extends StatefulWidget {
  Calendario({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _CalendarioState createState() => new _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  bool exibir = false; // usar essa variavel para controle se deseja exibir
  // as atividades na parte inferior da pagina
  List<Evento> EventosDia = []; // usado para armazenar os eventos de um dia
  //especifico que sera mostrado na tela
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  //lista que contem os eventos a serem marcados no calendario
  EventList<Evento> _markedDateMap = new EventList<Evento>(
    events: {},
  );

  void _carregaEventos() async {
    EventList<Evento> temp = new EventList<Evento>(events: {});

    Widget dot = new Container(
      margin: EdgeInsets.symmetric(horizontal: 1.0),
      color: Colors.red,
      height: 5.0,
      width: 5.0,
    );

    Widget ico = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: Colors.blue, width: 2.0)),
      child: new Icon(
        Icons.person,
        color: Colors.amber,
      ),
    );

    var listaAtividades = await dbController().getAtividades();
    List<Evento> aa = [];
    for (int i = 0; i < listaAtividades.length; i++) {
      aa.add(Evento(
          title: listaAtividades[i].titulo,
          date: DateTime.parse(listaAtividades[i].dataDeEntrega),
          disciplina: listaAtividades[i].idDisciplina,
          status: listaAtividades[i].status,
          prioridade: listaAtividades[i].prioridade));
    }
    for (int i = 0; i < aa.length; i++) {
      aa[i].icon = ico;
      aa[i].dot = dot;
      temp.add(aa[i].date, aa[i]);
    }
    setState(() {
      _markedDateMap = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _carregaEventos();
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon

    /// Example Calendar Carousel without header and custom prev & next button

    final _calendarCarouselNoHeader = CalendarCarousel<Evento>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        events.forEach((event) {});
        this.setState(() {
          _currentDate2 = date;
          exibir = events.length > 0 ? true : false;
          EventosDia = events;
        });
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        endDrawer: gaveta(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon without header
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    TextButton(
                      child: Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    TextButton(
                      child: Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ),
              SizedBox(
                  height: 150.00,
                  child: ListView.builder(
                      itemCount: EventosDia.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Titulo : ' +
                                          EventosDia[index].getTitle()!),
                                      Text('prioridade :' +
                                          EventosDia[index].getPrioridade()),
                                    ],
                                  )
                                ])));
                      }))
            ],
          ),
        ));
  } //build

}
