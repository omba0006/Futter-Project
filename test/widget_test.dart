
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_final_project_mad9135/main.dart';
void main() {
  testWidgets('Main app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp()); 

    
    expect(find.text('Welcome'), findsOneWidget);
  });
}
