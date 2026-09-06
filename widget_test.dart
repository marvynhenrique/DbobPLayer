import 'package:dbob_player/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DBob Player starts', (tester) async {
    await tester.pumpWidget(const DBobPlayerApp());
    expect(find.textContaining('DBob'), findsWidgets);
  });
}
