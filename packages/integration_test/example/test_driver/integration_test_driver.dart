import 'dart:convert';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:path/path.dart' as path;
import 'package:integration_test/integration_test_driver.dart'
    as integration_test_driver;

const JsonEncoder _prettyEncoder = JsonEncoder.withIndent('  ');

String _encodeJson(Object jsonObject, bool pretty) {
  return pretty ? _prettyEncoder.convert(jsonObject) : json.encode(jsonObject);
}

DriverLogCallback logDriverMessages = (String source, String message) {
  final msg = '$source:: $message';
  if (message.toLowerCase().contains('error')) {
    stderr.writeln(msg);
  } else {
    stdout.writeln(msg);
  }
};

Future<void> writeGherkinReports(
  Map<String, dynamic> data, {
  String testOutputFilename = 'integration_response_data',
  String destinationDirectory,
}) async {
  await integration_test_driver.writeResponseData(
    data,
    testOutputFilename: 'gherkin_reports',
    destinationDirectory: destinationDirectory,
  );

  final reports = json.decode(data['gherkin_reports'].toString()) as List<dynamic>;
  print('---<reportLength>---');
  print(data);
  print('---<reportLength>---');
  for (var i = 0; i < reports.length; i += 1) {
    final reportData = reports.elementAt(i) as List<dynamic>;

    await fs
        .directory(integration_test_driver.testOutputsDirectory)
        .create(recursive: true);
    final File file = fs.file(path.join(
      integration_test_driver.testOutputsDirectory,
      'report_$i.json',
    ));
    final String resultString = _encodeJson(reportData, true);
    await file.writeAsString(resultString);
  }
}

Future<void> main() {
  // The Gherkin report data send back to this runner by the app after
  // the tests have run will be saved to this directory
//  driverLog = logDriverMessages;
  integration_test_driver.testOutputsDirectory =
      'integration_test/gherkin/reports';

  return integration_test_driver.integrationDriver(
    timeout: const Duration(minutes: 120),
//    responseDataCallback: writeGherkinReports,
  );
}
