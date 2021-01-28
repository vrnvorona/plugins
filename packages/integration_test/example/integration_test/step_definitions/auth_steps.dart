import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin_integration_test.dart';

class AuthSteps {
  Iterable<StepDefinitionGeneric> get steps => [
    when<FlutterWidgetTesterWorld>(
      'Я тестирую прилу',
          (context) async {
        final tester = context.world.appDriver.rawDriver;
        await tester.pumpAndSettle();
        expect(2 + 2, equals(5));
      },
    ),
    when<FlutterWidgetTesterWorld>(
      'Я успешно тестирую прилу',
          (context) async {
        final tester = context.world.appDriver.rawDriver;
        await tester.pumpAndSettle();
        expect(2 + 2, equals(4));
      },
    ),
  ];
}
