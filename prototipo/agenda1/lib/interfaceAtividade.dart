import 'atividade.dart';
import 'dataBase.dart';
import 'interfaceDisciplina.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'disciplina.dart';
import 'utilitarios.dart';

class InterfaceAtividade extends StatefulWidget {
  @override
  _InterfaceAtividadeState createState() => _InterfaceAtividadeState();
}

class _InterfaceAtividadeState extends State<InterfaceAtividade> {
  var disciplinas = [];
  var atividades = [];
  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas();
    var auxAtividades = await dbController().getAtividades();
    var auxAtividadesOrdenadas = ordenaAtividades(auxAtividades);
    setState(() {
      disciplinas = auxDisciplinas;
      atividades = auxAtividadesOrdenadas;
    });
  }

  List<Atividade> ordenaAtividades(List<Atividade> atividades) {
    List<Atividade> atividadesOrdenadas = [];
    List<Atividade> atividadesDesordenadas = atividades;
    var day, month, year;
    for (var i = 0; i < atividadesDesordenadas.length; i++) {
      if (atividadesDesordenadas[i].prioridade == 'Alta') {
        atividadesOrdenadas.add(atividadesDesordenadas[i]);
      }
    }
    for (var i = 0; i < atividadesDesordenadas.length; i++) {
      if (atividadesDesordenadas[i].prioridade == 'Media') {
        atividadesOrdenadas.add(atividadesDesordenadas[i]);
      }
    }
    for (var i = 0; i < atividadesDesordenadas.length; i++) {
      if (atividadesDesordenadas[i].prioridade == 'Baixa') {
        atividadesOrdenadas.add(atividadesDesordenadas[i]);
      }
    }
    for (var i = 0; i < atividadesDesordenadas.length; i++) {
      if (atividadesDesordenadas[i].prioridade != 'Baixa' &&
          atividadesDesordenadas[i].prioridade != 'Media' &&
          atividadesDesordenadas[i].prioridade != 'Alta') {
        atividadesOrdenadas.add(atividadesDesordenadas[i]);
      }
    }

    return atividadesOrdenadas;
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
        endDrawer: gaveta(context),
        body: Center(
          child: Text('Nescessário cadastrar ao menos uma disciplina'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(
                context); //tira a gaveta do navegador pra quando vc voltar a gaveta vai estar fechada
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NovaDisciplina()));
          },
        ),
      );
    }
    if (atividades.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Atividades"),
        ),
        endDrawer: gaveta(context),
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
                    builder: (context) => InterfaceNovaAtividade()));
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Atividades'),
      ),
      endDrawer: gaveta(context),
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
                                                            index])));
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
                  builder: (context) => InterfaceNovaAtividade()));
        },
      ),
    );
  }
}

class InterfaceNovaAtividade extends StatefulWidget {
  @override
  _InterfaceNovaAtividadeState createState() => _InterfaceNovaAtividadeState();
}

class _InterfaceNovaAtividadeState extends State<InterfaceNovaAtividade> {
  var titulo = TextEditingController();
  var dataDeEntrega;
  var prioridade = TextEditingController();
  //var status = TextEditingController();
  var idDisciplina = TextEditingController();
  //var notaAlcancada = TextEditingController();
  var notaAtividade = TextEditingController();
  List<String> disciplinas = [];
  List<Disciplina> listaDisciplinas = [];
  var dropdownValue;
  var prioridadesDropdownValue = "Media";
  var dateEntrega;

  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas();
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
      endDrawer: gaveta(context),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            dbController().insereAtividade(Atividade(
                dataDeEntrega: dateEntrega.toString(),
                titulo: titulo.text,
                prioridade: prioridadesDropdownValue,
                idDisciplina:
                getCodDisciplinas(dropdownValue, listaDisciplinas),
                status: "A fazer",
                notaAlcancada: "",
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

class InterfaceEditaAtividade extends StatefulWidget {
  final Atividade atividade;
  InterfaceEditaAtividade({required this.atividade}) {}

  @override
  _InterfaceEditaAtividadeState createState() =>
      _InterfaceEditaAtividadeState(atividade);
}

class _InterfaceEditaAtividadeState extends State<InterfaceEditaAtividade> {
  var titulo = TextEditingController();
  var dataDeEntrega;
  var prioridade = TextEditingController();
  var notaAtividade = TextEditingController();
  var notaObtida = TextEditingController();
  List<String> disciplinas = [];
  List<Disciplina> listaDisciplinas = [];
  var dropdownValue;
  var prioridadesDropdownValue = "Media";
  var dateEntrega;

  _InterfaceEditaAtividadeState(Atividade atividade) {

    titulo.text = atividade.titulo;
    prioridade.text = atividade.prioridade;
    prioridadesDropdownValue = atividade.prioridade;
    notaAtividade.text = atividade.notaAtividade.toString();
    dateEntrega = DateTime.parse(atividade.dataDeEntrega);

  }

  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var auxDisciplinas = await dbController().getDisciplinas();
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
      endDrawer: gaveta(context),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {

            dbController().updateAtividades(Atividade(
                dataDeEntrega: dateEntrega.toString(),
                titulo: titulo.text,
                prioridade: prioridadesDropdownValue,
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
