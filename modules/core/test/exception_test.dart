import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ServerException', () {
    test('ServerException should be an Exception', () {
      final exception = ServerException();
      expect(exception, isA<Exception>());
    });

    test('ServerException can be thrown and caught', () {
      expect(
            () => throw ServerException(),
        throwsA(isA<ServerException>()),
      );
    });

    test('ServerException should not be null', () {
      final exception = ServerException();
      expect(exception, isNotNull);
    });
  });

  group('DatabaseException', () {
    test('DatabaseException should have message property', () {
      const message = 'Database error';
      final exception = DatabaseException(message);
      expect(exception.message, message);
    });

    test('DatabaseException should be an Exception', () {
      final exception = DatabaseException('test');
      expect(exception, isA<Exception>());
    });

    test('DatabaseException can be thrown and caught', () {
      expect(
            () => throw DatabaseException('test error'),
        throwsA(isA<DatabaseException>()),
      );
    });

    test('DatabaseException with different messages', () {
      const message1 = 'Error 1';
      const message2 = 'Error 2';
      final exception1 = DatabaseException(message1);
      final exception2 = DatabaseException(message2);

      expect(exception1.message, message1);
      expect(exception2.message, message2);
      expect(exception1.message, isNot(exception2.message));
    });
  });

  group('CacheException', () {
    test('CacheException should have message property', () {
      const message = 'Cache error';
      final exception = CacheException(message);
      expect(exception.message, message);
    });

    test('CacheException should be an Exception', () {
      final exception = CacheException('test');
      expect(exception, isA<Exception>());
    });

    test('CacheException can be thrown and caught', () {
      expect(
            () => throw CacheException('test error'),
        throwsA(isA<CacheException>()),
      );
    });

    test('CacheException with different messages', () {
      const message1 = 'Cache error 1';
      const message2 = 'Cache error 2';
      final exception1 = CacheException(message1);
      final exception2 = CacheException(message2);

      expect(exception1.message, message1);
      expect(exception2.message, message2);
    });
  });
}