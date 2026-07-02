import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/repos/tv_repository.dart';

import '../entities/tv.dart';

class GetOnTheAirTV {
  final TVRepository repository;

  GetOnTheAirTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getOnTheAirTV();
  }
}
