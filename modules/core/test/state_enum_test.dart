import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('State Enum', () {
    test('RequestState should have Empty, Loading, Loaded, Error values', () {
      expect(RequestState.Empty, isNotNull);
      expect(RequestState.Loading, isNotNull);
      expect(RequestState.Loaded, isNotNull);
      expect(RequestState.Error, isNotNull);
    });

    test('RequestState values should be distinct', () {
      expect(RequestState.Empty, isNot(RequestState.Loading));
      expect(RequestState.Loading, isNot(RequestState.Loaded));
      expect(RequestState.Loaded, isNot(RequestState.Error));
      expect(RequestState.Error, isNot(RequestState.Empty));
    });

    test('Empty state should represent initial state', () {
      final state = RequestState.Empty;
      expect(state, isNotNull);
    });

    test('Loading state should represent loading state', () {
      final state = RequestState.Loading;
      expect(state, isNotNull);
    });

    test('Loaded state should represent loaded state', () {
      final state = RequestState.Loaded;
      expect(state, isNotNull);
    });

    test('Error state should represent error state', () {
      final state = RequestState.Error;
      expect(state, isNotNull);
    });
  });
}
