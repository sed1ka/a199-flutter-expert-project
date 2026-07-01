import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ServerException implements Exception {
  ServerException() {
    FirebaseCrashlytics.instance.recordError(
      'Server Exception',
      StackTrace.current,
    );
  }
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message) {
    FirebaseCrashlytics.instance.recordError(
      message,
      StackTrace.current,
      reason: 'Database Exception',
    );
  }
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message) {
    FirebaseCrashlytics.instance.recordError(
      message,
      StackTrace.current,
      reason: 'Cache Exception',
    );
  }
}
