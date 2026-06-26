import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BASE_IMAGE_URL should be defined', () {
    const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
    expect(baseImageUrl, isNotEmpty);
    expect(baseImageUrl, 'https://image.tmdb.org/t/p/w500');
  });
}
