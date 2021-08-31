import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agenda/interfaceDisciplina.dart';

import 'package:agenda/main.dart';

void main() {
  testWidgets('Teste nova disciplina', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new InterfaceDisciplina(1))
    );
    await tester.pumpWidget(testWidget);

    expect(find.byIcon(Icons.add),findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();



  });
}