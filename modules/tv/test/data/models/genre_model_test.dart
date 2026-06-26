import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/genre_model.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'Action');

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {"id": 1, "name": "Action"};
      // act
      final result = GenreModel.fromJson(jsonMap);
      // assert
      expect(result, tGenreModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tGenreModel.toJson();
      // assert
      final expectedJsonMap = {"id": 1, "name": "Action"};
      expect(result, expectedJsonMap);
    });
  });
}
