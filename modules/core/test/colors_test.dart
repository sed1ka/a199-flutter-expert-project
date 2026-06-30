import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color constants', () {
    test('should expose correct colors', () {
      expect(kRichBlack, const Color(0xFF000814));
      expect(kOxfordBlue, const Color(0xFF001D3D));
      expect(kPrussianBlue, const Color(0xFF003566));
      expect(kMikadoYellow, const Color(0xFFFFC300));
      expect(kDavysGrey, const Color(0xFF4B5358));
      expect(kGrey, const Color(0xFF303030));
    });
  });

  group('kColorScheme', () {
    test('should have correct color configuration', () {
      expect(kColorScheme.primary, kMikadoYellow);
      expect(kColorScheme.secondary, kPrussianBlue);
      expect(kColorScheme.secondaryContainer, kPrussianBlue);
      expect(kColorScheme.surface, kRichBlack);
      expect(kColorScheme.error, Colors.red);
      expect(kColorScheme.onPrimary, kRichBlack);
      expect(kColorScheme.onSecondary, Colors.white);
      expect(kColorScheme.onSurface, Colors.white);
      expect(kColorScheme.onError, Colors.white);
      expect(kColorScheme.brightness, Brightness.dark);
    });
  });
}
