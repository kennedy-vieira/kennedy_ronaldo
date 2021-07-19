import 'package:agenda/interfaceLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'interfaceDisciplina.dart';
import 'utilitarios.dart';
import 'atividade.dart';
import 'dataBase.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  _carregaUsuario()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   var r = await prefs.getInt('idUser');
   if(r == null)
     idUsuario = -1;
   else idUsuario = r;
  }
  int idUsuario = 0 ;

  //se id usuario for -1 isso indica que é necessario pedir para o usuario criar uma conta
  //ou escolher um perfil existente

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //_carregaUsuario();
    if(idUsuario == -1)//idUsuario == -1
      return MaterialApp(
        title: 'Agenda',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home : InterfaceBemVindo()
      );
    else{
    return MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Página Inicial',idUsuario: idUsuario,),
    );
  }
}
}

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key, required this.title, required this.idUsuario}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final int idUsuario;

  @override
  _MyHomePageState createState() => _MyHomePageState(idUsuario);
}

class _MyHomePageState extends State<MyHomePage> {
  final int idUsuario;
  _MyHomePageState(this.idUsuario);

  var atividades = [];
  var atividadePrincipal;
  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {

    var auxAtividades = await dbController().getAtividades(idUsuario);
    var auxAtividadesOrdenadas = await ordenaAtividades(auxAtividades);
    setState(() {
      atividades = auxAtividadesOrdenadas;
      atividadePrincipal = auxAtividadesOrdenadas[0];
    });
  }

  Future<List<Atividade>> ordenaAtividades(List<Atividade> atividades) async{

    List<Atividade> atividadesOrdenadas = [];
    List<Atividade> atividadesDesordenadas = atividades;
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
      endDrawer: gaveta(context,idUsuario),
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
