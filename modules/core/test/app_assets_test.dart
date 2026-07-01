import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppAssets', () {
    test('should contain correct package name', () {
      expect(AppAssets.package, equals('core'));
    });

    test('should contain correct logo asset path', () {
      expect(AppAssets.logo, equals('assets/circle-g.png'));
    });

    test('should contain correct certificate asset path', () {
      expect(AppAssets.certificate, equals('assets/tmdb.pem'));
    });
  });
}
