import 'package:ditonton/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
    airDate: "2022-01-01",
    episodeCount: 1,
    id: 1,
    name: "Season 1",
    overview: "Overview",
    posterPath: "/path.jpg",
    seasonNumber: 1,
  );

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tSeasonModel.toJson();
      final expectedJsonMap = {
        "air_date": "2022-01-01",
        "episode_count": 1,
        "id": 1,
        "name": "Season 1",
        "overview": "Overview",
        "poster_path": "/path.jpg",
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
