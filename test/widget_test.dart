import 'package:dbob_player/src/app/dbob_player_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DBob Player starts', (tester) async {
    await tester.pumpWidget(const DBobPlayerApp());

    expect(find.textContaining('DBob'), findsWidgets);
  });
}
