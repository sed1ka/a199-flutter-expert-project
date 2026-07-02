import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/repos/tv_repository.dart';

import '../entities/tv.dart';

class SearchTV {
  final TVRepository repository;

  SearchTV(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchTV(query);
  }
}
