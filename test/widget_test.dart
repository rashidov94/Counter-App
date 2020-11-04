// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/redux/app_reducer.dart';
import 'package:flutter_app/redux/app_state.dart';
import 'package:flutter_app/repository/repository.dart';
import 'package:flutter_app/screen/counter_cubit.dart';
import 'package:flutter_app/screen/counter_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

class MockCounterCubit extends MockBloc<int> implements CounterCubit {}

void main() {
  mainCubit();
}

void mainCubit() {
  group('whenListen', () {
    test("Let's mock the CounterCubit's stream!", () {
      // Create Mock CounterCubit Instance
      final cubit = MockCounterCubit();

      // Stub the listen with a fake Stream
      whenListen(cubit, Stream.fromIterable([0, 1, 2, 3]));

      // Expect that the CounterCubit instance emitted the stubbed Stream of
      // states
      expectLater(cubit, emitsInOrder(<int>[0, 1, 2, 3]));
    });
  });

  group('CounterCubit', () {
    blocTest<CounterCubit, int>(
      'emits [] when nothing is called',
      build: () => CounterCubit(),
      expect: const <int>[],
    );

    blocTest<CounterCubit, int>(
      'emits [1] when increment is called',
      build: () => CounterCubit(),
      act: (cubit) async => cubit.increment(),
      expect: const <int>[1],
    );
  });
}

//void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp(Store<AppState>(appReducer), Repository()));
  //   await tester.pumpWidget(CounterPage());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
//}
