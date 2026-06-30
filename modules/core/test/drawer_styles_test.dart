import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';

void main() {
  group('kDrawerTheme', () {
    test('should have correct background color', () {
      expect(kDrawerTheme, isNotNull);
      expect(
        kDrawerTheme.backgroundColor,
        equals(Colors.grey.shade700),
      );
    });
  });
}
