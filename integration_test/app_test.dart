import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myfirst_app/main.dart' as app;

void main() {
  testWidgets('Favorites operations test', (tester) async {
    app.main();

    await tester.pumpAndSettle();

    var textFinder = find.byKey(Key('wordText'));
    var nextButton = find.text("Next");

    String initialText = tester.widget<Text>(textFinder).data ?? '';
    print(initialText);

    await tester.tap(nextButton);
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    String changedText = tester.widget<Text>(textFinder).data ?? '';
    print(changedText);

    expect(initialText, isNot(equals(changedText)));

    final likeButton = find.text('Like');

    await tester.pumpAndSettle();
    await tester.tap(nextButton);
    await Future.delayed(const Duration(seconds: 2));

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(likeButton);

    await tester.pumpAndSettle();

    await tester.tap(find.text('Favorites'));

    await tester.pumpAndSettle();

    // Finder tileFinder = find.descendant(
    //   of: find.byType(ListView),
    //   matching: find.byWidgetPredicate(
    //     (widget) =>
    //         widget is ListTile &&
    //         widget.leading is Icon && // Check if the leading widget is an Icon
    //         (widget.leading as Icon).icon ==
    //             Icons.favorite && // Check if the Icon has the favorite icon
    //         widget.title
    //             is Text && // Check if the title widget is a Text widget
    //         (widget.title as Text).data ==
    //             changedText, // Check if the Text widget contains the lowercase text of the word pair
    //   ),
    // );

    var favouriteText = find.byKey(Key('favouriteText'));

    expect(favouriteText, findsOneWidget);

    await Future.delayed(const Duration(seconds: 10));
  });
}
