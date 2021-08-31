import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda/interfaceDisciplina.dart';


void main() {
  testWidgets('Teste nova disciplina', (WidgetTester tester) async {

    //cria o widget da lista de disciplinas
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new InterfaceDisciplina(1))
    );

    await tester.pumpWidget(testWidget);

    //procura o botão de adicionar nova disciplina
    expect(find.byIcon(Icons.add),findsOneWidget);

    //aperta o botão de adicionar disciplina
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    //verifica se o botão de adicionar disciplina foi substituido pelo de salvar
    //a disciplina
    expect(find.byIcon(Icons.save),findsOneWidget);
    expect(find.byIcon(Icons.add),findsNothing);


  });
}