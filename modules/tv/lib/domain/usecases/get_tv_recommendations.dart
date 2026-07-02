import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/repos/tv_repository.dart';

import '../entities/tv.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getTVRecommendations(id);
  }
}
