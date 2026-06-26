import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('routeObserver', () {
    test('should create RouteObserver instance', () {
      expect(routeObserver, isA<RouteObserver<ModalRoute>>());
    });
  });
}