import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  group('NetworkInfo', () {
    late MockDataConnectionChecker mockDataConnectionChecker;
    late NetworkInfoImpl networkInfo;

    setUp(() {
      mockDataConnectionChecker = MockDataConnectionChecker();
      networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
    });

    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        const tHasConnection = true;

        when(
          mockDataConnectionChecker.hasConnection,
        ).thenAnswer((_) async => tHasConnection);

        final result = await networkInfo.isConnected;

        verify(mockDataConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      },
    );

    test('should return false when there is no connection', () async {
      when(
        mockDataConnectionChecker.hasConnection,
      ).thenAnswer((_) async => false);

      final result = await networkInfo.isConnected;

      expect(result, false);
    });

    test('should return true when there is connection', () async {
      when(
        mockDataConnectionChecker.hasConnection,
      ).thenAnswer((_) async => true);

      final result = await networkInfo.isConnected;

      expect(result, true);
    });

    test('NetworkInfo should use DataConnectionChecker', () async {
      when(
        mockDataConnectionChecker.hasConnection,
      ).thenAnswer((_) async => true);

      final networkInfo2 = NetworkInfoImpl(mockDataConnectionChecker);
      final result = await networkInfo2.isConnected;

      expect(result, true);
    });
  });
}
