import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda/interfacePerfil.dart';
import 'package:agenda/main.dart';


void main(){

  //Niveis de 0 a 30
  var level = [0, 100, 210, 321, 432, 543, 654, 765, 876, 987, 1098, 1209, 1320, 1432, 1543, 1654, 1765, 1876, 1987, 2098, 2209, 2320, 2432, 2543, 2654, 2765, 2876, 2987, 3098, 3209];

  test('Teste nivel atual', (){
    var result = CurrentLevelValidator.calculateLevel(324, level);
    expect(result,3);
  });

  test('Teste nivel atual', (){
    var result = CurrentLevelValidator.calculateLevel(2456, level);
    expect(result,22);
  });
}