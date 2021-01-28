import 'package:flutter_gherkin/flutter_gherkin_integration_test.dart'; // notice new import name
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';

// The application under test.
import 'package:integration_test_example/main.dart' as app;
import 'step_definitions/auth_steps.dart';

part 'gherkin_suite_test.g.dart';
//flutter drive --driver=test_driver/integration_test_driver.dart --target=integration_test/gherkin_suite_test.dart
@GherkinTestSuite(featureDefaultLanguage: 'ru')
void main() {
  executeTestSuite(
    FlutterTestConfiguration.DEFAULT([])
      ..reporters = [
        StdoutReporter(MessageLevel.error)
          ..setWriteLineFn(print)
          ..setWriteFn(print),
        ProgressReporter()
          ..setWriteLineFn(print)
          ..setWriteFn(print),
        TestRunSummaryReporter()
          ..setWriteLineFn(print)
          ..setWriteFn(print),
        JsonReporter(writeReport: (_, __) => Future<void>.value()),
      ]
    ..stepDefinitions = AuthSteps().steps,
    (World world) => app.main(),
  );

}
