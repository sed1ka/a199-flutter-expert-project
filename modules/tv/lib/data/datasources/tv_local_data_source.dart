
import 'package:db/database_helper.dart';

abstract class TVLocalDataSource {}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});
}
