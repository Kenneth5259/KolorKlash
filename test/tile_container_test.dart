import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kolor_klash/state/app_state.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';
import 'package:kolor_klash/widgets/tile_container.dart';
import 'package:kolor_klash/widgets/flex_column.dart'; // Your FlexColumn import may differ
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  final store = Store<AppState>(
        (state, action) => state,
    initialState: _initialAppState,
  );

  testWidgets('TileContainer is properly rendered', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: StoreProvider<AppState>(
        store: store,
        child: TileContainer(
          size: store.state.gridSize,
          row: 0,
          column: 0,
        ),
      ),
    ));

    expect(find.byType(TileContainer), findsOneWidget);
    expect(find.byType(StoreConnector<AppState, AppState>), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(FlexColumn), findsNWidgets(store.state.gridSize)); // Check for FlexColumns
    expect(
        find.byWidgetPredicate(
              (Widget widget) =>
          widget is Padding && widget.padding == EdgeInsets.all(4.0),
        ),
        findsOneWidget
    );
  });
}

AppState get _initialAppState {
  return AppState(gridSize: 3)
    ..grid = List.generate(
        3,
            (_) => List.generate(
          3,
              (_) => TileContainerReduxState(
            container: TileContainer(
              size: 3,
              row: 0,
              column: 0,
            ),
          ),
        ));
}
