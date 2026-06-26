import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return a JSON map from TvTable', () async {
    final result = testTvTable.toJson();
    expect(result, testTvMap);
  });
}
