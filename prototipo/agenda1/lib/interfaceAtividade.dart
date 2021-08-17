//import 'dart:html';

import 'atividade.dart';
import 'dataBase.dart';
import 'interfaceDisciplina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'disciplina.dart';
import 'utilitarios.dart';

class InterfaceAtividade extends StatefulWidget {
  final int idUsuario;


  InterfaceAtividade(this.idUsuario);
  @override
  _InterfaceAtividadeState createState() => _InterfaceAtividadeState(idUsuario);
}

class _InterfaceAtividadeState extends State<InterfaceAtividade> {
  final int idUsuario;
  var disciplinas = [];
  var atividades = [];
  var xpConcluirAtividade = 50;
  _InterfaceAtividadeState(this.idUsuario);
  @override
  void initState() {
    super.initState();
    carregaListas();
    carregaUsuario();
  }

  var usuario;
  void carregaUsuario() async{
    var usuarios = await dbController().getUsuarios();
    usuario = usuarios[0];
  }
  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas(idUsuario);
    var auxAtividades = await dbController().getAtividades(idUsuario);
    var auxAtividadesOrdenadas = ordenaAtividades(auxAtividades);
    setState(() {
      disciplinas = auxDisciplinas;
      atividades = auxAtividadesOrdenadas;

    });
  }

  List<Atividade> ordenaAtividades(List<Atividade> atividades) {
    List<Atividade> atividadesDesordenadas = atividades;
    atividadesDesordenadas.sort((Atividade a , Atividade b)=> a.getPrioridadeint().compareTo(b.getPrioridadeint()));
    return atividadesDesordenadas;
  }

  String formatSelectedDate(String data) {
      DateTime data1 = DateTime.parse(data);
      var dat = '${data1.day}/${data1.month}/${data1.year}';
      return dat;

  }
  @override
  Widget build(BuildContext context) {
    carregaListas();
    if (disciplinas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades"),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(
          child: Text('Nescessário cadastrar ao menos uma disciplina'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NovaDisciplina(idUsuario)));
          },
        ),
      );
    }
    if (atividades.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades"),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(
          child: Text('Não existem atividades cadastradadas ainda'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InterfaceNovaAtividade(idUsuario)));
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: Center(
        child: ListView.builder(
            itemCount: atividades.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Titulo : ' +
                                    atividades[index].titulo.toString()),
                                Text('Data de entrega : ' + formatSelectedDate(atividades[index].dataDeEntrega)),
                                Text('Prioridade : ' +
                                    atividades[index].prioridade.toString()),
                                Text('Status : ' +
                                    atividades[index].status.toString()),
                                Text('Codigo da Disciplina : ' +
                                    atividades[index].idDisciplina.toString()),
                                Text('Valor da atividade : ' +
                                    atividades[index].notaAtividade.toString()),
                                Text('Nota obtida : ' +
                                    atividades[index].notaAlcancada.toString()),
                              ]),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 0,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          child: Text('Menu de opções'),
                                          onPressed: () {},
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: TextButton(
                                          onPressed: () {
                                            dbController().deleteAtividades(
                                                atividades[index].id);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Excluir"),
                                        )),
                                    PopupMenuItem(
                                        value: 2,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InterfaceEditaAtividade(
                                                            atividade:
                                                            atividades[
                                                            index],idUsuario: idUsuario,)));
                                          },
                                          child: Text("Editar"),
                                        )),
                                  ],
                                  icon: Icon(Icons.settings),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InterfaceNovaAtividade(idUsuario)));
        },
      ),
    );
  }
}

class InterfaceNovaAtividade extends StatefulWidget {
  final int idUsuario;
  InterfaceNovaAtividade(this.idUsuario);
  @override
  _InterfaceNovaAtividadeState createState() => _InterfaceNovaAtividadeState(idUsuario);
}

class _InterfaceNovaAtividadeState extends State<InterfaceNovaAtividade> {
  var titulo = TextEditingController();
  var dataDeEntrega;
  var prioridade = TextEditingController();
  //var status = TextEditingController();
  var idDisciplina = TextEditingController();
  //var notaAlcancada = TextEditingController();
  var notaAtividade = TextEditingController();
  var descricao = TextEditingController();
  List<String> disciplinas = [];
  List<Disciplina> listaDisciplinas = [];
  var dropdownValue;
  var prioridadesDropdownValue = "Media";
  var dateEntrega;
  final int idUsuario;
  _InterfaceNovaAtividadeState(this.idUsuario);

  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas(idUsuario);
    List<String> strDisciplinas = [];
    for (var i = 0; i < auxDisciplinas.length; i++) {
      strDisciplinas.add(
          auxDisciplinas[i].nome + " - " + auxDisciplinas[i].codDisciplina);
    }
    setState(() {
      disciplinas = strDisciplinas;
      listaDisciplinas = auxDisciplinas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Atividade'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da atividade'),
                  controller: titulo,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text("Data de entrega da atividade:  "),
                    ElevatedButton(
                      child: FittedBox(
                        child: Text(formatSelectedDate()),
                      ),
                      onPressed: () => pickDate(context),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor da atividade'),
                  controller: notaAtividade,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text("Selecione a prioridade:  "),
                    DropdownButton<String>(
                      value: prioridadesDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          prioridadesDropdownValue = newValue!;
                        });
                      },
                      items: <String>['Alta', 'Media', 'Baixa']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text("Selecione a disciplina:  "),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: disciplinas
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descrição:'),
                  controller: descricao,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            if(dateEntrega != null){
            dbController().insereAtividade(Atividade(
                dataDeEntrega: dateEntrega.toString(),
                idUsuario: idUsuario,
                titulo: titulo.text,
                prioridade: prioridadesDropdownValue,
                idDisciplina:
                getCodDisciplinas(dropdownValue, listaDisciplinas),
                status: "A fazer",
                notaAlcancada: "",
                notaAtividade: notaAtividade.text,
                descricao: descricao.text));
            Navigator.pop(context);
          }
            else{
              Navigator.of(context).restorablePush(_dialogBuilder);
            }
          }),
    );
  }
  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => const AlertDialog(title: Text('Data não pode ser vazia')),
    );
  }
  String formatSelectedDate() {
    if (dateEntrega == null) {
      return 'Selecione a data';
    } else {
      var data = '${dateEntrega.day}/${dateEntrega.month}/${dateEntrega.year}';
      dataDeEntrega = data.toString();
      return data;
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;

    setState(() {
      dateEntrega = newDate;
    });

  }

  String getCodDisciplinas(String str, List<Disciplina> listaDeDisciplinas) {
    String codDisciplina = '';
    for (var i = 0; i < listaDeDisciplinas.length; i++) {
      if (str.contains(listaDisciplinas[i].codDisciplina)) {
        codDisciplina = listaDisciplinas[i].codDisciplina;
      }
    }
    return codDisciplina;
  }
}



class InterfaceLancarNota extends StatefulWidget {
  final Atividade atividade;
  final int idUsuario;
  InterfaceLancarNota({required this.atividade,required this.idUsuario}) ;

  @override
  _InterfaceLancarNotaState createState() =>
      _InterfaceLancarNotaState(atividade,idUsuario);
}

class _InterfaceLancarNotaState extends State<InterfaceLancarNota> {

  var notaAtividade = TextEditingController();
  var notaAlcancada;
  final int idUsuario;

  _InterfaceLancarNotaState(Atividade atividade,this.idUsuario){
    notaAtividade.text = atividade.notaAtividade.toString();
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

}
class InterfaceEditaAtividade extends StatefulWidget {
  final Atividade atividade;
  final int idUsuario;
  InterfaceEditaAtividade({required this.atividade,required this.idUsuario}) ;

  @override
  _InterfaceEditaAtividadeState createState() =>
      _InterfaceEditaAtividadeState(atividade,idUsuario);
}
class _InterfaceEditaAtividadeState extends State<InterfaceEditaAtividade> {
  var titulo = TextEditingController();
  var descricao = TextEditingController();
  var dataDeEntrega;
  var prioridade = TextEditingController();
  var notaAtividade = TextEditingController();
  var notaObtida = TextEditingController();
  List<String> disciplinas = [];
  List<Disciplina> listaDisciplinas = [];
  var dropdownValue;
  var prioridadesDropdownValue = "Media";
  var dateEntrega;
  final int idUsuario;

  _InterfaceEditaAtividadeState(Atividade atividade,this.idUsuario) {

    titulo.text = atividade.titulo;
    prioridade.text = atividade.prioridade;
    prioridadesDropdownValue = atividade.prioridade;
    notaAtividade.text = atividade.notaAtividade.toString();
    dateEntrega = DateTime.parse(atividade.dataDeEntrega);
    descricao.text = atividade.descricao == null ? ' ' : atividade.descricao;

  }

  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas(idUsuario);
    List<String> strDisciplinas = [];
    for (var i = 0; i < auxDisciplinas.length; i++) {
      strDisciplinas.add(
          auxDisciplinas[i].nome + " - " + auxDisciplinas[i].codDisciplina);
    }
    setState(() {
      disciplinas = strDisciplinas;
      listaDisciplinas = auxDisciplinas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar atividade'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da atividade'),
                  controller: titulo,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text("Data de entrega da atividade:  "),
                    ElevatedButton(
                      child: FittedBox(
                        child: Text(formatSelectedDate()),
                      ),
                      onPressed: () => pickDate(context),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor da atividade'),
                  controller: notaAtividade,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nota Obtida'),
                  controller: notaObtida,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text("Selecione a prioridade:  "),
                    DropdownButton<String>(
                      value: prioridadesDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          prioridadesDropdownValue = newValue!;
                        });
                      },
                      items: <String>['Alta', 'Media', 'Baixa']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    Text("Selecione a disciplina:  "),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: disciplinas
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descrição'),
                  controller: descricao,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {

            dbController().updateAtividades(Atividade(
                dataDeEntrega: dateEntrega.toString(),
                titulo:  titulo.text,
                prioridade:  prioridadesDropdownValue,
                idDisciplina:
                getCodDisciplinas(dropdownValue, listaDisciplinas),
                status: "A fazer",
                notaAlcancada: notaObtida.text,
                notaAtividade: notaAtividade.text));

            Navigator.pop(context);
           }),
    );
  }

  String formatSelectedDate() {
    if (dateEntrega == null) {
      return 'Selecione a data';
    } else {
      var data = '${dateEntrega.day}/${dateEntrega.month}/${dateEntrega.year}';
      dataDeEntrega = data.toString();
      return data;
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() {
      dateEntrega = newDate;
    });
  }

  String getCodDisciplinas(String str, List<Disciplina> listaDeDisciplinas) {
    String codDisciplina = '';
    for (var i = 0; i < listaDeDisciplinas.length; i++) {
      if (str.contains(listaDisciplinas[i].codDisciplina)) {
        codDisciplina = listaDisciplinas[i].codDisciplina;
      }
    }
    return codDisciplina;
  }
}


// As proximas duas classes são para exibir as atividades filtradas por status

class InterfaceAtividadeStatus extends StatefulWidget {
  final String arg;
  final int idUsuario;
  InterfaceAtividadeStatus(this.arg,this.idUsuario);
  @override
  _InterfaceAtividadeStatusState createState() => _InterfaceAtividadeStatusState(arg,idUsuario);
}

class _InterfaceAtividadeStatusState extends State<InterfaceAtividadeStatus>
{
  var disciplinas = [];
  var atividades = [];
  final String arg;
  final int idUsuario;
  _InterfaceAtividadeStatusState(this.arg,this.idUsuario);
  @override
  void initState() {
    super.initState();
    carregaListas();
    carregaUsuario();
  }


  var usuario;
  void carregaUsuario() async{
    var usuarios = await dbController().getUsuarios();
    usuario = usuarios[0];
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas(idUsuario);
    var auxAtividades = await dbController().getAtividadesStatus(arg,idUsuario);
    var auxAtividadesOrdenadas = ordenaAtividades(auxAtividades);
    setState(() {
      disciplinas = auxDisciplinas;
      atividades = auxAtividadesOrdenadas;
    });
  }

  List<Atividade> ordenaAtividades(List<Atividade> atividades) {
    List<Atividade> atividadesDesordenadas = atividades;
    atividadesDesordenadas.sort((Atividade a , Atividade b)=> a.getPrioridadeint().compareTo(b.getPrioridadeint()));
    return atividadesDesordenadas;
  }

  String formatSelectedDate(String data) {
    DateTime data1 = DateTime.parse(data);
    var dat = '${data1.day}/${data1.month}/${data1.year}';
    return dat;

  }
  @override
  Widget build(BuildContext context) {
    carregaListas();
    if (disciplinas.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades " + arg),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(
          child: Text('Nescessário cadastrar ao menos uma disciplina'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NovaDisciplina(idUsuario)));
          },
        ),
      );
    }
    if (atividades.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades "+ arg),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(
          child: Text('Não existem atividades cadastradadas ainda'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InterfaceNovaAtividade(idUsuario)));
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades ' + arg),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: Center(
        child: ListView.builder(
            itemCount: atividades.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Titulo : ' +
                                    atividades[index].titulo.toString()),
                                Text('Data de entrega : ' + formatSelectedDate(atividades[index].dataDeEntrega)),
                                Text('Prioridade : ' +
                                    atividades[index].prioridade.toString()),
                                Text('Status : ' +
                                    atividades[index].status.toString()),
                                Text('Codigo da Disciplina : ' +
                                    atividades[index].idDisciplina.toString()),
                                Text('Valor da atividade : ' +
                                    atividades[index].notaAtividade.toString()),
                                Text('Nota obtida : ' +
                                    atividades[index].notaAlcancada.toString()),
                                Text('Descricao : ' +
                                    atividades[index].descricao.toString() ),
                              ]),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 0,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          child: Text('Menu de opções'),
                                          onPressed: () {},
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: TextButton(
                                          onPressed: () {
                                            print(atividades);
                                            dbController().deleteAtividades(
                                                atividades[index].id);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Excluir"),
                                        )),
                                    PopupMenuItem(
                                        value: 2,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InterfaceEditaAtividade(
                                                            atividade:
                                                            atividades[
                                                            index],idUsuario: idUsuario,)));
                                          },
                                          child: Text("Editar"),
                                        )),
                                    PopupMenuItem(
                                        value: 3,
                                        child: TextButton(

                                          onPressed: () {
                                            if(arg != 'Concluido') {
                                              dbController().alteraStatus(
                                                  atividades[index]);
                                              dbController().aumentaXp(
                                                  usuario, 50);
                                              setState(() {
                                                atividades.removeAt(index);
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text("Concluir Atividade"),

                                        )),

                                    // PopupMenuItem(
                                    //     value: 3,
                                    //     child: TextButton(
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder: (context) =>
                                    //                       InterfaceLancarNota(
                                    //                         atividade:
                                    //                         atividades[
                                    //                         index],idUsuario: idUsuario,)));
                                    //         });
                                    //       },
                                    //       child: Text("Lançar Nota"),
                                    //     )),
                                  ],
                                  icon: Icon(Icons.settings),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InterfaceNovaAtividade(idUsuario)));
        },
      ),
    );
  }
}


class InterfaceAtividadeDisciplina extends StatefulWidget {
  final int idUsuario;
  final String nomeDisciplina;
  final String idDisciplina;

  InterfaceAtividadeDisciplina(this.idUsuario, this.idDisciplina,this.nomeDisciplina);
  @override
  _InterfaceAtividadeDisciplinaState createState() => _InterfaceAtividadeDisciplinaState(idUsuario, idDisciplina,nomeDisciplina);
}

class _InterfaceAtividadeDisciplinaState extends State<InterfaceAtividadeDisciplina> {
  final int idUsuario;
  final String idDisciplina;
  final String nomeDisciplina;
  var atividades = [];
  var xpConcluirAtividade = 50;
  _InterfaceAtividadeDisciplinaState(this.idUsuario, this.idDisciplina,this.nomeDisciplina);

  @override
  void initState() {
    super.initState();
    carregaListas();
  }
  void carregaListas() async {
    var auxAtividades = await dbController().getAtividadesDisciplina(idDisciplina.toString(),idUsuario);
    var auxAtividadesOrdenadas = ordenaAtividades(auxAtividades);
    setState(() {
      atividades = auxAtividadesOrdenadas;
    });
  }

  List<Atividade> ordenaAtividades(List<Atividade> atividades) {
    List<Atividade> atividadesDesordenadas = atividades;
    atividadesDesordenadas.sort((Atividade a , Atividade b)=> a.getPrioridadeint().compareTo(b.getPrioridadeint()));
    return atividadesDesordenadas;
  }

  String formatSelectedDate(String data) {
    DateTime data1 = DateTime.parse(data);
    var dat = '${data1.day}/${data1.month}/${data1.year}';
    return dat;

  }
  @override
  Widget build(BuildContext context) {
    carregaListas();
    if (atividades.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades de " + nomeDisciplina),
        ),
        endDrawer: gaveta(context,idUsuario),
        body: Center(
          child: Text('Não existem atividades cadastradadas para essa disciplina ainda'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InterfaceNovaAtividade(idUsuario)));
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Atividades de " + nomeDisciplina),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: Center(
        child: ListView.builder(
            itemCount: atividades.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Titulo : ' +
                                    atividades[index].titulo.toString()),
                                Text('Data de entrega : ' + formatSelectedDate(atividades[index].dataDeEntrega)),
                                Text('Prioridade : ' +
                                    atividades[index].prioridade.toString()),
                                Text('Status : ' +
                                    atividades[index].status.toString()),
                                Text('Codigo da Disciplina : ' +
                                    atividades[index].idDisciplina.toString()),
                                Text('Valor da atividade : ' +
                                    atividades[index].notaAtividade.toString()),
                                Text('Nota obtida : ' +
                                    atividades[index].notaAlcancada.toString()),
                              ]),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: PopupMenuButton<int>(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: 0,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          child: Text('Menu de opções'),
                                          onPressed: () {},
                                        )),
                                    PopupMenuItem(
                                        value: 1,
                                        child: TextButton(
                                          onPressed: () {
                                            dbController().deleteAtividades(
                                                atividades[index].id);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Excluir"),
                                        )),
                                    PopupMenuItem(
                                        value: 2,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InterfaceEditaAtividade(
                                                          atividade:
                                                          atividades[
                                                          index],idUsuario: idUsuario,)));
                                          },
                                          child: Text("Editar"),
                                        )),
                                  ],
                                  icon: Icon(Icons.settings),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InterfaceNovaAtividade(idUsuario)));
        },
      ),
    );
  }
}