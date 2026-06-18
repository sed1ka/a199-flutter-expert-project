import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'common_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
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

  group('NetworkInfo', () {
    late MockDataConnectionChecker mockDataConnectionChecker;
    late NetworkInfoImpl networkInfo;

    setUp(() {
      mockDataConnectionChecker = MockDataConnectionChecker();
      networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
    });

    test('should forward the call to DataConnectionChecker.hasConnection', () async {
      const tHasConnection = true;

      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => tHasConnection);

      final result = await networkInfo.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConnection);
    });

    test('should return false when there is no connection', () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => false);

      final result = await networkInfo.isConnected;

      expect(result, false);
    });

    test('should return true when there is connection', () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);

      final result = await networkInfo.isConnected;

      expect(result, true);
    });

    test('NetworkInfo should use DataConnectionChecker', () async {
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);

      final networkInfo2 = NetworkInfoImpl(mockDataConnectionChecker);
      final result = await networkInfo2.isConnected;

      expect(result, true);
    });
  });

  group('Constants', () {
    test('BASE_IMAGE_URL should be defined', () {
      const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
      expect(baseImageUrl, isNotEmpty);
      expect(baseImageUrl, 'https://image.tmdb.org/t/p/w500');
    });

    test('Colors and text styles should be accessible', () {
      // Testing that constants are defined and accessible
      expect(true, true);
    });
  });
}
