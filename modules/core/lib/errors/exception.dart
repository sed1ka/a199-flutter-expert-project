import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ServerException implements Exception {
  ServerException() {
    _logError('Server Exception');
  }

  void _logError(String message) {
    try {
      FirebaseCrashlytics.instance.recordError(message, StackTrace.current);
    } catch (_) {
      // Firebase might not be initialized yet
    }
  }
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message) {
    _logError(message);
  }

  void _logError(String message) {
    try {
      FirebaseCrashlytics.instance.recordError(message, StackTrace.current, reason: 'Database Exception');
    } catch (_) {
      // Firebase might not be initialized yet
    }
  }
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message) {
    _logError(message);
  }

  void _logError(String message) {
    try {
      FirebaseCrashlytics.instance.recordError(message, StackTrace.current, reason: 'Cache Exception');
    } catch (_) {
      // Firebase might not be initialized yet
    }
  }
}
