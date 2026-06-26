import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Failure', () {
    test('ServerFailure should have message', () {
      const message = 'Server error';
      final failure = ServerFailure(message);
      expect(failure.message, message);
    });

    test('ServerFailure props should include message', () {
      const message = 'Server error';
      final failure = ServerFailure(message);
      expect(failure.props, [message]);
    });

    test('Two ServerFailures with same message should be equal', () {
      const message = 'Server error';
      final failure1 = ServerFailure(message);
      final failure2 = ServerFailure(message);
      expect(failure1, failure2);
    });

    test('ConnectionFailure should have message', () {
      const message = 'Connection error';
      final failure = ConnectionFailure(message);
      expect(failure.message, message);
    });

    test('ConnectionFailure props should include message', () {
      const message = 'Connection error';
      final failure = ConnectionFailure(message);
      expect(failure.props, [message]);
    });

    test('DatabaseFailure should have message', () {
      const message = 'Database error';
      final failure = DatabaseFailure(message);
      expect(failure.message, message);
    });

    test('DatabaseFailure props should include message', () {
      const message = 'Database error';
      final failure = DatabaseFailure(message);
      expect(failure.props, [message]);
    });

    test('CacheFailure should have message', () {
      const message = 'Cache error';
      final failure = CacheFailure(message);
      expect(failure.message, message);
    });

    test('CacheFailure props should include message', () {
      const message = 'Cache error';
      final failure = CacheFailure(message);
      expect(failure.props, [message]);
    });

    test('Different failure types should not be equal', () {
      const message = 'error';
      final serverFailure = ServerFailure(message);
      final connectionFailure = ConnectionFailure(message);
      expect(serverFailure, isNot(connectionFailure));
    });

    test('Different failure messages should not be equal', () {
      final failure1 = ServerFailure('Error 1');
      final failure2 = ServerFailure('Error 2');
      expect(failure1, isNot(failure2));
    });
  });
}