import 'dart:convert';

import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvDetailResponse = TvDetailResponse(
    backdropPath: "/path.jpg",
    genres: [],
    homepage: "https://google.com",
    id: 1,
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2022-01-01",
    status: "Status",
    tagline: "Tagline",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
    seasons: [],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "backdrop_path": "/path.jpg",
        "genres": [],
        "homepage": "https://google.com",
        "id": 1,
        "original_language": "en",
        "original_name": "Original Name",
        "overview": "Overview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "first_air_date": "2022-01-01",
        "status": "Status",
        "tagline": "Tagline",
        "name": "Name",
        "vote_average": 1.0,
        "vote_count": 1,
        "seasons": [],
      };
      // act
      final result = TvDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "backdrop_path": "/path.jpg",
        "genres": [],
        "homepage": "https://google.com",
        "id": 1,
        "original_language": "en",
        "original_name": "Original Name",
        "overview": "Overview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "first_air_date": "2022-01-01",
        "status": "Status",
        "tagline": "Tagline",
        "name": "Name",
        "vote_average": 1.0,
        "vote_count": 1,
        "seasons": [],
      };
      expect(result, expectedJsonMap);
    });
  });
}
