import 'package:core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('baseImageUrl should be defined', () {
    expect(baseImageUrl, isNotEmpty);
    expect(baseImageUrl, 'https://image.tmdb.org/t/p/w500');
  });
}
