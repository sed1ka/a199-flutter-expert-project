import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return a JSON map from TVTable', () async {
    final result = testTVTable.toJson();
    expect(result, testTVMap);
  });
}
