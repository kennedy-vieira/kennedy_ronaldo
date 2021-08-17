import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:agenda/dataBase.dart';
import 'package:agenda/utilitarios.dart';

class InterfacePerfil extends StatefulWidget {
  final int idUsuario;
  InterfacePerfil(this.idUsuario);
  @override
  _InterfacePerfilState createState() => _InterfacePerfilState(idUsuario);


}

class _InterfacePerfilState extends State<InterfacePerfil> {
  final int idUsuario;
  var xp = 0;
  var levelProgress = 0.0;
  var currentLevel = 0;
  var numAtividades = 0;







  _InterfacePerfilState(this.idUsuario);
  @override
  void initState() {
    super.initState();
    carregaUsuario();
  }


  var usuario;
  void carregaUsuario() async{
    var usuarios = await dbController().getUsuarios();
    var auxAtividades = await dbController().getAtividadesStatus('Concluido',idUsuario);



    setState(() {
      usuario = usuarios[0];
      xp = usuarios[0].experiencia != null ? usuarios[0].experiencia : 0;
      numAtividades = auxAtividades.length;
    });
  }




  @override
  Widget build(BuildContext context){
    print(xp);
    getLevel();
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: Column(//SingleChildScrollView(
        //child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding:  const EdgeInsets.all(8.0) ,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '\nProgresso do nivel atual:\n',
                    style:TextStyle(fontSize: 20,color: Colors.blue)
                ),
              ],
            ),

          ),
          Container(
            child: LinearProgressIndicator(
              value: levelProgress,
              minHeight: 15,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),

            ),
          ),
          // Container(
          //   child: Text(
          //     'Nivel: ' + currentLevel.toString(),
          //   ),
          // ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.center,
              child: Text(
                  '\n\n\n Nivel: ' + currentLevel.toString(),
                  style: TextStyle(fontSize: 20,color: Colors.blue)),
            ),
          ),

          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child:  RichText(
                  text: TextSpan(
                    //style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Conquistas' + "\n\n", style: TextStyle(fontSize: 20,color: Colors.blue)),
                        TextSpan(text: getConquistas(), style: TextStyle(fontSize: 15,color: Colors.cyan))
                      ]
                  ),
                )
            ),
          ),
          // Expanded(
          //   child: Align(
          //     alignment: FractionalOffset.bottomCenter,
          //     child:  Text(
          //       'Conquistas: ' + "\n" + "\n"+ getConquistas(),
          //     ),
          //   ),
          // ),


        ],
      ),
      //),
    );
  }

  String getConquistas(){
    var conquistaDisc1 = "Bem Vindo! (Alcançado ao completar uma atividade)";
    var conquistaDisc2 = "Esforçado! (Alcançado ao completar cinco atividades)";
    var conquistaDisc3 = "Bom Aluno! (Alcançado ao completar dez atividades)";
    var conquistaDisc4 = "Pontual (Alcançado ao completar entregar uma atividade sem atraso)";
    var conquistaDisc5 = "Sem atrasos (Alcançado ao completar entregar cinco atividades sem atraso)";
    var conquistaProgress1 = "Calouro! (Alcançado ao alcançar o nível 1)";
    var conquistaProgress2 = "Nem tão Calouro! (Alcançado ao alcançar o nível 5)";
    var conquistaProgress3 = "Veterano! (Alcançado ao alcançar o nível 15)";

    var conquistas = "";

    if(numAtividades >= 1)conquistas += conquistaDisc1 + "\n";
    if(numAtividades >= 5)conquistas += conquistaDisc2 + "\n";
    if(numAtividades >= 10)conquistas += conquistaDisc3 + "\n";
    if(currentLevel >=1)conquistas += conquistaProgress1 + "\n";
    if(currentLevel >=5)conquistas += conquistaProgress2 + "\n";
    if(currentLevel >=15)conquistas += conquistaProgress3 + "\n";
    return conquistas;
  }


  void getLevel(){
    //FORMULA PARA OBTER O NIVEL
    //NIVEL = N * 100 + N-1 * 0,1
    var qtdNiveis = 30;
    var level = new List.filled(qtdNiveis,0);
    var trueLevel;
    var progress;
    //Preenchendo o vetor com as informacoes sobre cada nivel
    for(var i = 1; i < level.length;i++){
      var aux = (i-1)*0.10;
      level[i] = (i * 100) + (aux.toInt());
    }
    //Calcula o nivel atual com base no xp
    for(var i = 1; i < level.length;i++){
      if(xp >= level[i-1] && xp < level[i]){
        trueLevel = i-1;
      }
    }
    //Calcula a porcentagem de progresso do nivel atual com base no xp
    progress = xp/(level[trueLevel + 1]);
    currentLevel = trueLevel;
    levelProgress = progress;

  }

}