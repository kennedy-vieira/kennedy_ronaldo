import 'package:agenda/interfaceLogin.dart';
import 'package:agenda/usuario.dart';
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

  int idUsuario = -1;
  //se id usuario for -1 isso indica que é necessario pedir para o usuario criar uma conta
  //ou escolher um perfil existente


  void carregaUsuario() async{
    idUsuario =await dbController().getIdUsuarioAtual();
  }
  @override
  Widget build(BuildContext context) {
    carregaUsuario();

    //print(usuarios[0]);
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
  var usuarios;
  @override
  void initState() {
    super.initState();
    carregaListas();
    carregaUsuario();
  }

  void carregaUsuario() async{
    usuarios =await dbController().getIdUsuarioAtual();
    if(usuarios.length == 0){
      dbController().criaUsuario('Sistema');
    }

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
    List<Atividade> atividadesDesordenadas = atividades;
    atividadesDesordenadas.sort((Atividade a , Atividade b)=> a.getPrioridadeint().compareTo(b.getPrioridadeint()));
    return atividadesDesordenadas;
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
