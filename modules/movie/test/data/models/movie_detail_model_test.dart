import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    budget: 100,
    genres: [],
    homepage: "https://google.com",
    id: 1,
    imdbId: "imdb1",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2022-01-01",
    revenue: 100,
    runtime: 100,
    status: "Status",
    tagline: "Tagline",
    title: "Title",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "budget": 100,
        "genres": [],
        "homepage": "https://google.com",
        "id": 1,
        "imdb_id": "imdb1",
        "original_language": "en",
        "original_title": "Original Title",
        "overview": "Overview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "release_date": "2022-01-01",
        "revenue": 100,
        "runtime": 100,
        "status": "Status",
        "tagline": "Tagline",
        "title": "Title",
        "video": false,
        "vote_average": 1.0,
        "vote_count": 1,
      };
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "budget": 100,
        "genres": [],
        "homepage": "https://google.com",
        "id": 1,
        "imdb_id": "imdb1",
        "original_language": "en",
        "original_title": "Original Title",
        "overview": "Overview",
        "popularity": 1.0,
        "poster_path": "/path.jpg",
        "release_date": "2022-01-01",
        "revenue": 100,
        "runtime": 100,
        "status": "Status",
        "tagline": "Tagline",
        "title": "Title",
        "video": false,
        "vote_average": 1.0,
        "vote_count": 1,
      };
      expect(result, expectedJsonMap);
    });
  });
}
