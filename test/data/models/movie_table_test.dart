import 'package:ditonton/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return a JSON map from MovieTable', () async {
    final result = testMovieTable.toJson();
    expect(result, testMovieMap);
  });
}
