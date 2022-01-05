import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reditech/components/voteBar.dart';

void main() {
  testWidgets('Check votebar upvote & downvote', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(VoteBar(id: "1", score: 10));

    // Verify that our counter starts at 0.
    expect(find.text('10'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_upward));
    expect(find.text('11'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_downward));
    expect(find.text('10'), findsNothing);
    expect(find.text('9'), findsOneWidget);
  });
}
