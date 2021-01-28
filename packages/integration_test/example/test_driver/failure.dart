// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:integration_test_example/main.dart' as app;

//flutter drive --driver=test_driver/integration_test_driver.dart --target=test_driver/failure.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('failure 2', (WidgetTester tester) async {
    (tester.binding as IntegrationTestWidgetsFlutterBinding).reportData = {'gherkin_reports': [[1]]};
    expect(1 + 1, 2); // This should fail
  });
}
