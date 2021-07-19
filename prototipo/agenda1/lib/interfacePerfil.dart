import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'utilitarios.dart';
import 'dataBase.dart';

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



  _InterfacePerfilState(this.idUsuario);
  @override
  void initState() {
    super.initState();
    carregaListas();
  }

  void carregaListas() async {
    var usuarios = await dbController().getUsuarios();
    var auxUserXp = 0;
    usuarios.forEach((user) {
      if(user.id == this.idUsuario){
        auxUserXp = user.experiencia;
      }
    });
    setState(() {
      xp = auxUserXp;
    });
  }


  @override
  Widget build(BuildContext context){
    getLevel();
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      endDrawer: gaveta(context,idUsuario),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(

              child: Text(
                'Nivel: ' + currentLevel.toString(),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding:  const EdgeInsets.all(8.0) ,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progresso do nivel atual:',
                  ),
                ],
              ),

            ),
            Container(
              child: LinearProgressIndicator(
                value: levelProgress,
                minHeight: 10,
                color: Colors.green,

              ),
            ),

          ],
        ),
      ),
    );
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