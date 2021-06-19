import 'package:calendario/evento.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'reutilizaveis.dart';
import 'atividades.dart';
import 'db.dart';



class Calendario extends StatefulWidget {
  Calendario({Key? key, required this.title,}) : super(key: key);

  final String title;

  @override
  _CalendarioState createState() => new _CalendarioState();
}

class _CalendarioState extends State<Calendario>  {
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



  EventList<NovoEvento> _markedDateMap = new EventList<NovoEvento>(events: {}, );

  void _carregaEventos() async {
    EventList<NovoEvento> temp = new EventList<NovoEvento>(events: {});

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
    List<NovoEvento> aa = await Db().eventos();
    for(int i =0;i<aa.length; i++){
      aa[i].icon = ico;
      aa[i].dot = dot;
      temp.add(aa[i].date,aa[i]);
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
    final _calendarCarouselNoHeader = CalendarCarousel<NovoEvento>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
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
                                    _targetDateTime.year,
                                    _targetDateTime.month - 1);
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
                                    _targetDateTime.year,
                                    _targetDateTime.month + 1);
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
                    //
                  ],
                ),
              )
          );

  }//build


}