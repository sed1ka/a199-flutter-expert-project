
import 'package:db/database_helper.dart';

abstract class TvLocalDataSource {}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});
}
