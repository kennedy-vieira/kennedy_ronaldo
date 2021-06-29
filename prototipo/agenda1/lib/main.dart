import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'interfaceDisciplina.dart';
import 'utilitarios.dart';
import 'atividade.dart';
import 'dataBase.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Página Inicial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var atividades = [];
  var atividadePrincipal;
  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {

    var auxAtividades = await dbController().getAtividades();
    var auxAtividadesOrdenadas = await ordenaAtividades(auxAtividades);
    setState(() {
      atividades = auxAtividadesOrdenadas;
      atividadePrincipal = auxAtividadesOrdenadas[0];
    });
  }

  Future<List<Atividade>> ordenaAtividades(List<Atividade> atividades) async{

    List<Atividade> atividadesOrdenadas = [];
    List<Atividade> atividadesDesordenadas = atividades;
    var day,month,year;
    for(var i = 0;i < atividadesDesordenadas.length;i++){
      if(atividadesDesordenadas[i].prioridade == 'Alta'){
        atividadesOrdenadas.add(atividadesDesordenadas[i]);
      }
    }

    return atividadesOrdenadas;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      endDrawer: gaveta(context),
      body: Center(

        child: Column(

          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(110),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(formatSelectedDate(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Proxima atividade a ser feita:   "),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 3),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getAtividadePrincipal(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> getAtividadePrincipal(){
    if(atividadePrincipal == null){
      return [];
    }else{
      return   [
        Text('Titulo : ' + atividadePrincipal.titulo.toString()),
        Text('Data de entrega : ' +
            atividadePrincipal.dataDeEntrega.toString()),
        Text(
            'Prioridade : ' + atividadePrincipal.prioridade.toString()),
        Text('Status : ' + atividadePrincipal.status.toString()),
        Text('Codigo da Disciplina : ' +
            atividadePrincipal.idDisciplina.toString()),
        Text('Valor da atividade : ' +
            atividadePrincipal.notaAtividade.toString()),
        Text('Nota obtida : ' +
            atividadePrincipal.notaAlcancada.toString()),
      ];
    }
  }


  String formatSelectedDate(){
      DateTime dataAtual = DateTime.now();
      var data ='${dataAtual.day}/${dataAtual.month}/${dataAtual.year}';
      return data;

  }
}
