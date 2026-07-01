import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('State Enum', () {
    test('RequestState should have Empty, Loading, Loaded, Error values', () {
      expect(RequestState.empty, isNotNull);
      expect(RequestState.loading, isNotNull);
      expect(RequestState.loaded, isNotNull);
      expect(RequestState.error, isNotNull);
    });

    test('RequestState values should be distinct', () {
      expect(RequestState.empty, isNot(RequestState.loading));
      expect(RequestState.loading, isNot(RequestState.loaded));
      expect(RequestState.loaded, isNot(RequestState.error));
      expect(RequestState.error, isNot(RequestState.empty));
    });

    test('Empty state should represent initial state', () {
      final state = RequestState.empty;
      expect(state, isNotNull);
    });

    test('Loading state should represent loading state', () {
      final state = RequestState.loading;
      expect(state, isNotNull);
    });

    test('Loaded state should represent loaded state', () {
      final state = RequestState.loaded;
      expect(state, isNotNull);
    });

    test('Error state should represent error state', () {
      final state = RequestState.error;
      expect(state, isNotNull);
    });
  });
}
