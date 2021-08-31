import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'utilitarios.dart';
import 'dataBase.dart';


class CurrentLevelValidator {
  static int calculateLevel(int xp, List level){
    //Calcula o nivel atual com base no xp
    for(var i = 1; i < level.length;i++){
      if(xp >= level[i-1] && xp < level[i]){
        return  i-1;
      }
    }
    return 0;
  }
}


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
  var progressConq = 0.0;







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
    List<String> conquistas = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: Column(//SingleChildScrollView(
        //child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding:  const EdgeInsets.all(8.0) ,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Nivel: ' + currentLevel.toString() + "\n",
                    style:TextStyle(fontSize: 25,color: Colors.red)
                ),
                Text(
                    ' Progresso do nivel atual:\n',
                    style:TextStyle(fontSize: 25,color: Colors.blue)
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

          // Expanded(
          //   child: Align(
          //     alignment: FractionalOffset.topCenter,
          //     child: Text(
          //         '\n\n\n Nivel: ' + currentLevel.toString(),
          //         style: TextStyle(fontSize: 30,color: Colors.blue)),
          //   ),
          // ),



          Expanded(
            child: Align(
                alignment: FractionalOffset.center,
                child:  RichText(
                    text: getConquistas1()
                )
            ),
          ),
          // Expanded(
          //   child: Align(
          //       alignment: FractionalOffset.center,
          //       child:  Container(
          //         child: LinearProgressIndicator(
          //           value: progressConq,
          //           minHeight: 15,
          //           valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //
          //         ),
          //       ),
          //   ),
          // ),



        ],
      ),
      //),
    );
  }

  TextSpan getConquistas1(){
    var conquistaDisc1 = "Bem Vindo! (Alcançado ao completar uma atividade)";
    var conquistaDisc2 = "Esforçado! (Alcançado ao completar cinco atividades)";
    var conquistaDisc3 = "Bom Aluno! (Alcançado ao completar dez atividades)";
    var conquistaProgress1 = "Calouro! (Alcançado ao alcançar o nível 1)";
    var conquistaProgress2 = "Nem tão Calouro! (Alcançado ao alcançar o nível 5)";
    var conquistaProgress3 = "Veterano! (Alcançado ao alcançar o nível 15)";
    var conquistaFinal = "Formando?! (Alcançado ao desbloquear todas as conquistas)";
    var qtdConquistas = 7;
    TextSpan textSpan1 = new TextSpan(children:[]);
    textSpan1.children!.add(TextSpan(text: 'Conquistas' + "\n\n", style: TextStyle(fontSize: 30,color: Colors.blue)));

    List<String> conquistas = [];

    if(numAtividades >= 1)conquistas.add(conquistaDisc1 + "\n\n");
    if(numAtividades >= 5)conquistas.add(conquistaDisc2 + "\n\n");
    if(numAtividades >= 10)conquistas.add(conquistaDisc3 + "\n\n");
    if(currentLevel >=1)conquistas.add(conquistaProgress1 + "\n\n");
    if(currentLevel >=5)conquistas.add(conquistaProgress2 + "\n\n");
    if(currentLevel >=15)conquistas.add(conquistaProgress3 + "\n\n");
    if(conquistas.length == qtdConquistas - 1)conquistas.add(conquistaFinal + "\n\n");

    progressConq = conquistas.length/qtdConquistas;

    for(int i  = 0; i < conquistas.length;i++){
      var color = Colors.cyan;
      if(i%3 == 1){
        color = Colors.deepOrange;
      }else if(i%3 == 2){
        color = Colors.deepPurple;
      }

      textSpan1.children!.add(TextSpan(text: conquistas[i], style: TextStyle(fontSize: 20,color: color)));

    }


    return textSpan1;
  }
  //Versão que retornava string (nova versão criada acima)
  String getConquistas(){
    var conquistaDisc1 = "Bem Vindo! (Alcançado ao completar uma atividade)";
    var conquistaDisc2 = "Esforçado! (Alcançado ao completar cinco atividades)";
    var conquistaDisc3 = "Bom Aluno! (Alcançado ao completar dez atividades)";
    var conquistaDisc4 = "Pontual (Alcançado ao completar entregar uma atividade sem atraso)";
    var conquistaDisc5 = "Sem atrasos (Alcançado ao completar entregar cinco atividades sem atraso)";
    var conquistaProgress1 = "Calouro! (Alcançado ao alcançar o nível 1)";
    var conquistaProgress2 = "Nem tão Calouro! (Alcançado ao alcançar o nível 5)";
    var conquistaProgress3 = "Veterano! (Alcançado ao alcançar o nível 15)";

    //conquistas1.add("value");

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
      var aux = level[i-1]*0.10;
      level[i] = (i * 100) + (aux.toInt());
    }
    print(level);
    //Calcula o nivel atual com base no xp
    for(var i = 1; i < level.length;i++){
      if(xp >= level[i-1] && xp < level[i]){
        trueLevel = i-1;
      }
    }
    //Calcula a porcentagem de progresso do nivel atual com base no xp
    progress = xp/(level[trueLevel + 1]);
    currentLevel = CurrentLevelValidator.calculateLevel(xp, level);
    levelProgress = progress;

  }

}