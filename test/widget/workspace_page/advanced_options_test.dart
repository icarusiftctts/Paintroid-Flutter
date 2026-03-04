import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:paintroid/app.dart';
import '../../utils/test_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late Widget sut;

  setUp(() async {
    sut = ProviderScope(
      child: App(
        showOnboardingPage: false,
      ),
    );
  });

  group('[OVERFLOW_MENU]: AdvancedOptions', () {
    testWidgets('Open dialog, defaults OFF, toggle and confirm',
            (WidgetTester tester) async {

          UIInteraction.initialize(tester);
          await tester.pumpWidget(sut);
          await UIInteraction.createNewImage();

          // 1. Open overflow
          await UIInteraction.openOverflowMenu();

          // 2. Taps Advanced Options
          await tester.tap(find.text('Advanced Options'));
          await tester.pumpAndSettle();

          // 3. Text Visibility Check
          expect(find.text('Advanced Options'), findsOneWidget);
          expect(find.text('Antialiasing'), findsOneWidget);
          expect(find.text('Smoothing'), findsOneWidget);

          // 4. Defaults set to OFF
          final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
          expect(switches.length, 2);
          expect(switches[0].value, false);
          expect(switches[1].value, false);

          // 5. Toggle first switch
          await tester.tap(find.byType(Switch).first);
          await tester.pump();

          final updatedSwitch =
          tester.firstWidget<Switch>(find.byType(Switch).first);
          expect(updatedSwitch.value, true);

          // 6. Confirm
          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();

          // 7. Dismissed
          expect(find.text('Advanced Options'), findsNothing);

          // 8. Persistence Check
          await UIInteraction.openOverflowMenu();
          await tester.tap(find.text('Advanced Options'));
          await tester.pumpAndSettle();

          final persistedSwitches =
          tester.widgetList<Switch>(find.byType(Switch)).toList();
          expect(persistedSwitches[0].value, true);
        });
  });
}